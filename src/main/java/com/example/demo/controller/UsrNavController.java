package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrNavController {

	@RequestMapping("/usr/nav/navigation")
	public String showMain() {

		return "/usr/nav/navigation";
	}

}