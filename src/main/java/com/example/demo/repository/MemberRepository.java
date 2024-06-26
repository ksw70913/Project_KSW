package com.example.demo.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Member;

@Mapper
public interface MemberRepository {
	@Select("""
			SELECT *
			FROM `member`
			WHERE loginId = #{loginId}
			""")
	public Member getMemberByLoginId(String loginId);

	@Select("""
			SELECT *
			FROM `member`
			WHERE name = #{name}
			AND email = #{email}
			""")
	public Member getMemberByNameAndEmail(String name, String email);

	@Insert("""
			INSERT INTO
			`member` SET
			regDate = NOW(),
			updateDate = NOW(),
			loginId = #{loginId},
			loginPw = #{loginPw},
			`name` = #{name},
			nickname = #{nickname},
			cellphoneNum = #{cellphoneNum},
			email = #{email},
			postcode = #{postcode},
			roadAddress = #{roadAddress},
			jibunAddress = #{jibunAddress},
			detailAddress = #{detailAddress},
			schoollevel = #{schoollevel},
			latitude = #{latitude},
			longitude = #{longitude},
			grade = #{grade}
			""")
	public void join(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email,
			String schoollevel, int grade, int postcode, String roadAddress, String jibunAddress, String detailAddress,
			double latitude, double longitude);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("SELECT * FROM `member` WHERE id = #{id}")
	public Member getMember(int id);

	@Update("""
			<script>
			UPDATE `member`
			<set>
				<if test="loginPw != null">
					loginPw = #{loginPw},
				</if>
				<if test="name != null">
					name = #{name},
				</if>
				<if test="nickname != null">
					nickname = #{nickname},
				</if>
				<if test="cellphoneNum != null">
					cellphoneNum = #{cellphoneNum},
				</if>
				<if test="email != null">
					email = #{email},
				</if>
				<if test="schoollevel != null">
					schoollevel = #{schoollevel},
				</if>
				<if test="grade != 0">
					grade = #{grade},
				</if>
				<if test="postcode != 0">
					postcode = #{postcode},
				</if>
				<if test="roadAddress != null">
					roadAddress = #{roadAddress},
				</if>
				<if test="jibunAddress != null">
					jibunAddress = #{jibunAddress},
				</if>
				<if test="detailAddress != null">
					detailAddress = #{detailAddress},
				</if>
				<if test="latitude != 0">
					latitude = #{latitude},
				</if>
				<if test="longitude != 0">
					longitude = #{longitude},
				</if>
				updateDate= NOW()
			</set>
			WHERE id = #{loginedMemberId}
			</script>
			""")
	public void modify(int loginedMemberId, String loginPw, String name, String nickname, String cellphoneNum,
			String email, String schoollevel, int grade, int postcode, String roadAddress, String jibunAddress,
			String detailAddress, double latitude, double longitude);

	@Update("""
			<script>
			UPDATE `member`
			<set>
				<if test="name != null">
					name = #{name},
				</if>
				<if test="nickname != null">
					nickname = #{nickname},
				</if>
				<if test="cellphoneNum != null">
					cellphoneNum = #{cellphoneNum},
				</if>
				<if test="email != null">
					email = #{email},
				</if>
				<if test="schoollevel != null">
					schoollevel = #{schoollevel},
				</if>
				<if test="grade != null">
					grade = #{grade},
				</if>
				<if test="postcode != null">
					postcode = #{postcode},
				</if>
				<if test="roadAddress != null">
					roadAddress = #{roadAddress},
				</if>
				<if test="jibunAddress != null">
					jibunAddress = #{jibunAddress},
				</if>
				<if test="detailAddress != null">
					detailAddress = #{detailAddress},
				</if>
				<if test="latitude != null">
					latitude = #{latitude},
				</if>
				<if test="longitude != null">
					longitude = #{longitude},
				</if>
				updateDate= NOW()
			</set>
			WHERE id = #{loginedMemberId}
			</script>
			""")
	public void modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum, String email,
			String schoollevel, int grade, int postcode, String roadAddress, String jibunAddress, String detailAddress,
			double latitude, double longitude);

	@Select("""
			SELECT COUNT(*)
			FROM `member`
			WHERE loginId = #{id}
			""")
	public int idCheck(String id);

	@Delete("""
			DELETE FROM member
			WHERE id = #{loginedMemberId}
			""")
	public void doDelete(int loginedMemberId);

}