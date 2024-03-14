package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Book {
	private int id;
	private String curriculum;
	private int publicationyear;
	private String stateswordrecognition;
	private String datatype;
	private String schoolLevel;
	private String schoolclassification;
	private String title;
	private String author;
	private String publisher;
	private double price;
	private String grade;
	private int boardId;

}