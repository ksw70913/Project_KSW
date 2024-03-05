package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrNavController {

	@RequestMapping("/usr/nav/navigation")
	public String showNavigation() {

		return "/usr/nav/navigation";
	}
	
	@RequestMapping("/usr/nav/school")
	public String showSchool() {

		return "/usr/nav/school";
	}


}