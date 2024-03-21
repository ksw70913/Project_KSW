package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Book {
	private int id;
	private String curriculum; //교육과정
	private int publicationyear;
	private String stateswordrecognition;
	private String datatype;
	private String schoolLevel;
	private String schoolclassification;
	private String title; //제목
	private String author; //저자
	private String publisher; //출판사
	private double price;
	private String grade;
	private int boardId;

}