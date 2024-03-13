package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class School {
	private int id;
	private String schoolID;
	private String schoolName;
	private String schoolLevel;
	private String establishmentDate;
	private String establishmentType;
	private String classification;
	private String state;
	private String jibunaddress;
	private String roadaddress;
	private int educationOfficeCode;
	private String educationOffice;
	private int educationSupportOfficeCode;
	private String educationSupportOffice;
	private double latitude;
	private double longitude;

}