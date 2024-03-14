package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Book;
import com.example.demo.vo.ChildZone;
import com.example.demo.vo.Learning;

@Mapper
public interface NavRepository {

	@Select("""
			SELECT *
			FROM childzone
			""")
	List<ChildZone> getChildzones();

}