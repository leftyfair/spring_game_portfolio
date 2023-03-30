package com.jafa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.jafa.repository.BoardRepository;

@Controller
public class HomeController {
	
	@Autowired
	private BoardRepository repository;

	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("name", "관리");
		model.addAttribute("welcome", "GameLand");
		return "index";
	}
	
//	@GetMapping("/")
//	public String home(Model model, Authentication authentication) {
//		model.addAttribute("name", authentication.getName());
//		model.addAttribute("welcome", "GameLand");
//		return "index";
//	}
}
