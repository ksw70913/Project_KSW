package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

	@Select("""
			SELECT *
			FROM learning
			WHERE memberId = #{loginedMemberId}
			AND bookId = 102208
						""")
	Learning getStatus(int loginedMemberId);

	@Update("""
			UPDATE learning
			SET learning = #{learning}
			WHERE id = #{id}
			AND memberId = #{loginedMemberId}
			""")
	void doLearning(int loginedMemberId, int id, int learning);

	@Delete("""
			DELETE FROM learning
			WHERE id = #{id}
			AND memberid = #{loginedMemberId}
			""")
	void doDelete(int loginedMemberId, int id);

	@Select("""
			<script>
			SELECT COUNT(*) AS cnt
			FROM book
			WHERE 4
			<if test="boardId != 0">
				AND boardId = #{boardId}
			</if>
			<if test="searchKeyword1 != null and !searchKeyword1.isEmpty()">
			AND ${searchKeywordTypeCode1} LIKE CONCAT('%',#{searchKeyword1},'%')
			</if>
			<if test="searchKeyword2 != null and !searchKeyword2.isEmpty()">
			AND ${searchKeywordTypeCode2} LIKE CONCAT('%',#{searchKeyword2},'%')
			</if>
			<if test="searchKeyword3 != null and !searchKeyword3.isEmpty()">
			AND ${searchKeywordTypeCode3} LIKE CONCAT('%',#{searchKeyword3},'%')
			</if>
			ORDER BY id DESC
			</script>
			""")
	int getBooksCount(int boardId, String searchKeywordTypeCode1, String searchKeywordTypeCode2,
			String searchKeywordTypeCode3, String searchKeyword1, String searchKeyword2, String searchKeyword3);

	@Select("""
			<script>
			SELECT *
			FROM book
			WHERE 1
			<if test="boardId != 0">
				AND boardId = #{boardId}
			</if>
			<if test="searchKeyword1 != null and !searchKeyword1.isEmpty()">
			AND ${searchKeywordTypeCode1} LIKE CONCAT('%',#{searchKeyword1},'%')
			</if>
			<if test="searchKeyword2 != null and !searchKeyword2.isEmpty()">
			AND ${searchKeywordTypeCode2} LIKE CONCAT('%',#{searchKeyword2},'%')
			</if>
			<if test="searchKeyword3 != null and !searchKeyword3.isEmpty()">
			AND ${searchKeywordTypeCode3} LIKE CONCAT('%',#{searchKeyword3},'%')
			</if>
			GROUP BY id
			ORDER BY id DESC
			<if test="limitFrom >= 0 ">
				LIMIT #{limitFrom}, #{limitTake}
			</if>
			</script>
			""")
	List<Book> getForPrintBooks(int boardId, String searchKeywordTypeCode1, String searchKeywordTypeCode2,
			String searchKeywordTypeCode3, String searchKeyword1, String searchKeyword2, String searchKeyword3,
			int limitFrom, int limitTake);

}