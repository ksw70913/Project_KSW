package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.repository.MemberRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Service
public class MemberService {

	@Value("${custom.siteMainUri}")
	private String siteMainUri;

	@Value("${custom.siteName}")
	private String siteName;

	@Autowired
	private MailService mailService;

	@Autowired
	private MemberRepository memberRepository;

	public MemberService(MailService mailService, MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
		this.mailService = mailService;
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

	public ResultData notifyTempLoginPwByEmail(Member actor) {
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Ut.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData;
		}

		setTempPassword(actor, tempPassword);

		return ResultData.from("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");
	}

	private void setTempPassword(Member actor, String tempPassword) {
		memberRepository.modify(actor.getId(), tempPassword, null, null, null, null, null, 0, 0, null, null, null, 0, 0);
	}

}