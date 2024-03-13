package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Book;
import com.example.demo.vo.Learning;

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

	@Select("""
			SELECT *
			FROM book
			WHERE id = #{id}
			""")
	Book getForPrintBook(int id);

	@Select("""
			SELECT *
			FROM learning
			WHERE memberId = #{loginedMemberId}
			AND bookId = #{id}
			""")
	Learning getLearning(int loginedMemberId, int id);

	@Select("""
			SELECT *
			FROM learning
			WHERE memberId = #{loginedMemberId}
			""")
	List<Learning> getBookStatus(int loginedMemberId);

	@Insert("""
			INSERT INTO
			learning SET
			memberId = #{loginedMemberId},
			bookId = #{id},
			title = #{title},
			learning = 0
			""")
	void addBook(int loginedMemberId, int id, String title);

}