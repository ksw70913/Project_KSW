package com.example.demo.controller;

import com.example.demo.service.CSVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrCSVController {

	@Autowired
	private CSVService csvService;

	@GetMapping("/readAndSaveToDB")
	@ResponseBody
	public String readAndSaveToDB() {
		return csvService.readAndSaveToDB();
	}
	
	@GetMapping("/readAndSaveToDBchildzone")
	@ResponseBody
	public String readAndSaveToDBchildzone() {
		return csvService.readAndSaveToDBchildzone();
	}
	
	@GetMapping("/readAndSaveToDBSchool")
	@ResponseBody
	public String readAndSaveToDBSchool() {
		return csvService.readAndSaveToDBSchool();
	}
}