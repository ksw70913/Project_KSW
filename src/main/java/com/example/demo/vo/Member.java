package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private int authLevel;
	private String name;
	private String nickname;
	private String cellphoneNum;
	private String email;
	private int postcode;
	private String roadAddress;
	private String jibunAddress;
	private String detailAddress;
	private double latitude;
	private double longitude;
	private String schoollevel;
	private int grade;
	private boolean delStatus;
	private String delDate;

}