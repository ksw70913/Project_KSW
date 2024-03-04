package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrEduController {

	@RequestMapping("/usr/edu/book")
	public String showBook() {

		return "/usr/edu/book";
	}
	
	@RequestMapping("/usr/edu/education")
	public String showEducation() {

		return "/usr/edu/education";
	}

}