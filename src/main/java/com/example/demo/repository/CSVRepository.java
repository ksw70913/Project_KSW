package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Book;

@Mapper
public interface CSVRepository {

	@Insert({ "<script>",
			"INSERT INTO book (curriculum, publicationyear, stateswordrecognition, datatype, schoolLevel, schoolclassification, title, author, publisher, price, grade) VALUES ",
			"<foreach collection='csvList' item='item' index='index' separator=','>",
			"(#{item.curriculum}, #{item.publicationyear}, #{item.stateswordrecognition}, #{item.datatype}, #{item.schoolLevel}, #{item.schoolclassification}, #{item.title}, #{item.author}, #{item.publisher}, #{item.price}, #{item.grade})",
			"</foreach>", "</script>" })
	void insertCSVList(List<Book> csvList);
}