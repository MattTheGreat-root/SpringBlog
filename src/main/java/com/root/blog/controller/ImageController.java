package com.root.blog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Optional;
import java.util.UUID;

@Controller
public class ImageController {

    private static final String SECRET_CODE = "n1ghtcrawler";

    @GetMapping("/upload-image")
    public String uploadImageForm(@RequestParam Optional<String> secret, Model model) {
        if (secret.isEmpty() || !secret.get().equals(SECRET_CODE)) {
            return "redirect:/";
        }
        return "upload";
    }

    @PostMapping("/upload-image")
    public String handleImageUpload(@RequestParam("image") MultipartFile image,
                                    @RequestParam Optional<String> secret,
                                    Model model) throws IOException {
        if (secret.isEmpty() || !secret.get().equals(SECRET_CODE)) {
            return "redirect:/";
        }

        if (!image.isEmpty()) {
            String filename = UUID.randomUUID() + "_" + image.getOriginalFilename();
            Path path = Paths.get("uploads", filename);
            Files.createDirectories(path.getParent());
            Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            model.addAttribute("imageUrl", "/uploads/" + filename);
        }

        return "upload";
    }
}
