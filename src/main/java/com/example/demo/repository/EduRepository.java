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
			FROM book AS B
			WHERE 4
			<if test="boardId != 0">
				AND boardId = #{boardId}
			</if>
			<if test="searchKeyword != ''">
				<choose>
					<when test="searchKeywordTypeCode == 'title'">
						AND B.서명 LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<when test="searchKeywordTypeCode == 'body'">
						AND B.사용학년 LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<otherwise>
						AND B.서명 LIKE CONCAT('%',#{searchKeyword},'%')
						OR B.사용학년 LIKE CONCAT('%',#{searchKeyword},'%')
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
					<when test="searchKeywordTypeCode == '서명'">
						AND 서명 LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<when test="searchKeywordTypeCode == '사용학년'">
						AND 사용학년 LIKE CONCAT('%',#{searchKeyword},'%')
					</when>
					<otherwise>
						AND 서명 LIKE CONCAT('%',#{searchKeyword},'%')
						OR 사용학년 LIKE CONCAT('%',#{searchKeyword},'%')
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