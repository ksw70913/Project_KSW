<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MODIFY"></c:set>
<%@ include file="../common/head2.jspf"%>
<!-- Member modify 관련 -->

<script type="text/javascript">
	let MemberModify__submitFormDone = false;
	function MemberModify__submit(form) {
		if (MemberModify__submitFormDone) {
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value.length == 0) {
				alert('비번 확인 써라');
				form.loginPwConfirm.focus();
				return;
			}
			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비번 불일치');
				form.loginPw.focus();
				return;
			}
		}
		form.name.value = form.name.value.trim();
		form.nickname.value = form.nickname.value.trim();
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		form.email.value = form.email.value.trim();

		MemberModify__submitFormDone = true;
		form.submit();
	}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/* 주소 */

	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('postcode').value = data.zonecode;
						document.getElementById("roadAddress").value = roadAddr;
						document.getElementById("jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
</script>

<style>
/* 주소 */
#postcode-container {
	display: flex;
	align-items: center;
}

#postcode {
	flex: 1;
	margin-right: 10px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}

#postcode-button {
	padding: 10px 20px;
	background-color: #1161ee;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
	/* Add decoration */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

#postcode-button:hover {
	background-color: #0056b3;
}

#address-container {
	margin-top: 10px;
}

#roadAddress, #jibunAddress, #detailAddress, #extraAddress {
	width: calc(100% - 10px);
	/* Adjust width and margin according to your design */
	margin-right: 10px;
	margin-top: 5px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}
</style>

<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<form action="../member/doModify" method="POST" onsubmit="MemberModify__submit(this); return false;">
			<table class="member-modify-box table-box-1" border="1">
				<tbody>
					<tr>
						<th>가입일</th>
						<td>${rq.loginedMember.regDate }</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${rq.loginedMember.loginId }</td>
					</tr>
					<tr>
						<th>새 비밀번호</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
							placeholder="새 비밀번호를 입력해주세요" name="loginPw" /></td>
					</tr>
					<tr>
						<th>새 비밀번호 확인</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
							placeholder="새 비밀번호 확인을 입력해주세요" name="loginPwConfirm" /></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
							placeholder="이름을 입력해주세요" name="name" value="${rq.loginedMember.name }" /></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
							placeholder="닉네임을 입력해주세요" name="nickname" value="${rq.loginedMember.nickname }" /></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
							placeholder="전화번호를 입력해주세요" name="cellphoneNum" value="${rq.loginedMember.cellphoneNum }" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
							placeholder="이메일을 입력해주세요" name="email" value="${rq.loginedMember.email }" /></td>
					</tr>
					<tr>
						<th>우편주소</th>
						<td><input type="text" id="postcode" name="postcode" value="${rq.loginedMember.postcode }" placeholder="우편번호"> <input type="button"
							id="postcode-button" onclick="execDaumPostcode()" value="우편번호 찾기"><br> <input type="text"
							id="roadAddress" name="roadAddress" value="${rq.loginedMember.roadAddress }" placeholder="도로명주소"> <input type="text" id="jibunAddress"
							name="jibunAddress" value="${rq.loginedMember.jibunAddress }" placeholder="지번주소"> <span id="guide" style="color: #999; display: none"></span> <input
							type="text" id="detailAddress" value="${rq.loginedMember.detailAddress }" name="detailAddress" placeholder="상세주소"> <input type="text"
							id="extraAddress" placeholder="참고항목"></td>
					</tr>
					<tr>
						<th>학교급</th>
						<td><select data-value="${rq.loginedMember.schoollevel }"
							class="select select-bordered select-sm w-full max-w-xs" name="schoollevel">
								<option value="primary">초등학교</option>
								<option value="middle">중학교</option>
								<option value="high">고등학교</option>
						</select></td>
					</tr>
					<tr>
						<th>학년</th>
						<td><select data-value="${rq.loginedMember.grade }" class="select select-bordered select-sm w-full max-w-xs"
							name="grade">
								<option value="1">1학년</option>
								<option value="2">2학년</option>
								<option value="3">3학년</option>
								<option value="4">4학년</option>
								<option value="5">5학년</option>
								<option value="6">6학년</option>
						</select></td>
					</tr>

					<tr>
						<th></th>
						<td><input class="btn btn-outline btn-info" type="submit" value="수정" /></td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn btn-outline" class="" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>