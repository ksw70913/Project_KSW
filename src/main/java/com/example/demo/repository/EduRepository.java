package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Book;

@Mapper
public interface EduRepository {

	@Select("""
			SELECT *
			FROM book
			""")
	List<Book> bookList();

	@Select("""
			<script>
			SELECT COUNT(*) AS cnt
			FROM book
			WHERE 4
			<if test="boardId != 0">
				AND boardId = #{boardId}
			</if>
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'title'">
						AND title LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<when test="searchKeywordTypeCode == 'grade'">
						AND grade LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<otherwise>
						AND title LIKE CONCAT('%',#{searchKeyword},'%')
						OR grade LIKE CONCAT('%',#{searchKeyword},'%')
					</otherwise>
				</choose>
			</if>
			ORDER BY id DESC
			</script>
			""")
	int getBooksCount(int boardId, String searchKeywordTypeCode, String searchKeyword);

	@Select("""
			<script>
			SELECT *
			FROM book
			WHERE 1
			<if test="boardId != 0">
				AND boardId = #{boardId}
			</if>
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'title'">
						AND title LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<when test="searchKeywordTypeCode == 'grade'">
						AND grade LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<otherwise>
						AND title LIKE CONCAT('%',#{searchKeyword},'%')
						OR grade LIKE CONCAT('%',#{searchKeyword},'%')
					</otherwise>
				</choose>
			</if>
			GROUP BY id
			ORDER BY id DESC
			<if test="limitFrom >= 0 ">
				LIMIT #{limitFrom}, #{limitTake}
			</if>
			</script>
			""")
	List<Book> getForPrintBooks(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode,
			String searchKeyword);

}