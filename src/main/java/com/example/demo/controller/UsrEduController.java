package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.BoardService;
import com.example.demo.service.EduService;
import com.example.demo.vo.Board;
import com.example.demo.vo.Book;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrEduController {

	@Autowired
	private Rq rq;

	@Autowired
	private EduService eduService;

	@Autowired
	private BoardService boardService;

	@RequestMapping("/usr/edu/book")
	public String showBook(HttpServletRequest req, Model model, @RequestParam(defaultValue = "4") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "서명,사용학년") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Rq rq = (Rq) req.getAttribute("rq");

		Board board = boardService.getBoardById(boardId);

		int booksCount = eduService.getBooksCount(boardId, searchKeywordTypeCode, searchKeyword);
		System.err.println(booksCount);
		if (board == null) {
			return rq.historyBackOnView("없는 게시판이야");
		}

		// 한페이지에 글 10개씩이야
		// 글 20개 -> 2 page
		// 글 24개 -> 3 page
		int itemsInAPage = 10;

		int totalPage = (int) Math.ceil(booksCount / (double) itemsInAPage);

		int pageSize = 10; // 한 화면에 보여줄 페이지 갯수 -> 10개
		int pageGroup = (int) Math.ceil((double) page / pageSize); // 한번에 보여줄 페이지의 그룹
		int from = ((pageGroup - 1) * pageSize) + 1; // 한번에 보여줄 때의 첫번째 페이지 번호
		int end = pageGroup * pageSize; // 한번에 보여줄 때의 마지막 페이지 번호

		List<Book> books = eduService.getForPrintBooks(boardId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		req.setAttribute("searchKeyword", searchKeyword);
		req.setAttribute("page", page);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("pageGroup", pageGroup);
		req.setAttribute("from", from);
		req.setAttribute("end", end);

		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("booksCount", booksCount);
		model.addAttribute("books", books);

		return "/usr/edu/book";
	}

	@RequestMapping("/usr/edu/education")
	public String showEducation() {

		return "/usr/edu/education";
	}

}