package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Learning {
	private int id;
	private int memberId;
	private int bookId;
	private String title;
	private int learning;

}