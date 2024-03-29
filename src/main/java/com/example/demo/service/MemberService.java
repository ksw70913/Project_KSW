package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.MemberRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Service
public class MemberService {
	@Autowired
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public ResultData<Integer> join(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email, String schoollevel, int grade, int postcode, String roadAddress, String jibunAddress,
			String detailAddress, double latitude, double longitude) {

		Member existsMember = getMemberByLoginId(loginId);

		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}

		existsMember = getMemberByNameAndEmail(name, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", name, email));
		}

		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNum, email, schoollevel, grade, postcode,
				roadAddress, jibunAddress, detailAddress, latitude, longitude);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);

	}

	private Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMember(int id) {
		return memberRepository.getMember(id);
	}

	public ResultData modify(int loginedMemberId, String loginPw, String name, String nickname, String cellphoneNum,
			String email, String schoollevel, int grade, int postcode, String roadAddress, String jibunAddress,
			String detailAddress, double latitude, double longitude) {

		memberRepository.modify(loginedMemberId, loginPw, name, nickname, cellphoneNum, email, schoollevel, grade,
				postcode, roadAddress, jibunAddress, detailAddress, latitude, longitude);
		return ResultData.from("S-1", "회원정보 수정 완료");
	}

	public ResultData modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum,
			String email, String schoollevel, int grade, int postcode, String roadAddress, String jibunAddress,
			String detailAddress, double latitude, double longitude) {

		memberRepository.modifyWithoutPw(loginedMemberId, name, nickname, cellphoneNum, email, schoollevel, grade,
				postcode, roadAddress, jibunAddress, detailAddress, latitude, longitude);
		return ResultData.from("S-1", "회원정보 수정 완료");
	}

	public boolean isIDCheck(String id) {
		int isIDCheck = memberRepository.idCheck(id);

		if (isIDCheck == 1) {
			return false;
		}
		return true;
	}

	public ResultData doDelete(int loginedMemberId) {
		memberRepository.doDelete(loginedMemberId);
		return ResultData.from("S-1", "회원탈퇴 완료");
	}

}