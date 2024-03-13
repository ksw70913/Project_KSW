package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChildZone {
	private int id;
	private String schoolLevel;
	private String facilityname;
	private String roadaddress;
	private String jibunaddress;
	private double latitude;
	private double longitude;
	private String managementagency;
	private String police;
	private String cctvinstallation;
	private String cctvcount;
	private String protectedarea;
	private String datastandarddate;
	private int providercode;
	private String providername;

}