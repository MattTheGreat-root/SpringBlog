package com.root.blog.controller;

import com.root.blog.model.BlogPost;
import com.root.blog.repository.BlogPostRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Optional;

@Controller
public class BlogController {

    private final BlogPostRepository repository;
    @Value("${blog.secret}")
    private String SECRET_CODE;

    public BlogController(BlogPostRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/new")
    public String newPostForm(@RequestParam Optional<String> secret, Model model) {
        if (secret.isEmpty() || !secret.get().equals(SECRET_CODE)) {
            return "redirect:/";
        }
        model.addAttribute("post", new BlogPost());
        return "new";
    }

    @PostMapping("/new")
    public String createPost(@RequestParam Optional<String> secret, @ModelAttribute BlogPost post) {
        if (secret.isEmpty() || !secret.get().equals(SECRET_CODE)) {
            return "redirect:/";
        }
        repository.save(post);
        return "redirect:/";
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("posts", repository.findAll());
        return "home";
    }

    @GetMapping("/post/{id}")
    public String post(@PathVariable Long id, Model model) {
        BlogPost post = repository.findById(id).orElseThrow();
        model.addAttribute("post", post);
        return "post";
    }
}
