package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.EduRepository;
import com.example.demo.vo.Book;
import com.example.demo.vo.Learning;
import com.example.demo.vo.ResultData;

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

	public List<Book> getForPrintBooks(int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword,
			int boardId) {

		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return eduRepository.getForPrintBooks(limitFrom, limitTake, searchKeywordTypeCode, searchKeyword, boardId);
	}

	public Book getForPrintBook(int id) {
		return eduRepository.getForPrintBook(id);
	}

	public Learning getLearning(int loginedMemberId, int id) {
		return eduRepository.getLearning(loginedMemberId, id);
	}

	public ResultData<Integer> addBook(int loginedMemberId, int id, String title) {
		eduRepository.addBook(loginedMemberId, id, title);

		return ResultData.from("S-1", "교과서가 등록되었습니다.");
	}

	public List<Learning> getBookStatus(int loginedMemberId) {
		return eduRepository.getBookStatus(loginedMemberId);
	}

	public Learning getStatus(int loginedMemberId) {
		return eduRepository.getStatus(loginedMemberId);
	}

	public ResultData<Integer> doLearning(int loginedMemberId, int id, int learning) {
		eduRepository.doLearning(loginedMemberId, id, learning);

		return ResultData.from("S-1", "수치가 수정되었습니다.");
	}

	public ResultData<Integer> doDelete(int loginedMemberId, int id) {

		 eduRepository.doDelete(loginedMemberId, id);
		 
		 return ResultData.from("S-1", "학습 내용이 삭제되었습니다.");
	}

}