package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Book;
import com.example.demo.vo.ChildZone;
import com.example.demo.vo.School;

@Mapper
public interface CSVRepository {

	@Insert({ "<script>",
			"INSERT INTO book (curriculum, publicationyear, stateswordrecognition, datatype, schoolLevel, schoolclassification, title, author, publisher, price, grade) VALUES ",
			"<foreach collection='csvList' item='item' index='index' separator=','>",
			"(#{item.curriculum}, #{item.publicationyear}, #{item.stateswordrecognition}, #{item.datatype}, #{item.schoolLevel}, #{item.schoolclassification}, #{item.title}, #{item.author}, #{item.publisher}, #{item.price}, #{item.grade})",
			"</foreach>", "</script>" })
	void insertCSVList(List<Book> csvList);

	@Insert({ "<script>",
			"INSERT INTO childzone (schoolLevel, facilityname, roadaddress, jibunaddress, latitude, longitude, managementagency, police, cctvinstallation, cctvcount, protectedarea, datastandarddate, providercode, providername) VALUES ",
			"<foreach collection='csvList' item='item' index='index' separator=','>",
			"(#{item.schoolLevel}, #{item.facilityname}, #{item.roadaddress}, #{item.jibunaddress}, #{item.latitude}, #{item.longitude}, #{item.managementagency}, #{item.police}, #{item.cctvinstallation}, #{item.cctvcount}, #{item.protectedarea}, #{item.datastandarddate}, #{item.providercode}, #{item.providername})",
			"</foreach>", "</script>" })
	void insertCSVListChildZone(List<ChildZone> csvList);

	@Insert({ "<script>",
			"INSERT INTO school (schoolID, schoolName, schoolLevel, establishmentDate, establishmentType, classification, state, jibunaddress, roadaddress, educationOfficeCode, educationOffice, educationSupportOfficeCode, educationSupportOffice, latitude, longitude) VALUES ",
			"<foreach collection='csvList' item='item' index='index' separator=','>",
			"(#{item.schoolID}, #{item.schoolName}, #{item.schoolLevel}, #{item.establishmentDate}, #{item.establishmentType}, #{item.classification}, #{item.state}, #{item.jibunaddress}, #{item.roadaddress}, #{item.educationOfficeCode}, #{item.educationOffice}, #{item.educationSupportOfficeCode}, #{item.educationSupportOffice}, #{item.latitude}, #{item.longitude})",
			"</foreach>", "</script>" })
	void insertCSVListSchool(List<School> csvList);
}