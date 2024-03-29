package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.MemberService;
import com.example.demo.service.NavService;
import com.example.demo.vo.ChildZone;
import com.example.demo.vo.Member;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrNavController {

	@Autowired
	private NavService navService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private Rq rq;

	@RequestMapping("/usr/nav/school")
	public String showSchool(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		Member memberInfo = rq.getLoginedMember();

		model.addAttribute("memberInfo", memberInfo);
		return "/usr/nav/school";
	}

	@RequestMapping("/usr/nav/navi")
	public String showNavi(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		Member memberInfo = rq.getLoginedMember();

		model.addAttribute("memberInfo", memberInfo);

		return "/usr/nav/navi";
	}

}