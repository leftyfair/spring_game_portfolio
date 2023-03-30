package com.jafa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jafa.domain.GameVO;
import com.jafa.repository.GameRepository;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order")
@Log4j
public class OrderController {

	@Autowired
	GameRepository gameRepository;
	
	@GetMapping("/payment")
	public String payForm(Long gno, Model model) {
		System.out.println("=======================================" + gno);
		GameVO vo = gameRepository.detail(gno);
		model.addAttribute("pay", vo);
		return "order/gamePayment";
	}
	
}
