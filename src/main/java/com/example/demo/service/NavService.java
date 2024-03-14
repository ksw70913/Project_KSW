package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.NavRepository;
import com.example.demo.vo.ChildZone;

@Service
public class NavService {

	@Autowired
	private NavRepository navRepository;

	public NavService(NavRepository navRepository) {
		this.navRepository = navRepository;
	}

	// 서비스 메서드

	public List<ChildZone> getChildzones() {
		return navRepository.getChildzones();
	}

}