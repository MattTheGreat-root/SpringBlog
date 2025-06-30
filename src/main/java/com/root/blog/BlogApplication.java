package com.root.blog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.root.blog.model.BlogPost;
import com.root.blog.repository.BlogPostRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;

import java.time.LocalDateTime;

@SpringBootApplication
public class BlogApplication {

	public static void main(String[] args) {
		SpringApplication.run(BlogApplication.class, args);
	}

	@Bean
	CommandLineRunner initData(BlogPostRepository repo) {
		return args -> {
			BlogPost post1 = new BlogPost();
			post1.setTitle("Welcome to My Blog");
			post1.setContent("<p>This is the first post with <strong>HTML content</strong>.</p>");
			post1.setCreatedAt(LocalDateTime.of(2024, 6, 25, 14, 0));
			repo.save(post1);

			BlogPost post2 = new BlogPost();
			post2.setTitle("My Second Post");
			post2.setContent("<p>This one has a custom date.</p>");
			post2.setCreatedAt(LocalDateTime.of(2024, 12, 15, 10, 0));
			repo.save(post2);
		};
	}

}
