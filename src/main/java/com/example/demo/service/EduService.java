package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.EduRepository;
import com.example.demo.vo.Book;

@Service
public class EduService {

	@Autowired
	private EduRepository eduRepository;

	public EduService(EduRepository eduRepository) {
		this.eduRepository = eduRepository;
	}

	// 서비스 메서드

	public int getBooksCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return eduRepository.getBooksCount(boardId, searchKeywordTypeCode, searchKeyword);
	}

	public List<Book> getForPrintBooks(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode,
			String searchKeyword) {
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return eduRepository.getForPrintBooks(boardId, limitFrom, limitTake, searchKeywordTypeCode, searchKeyword);

	}
}