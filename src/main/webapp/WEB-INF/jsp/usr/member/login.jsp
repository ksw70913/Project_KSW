<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN &amp; JOIN"></c:set>
<%@ include file="../common/head.jspf"%>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var signInTab = document.querySelector('.sign-in');
		var signUpTab = document.querySelector('.sign-up');
		var loginWrap = document.querySelector('.login-wrap');

		signInTab.addEventListener('click', function() {
			loginWrap.style.height = '625px';
		});

		signUpTab.addEventListener('click', function() {
			loginWrap.style.height = '1500px';
		});
	});
</script>
<script>
	$(document).ready(function() {
		$("#checkDuplicate").click(function() {
			var id = $("#loginId").val();

			if (id.trim() === '') {
				$("#idCheckMessage").text("아이디를 입력해주세요.");
				return;
			}

			$.ajax({
				type : "POST",
				url : "/idCheck",
				data : {
					id : id
				},
				success : function(data) {
					if (data === "true") {
						$("#idCheckMessage").text("사용 가능한 아이디입니다.");
					} else if (data === "false") {
						$("#idCheckMessage").text("중복된 아이디입니다.");
					}
				},
				error : function() {
					$("#idCheckMessage").text("서버와의 통신 중 오류가 발생했습니다.");
				}
			});
		});

		$("#signupForm").submit(function() {
			// Disable duplicate checking
			$("#checkDuplicate").prop("disabled", true);

			// Check if the ID is available
			if ($("#idCheckMessage").text() !== "사용 가능한 아이디입니다.") {
				alert("아이디를 다시 확인해주세요.");
				// Re-enable duplicate checking
				$("#checkDuplicate").prop("disabled", false);
				return false;
			}
		});
	});
</script>

<script>
	$(document).ready(
			function() {
				$("input[name='loginPw'], input[name='loginPw2']").on(
						"input",
						function() {
							var password = $("#loginPw").val(); // Targeting by ID instead of name
							var confirmPassword = $("#loginPw2").val(); // Targeting by ID instead of name
							if (password !== confirmPassword) {
								$("#passwordMatchMessage").text(
										"Password does not match."); // Update message content
							} else {
								$("#passwordMatchMessage").text(""); // Clear message content if passwords match
							}
						});
			});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
nav {
	margin: 0;
	color: #6a6f8c;
	background: #F4CFC6;
	font: 600 16px/18px 'Open Sans', sans-serif;
}

*, :after, :before {
	box-sizing: border-box
}

.clearfix:after, .clearfix:before {
	content: '';
	display: table
}

.clearfix:after {
	clear: both;
	display: block
}

a {
	color: inherit;
	text-decoration: none
}

.login-wrap {
	width: 100%;
	margin: auto;
	max-width: 525px;
	min-height: 625px;
	position: relative;
	background:
		/* url(https://raw.githubusercontent.com/khadkamhn/day-01-login-form/master/img/bg.jpg) */
		no-repeat center;
	box-shadow: 0 12px 15px 0 rgba(0, 0, 0, .24), 0 17px 50px 0
		rgba(0, 0, 0, .19);
}

.login-html {
	width: 100%;
	height: 100%;
	position: absolute;
	padding: 90px 70px 50px 70px;
	background: rgba(40, 57, 101, .9);
}

.login-html .sign-in-htm, .login-html .sign-up-htm {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	position: absolute;
	transform: rotateY(180deg);
	backface-visibility: hidden;
	transition: all .4s linear;
}

.login-html .sign-in, .login-html .sign-up, .login-form .group .check {
	display: none;
}

.login-html .tab, .login-form .group .label, .login-form .group .button
	{
	text-transform: uppercase;
}

.login-html .tab {
	font-size: 22px;
	margin-right: 15px;
	padding-bottom: 5px;
	margin: 0 15px 10px 0;
	display: inline-block;
	border-bottom: 2px solid transparent;
}

.login-html .sign-in:checked+.tab, .login-html .sign-up:checked+.tab {
	color: #fff;
	border-color: #1161ee;
}

.login-form {
	min-height: 345px;
	position: relative;
	perspective: 1000px;
	transform-style: preserve-3d;
}

.login-form .group {
	margin-bottom: 15px;
}

.login-form .group .label, .login-form .group .input, .login-form .group .button
	{
	width: 100%;
	color: #fff;
	display: block;
}

.login-form .group .input, .login-form .group .button {
	border: none;
	padding: 15px 20px;
	border-radius: 25px;
	background: rgba(255, 255, 255, .1);
}

.login-form .group input[data-type="password"] {
	text-security: circle;
	-webkit-text-security: circle;
}

.login-form .group .label {
	color: #aaa;
	font-size: 12px;
}

.login-form .group .button {
	background: #1161ee;
}

.login-form .group label .icon {
	width: 15px;
	height: 15px;
	border-radius: 2px;
	position: relative;
	display: inline-block;
	background: rgba(255, 255, 255, .1);
}

.login-form .group label .icon:before, .login-form .group label .icon:after
	{
	content: '';
	width: 10px;
	height: 2px;
	background: #fff;
	position: absolute;
	transition: all .2s ease-in-out 0s;
}

.login-form .group label .icon:before {
	left: 3px;
	width: 5px;
	bottom: 6px;
	transform: scale(0) rotate(0);
}

.login-form .group label .icon:after {
	top: 6px;
	right: 0;
	transform: scale(0) rotate(0);
}

.login-form .group .check:checked+label {
	color: #fff;
}

.login-form .group .check:checked+label .icon {
	background: #1161ee;
}

.login-form .group .check:checked+label .icon:before {
	transform: scale(1) rotate(45deg);
}

.login-form .group .check:checked+label .icon:after {
	transform: scale(1) rotate(-45deg);
}

.login-html .sign-in:checked+.tab+.sign-up+.tab+.login-form .sign-in-htm
	{
	transform: rotate(0);
}

.login-html .sign-up:checked+.tab+.login-form .sign-up-htm {
	transform: rotate(0);
}

.hr {
	height: 2px;
	margin: 60px 0 50px 0;
	background: rgba(255, 255, 255, .2);
}

.foot-lnk {
	text-align: center;
}

.login-html .sign-in:checked+.tab+.sign-up+.tab+.login-form .sign-in-htm
	{
	transform: rotate(0);
	height: 625px; /* 변경된 높이 */
}

.login-html .sign-up:checked+.tab+.login-form .sign-up-htm {
	transform: rotate(0);
	height: 1000px; /* 변경된 높이 */
}

#checkDuplicate {
	padding: 10px 20px;
	background-color: #ff6b6b; /* Changed button color */
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px; /* Reduced font size */
	transition: background-color 0.3s ease;
	margin-top: 5px;
}

#checkDuplicate:hover {
	background-color: #d63031; /* Darker color on hover */
}

#passwordMatchMessage {
	color: red; /* Change text color to red */
}

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


<section>
	<nav>
		<div class="login-wrap sign-wrap">
			<div class="login-html">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign
					In</label> <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>
				<div class="login-form">
					<form action="../member/doLogin" method="POST">
						<div class="sign-in-htm">
							<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
							<div class="group">
								<label for="user" class="label">ID</label> <input name="loginId" type="text" class="input">
							</div>
							<div class="group">
								<label for="pass" class="label">Password</label> <input name="loginPw" type="password" class="input"
									data-type="password">
							</div>
							<div class="group">
								<input id="check" type="checkbox" class="check" checked> <label for="check"><span class="icon"></span>
									Keep me Signed in</label>
							</div>
							<div class="group">
								<input type="submit" class="button" value="Sign In">
							</div>
							<div class="hr"></div>
							<div class="foot-lnk">
								<a href="#forgot">Forgot Password?</a>
							</div>
						</div>
					</form>
					<div class="sign-up-htm">
						<div class="join-form">
							<form action="../member/doJoin" method="POST" id="signupForm">
								<div class="group">
									<label for="user" class="label">아이디</label> <input name="loginId" id="loginId" type="text" class="input">
									<button type="button" id="checkDuplicate">중복 체크</button>
									<span id="idCheckMessage"></span>
								</div>
								<div class="group loginPw">
									<label for="pass" class="label">비밀번호</label> <input id="loginPw" name="loginPw" type="password" class="input"
										data-type="password">
								</div>
								<div class="group loginPw2">
									<label for="pass" class="label">비밀번호 확인</label> <input id="loginPw2" name="loginPw2" type="password"
										class="input" data-type="password">
								</div>
								<div id="passwordMatchMessage"></div>
								<div class="group">
									<label for="pass" class="label">이메일</label> <input name="email" type="text" class="input">
								</div>
								<div class="group">
									<label for="pass" class="label">이름</label> <input name="name" type="text" class="input">
								</div>
								<div class="group">
									<label for="pass" class="label">닉네임</label> <input name="nickname" type="text" class="input">
								</div>
								<div class="group">
									<label for="pass" class="label">전화번호</label> <input name="cellphoneNum" type="text" class="input">
								</div>
								<div class="group">
									<input type="text" id="postcode" name="postcode" placeholder="우편번호"> <input type="button" id= "postcode-button" onclick="execDaumPostcode()"
										value="우편번호 찾기"><br> <input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소"> <input
										type="text" id="jibunAddress" name="jibunAddress" placeholder="지번주소"> <span id="guide" style="color: #999; display: none"></span>
									<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"> <input type="text" id="extraAddress"
										placeholder="참고항목">
								</div>
								<div class="group">
									<label for="pass" class="label">학교급</label> <select class="select select-bordered select-sm w-full max-w-xs"
										name="schoollevel">
										<option value="primary">초등학교</option>
										<option value="middle">중학교</option>
										<option value="high">고등학교</option>
									</select>
								</div>
								<div class="group">
									<label for="pass" class="label">학년</label> <select class="select select-bordered select-sm w-full max-w-xs"
										name="grade">
										<option value="1">1학년</option>
										<option value="2">2학년</option>
										<option value="3">3학년</option>
										<option value="4">4학년</option>
										<option value="5">5학년</option>
										<option value="6">6학년</option>
									</select>
								</div>
						</div>
						<div class="group">
							<input type="submit" class="button" value="Sign Up">
						</div>
						<div class="hr"></div>
						<div class="foot-lnk">
							<label for="tab-1">Already Member?</a>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		</div>
	</nav>
</section>



<%-- <%@ include file="../common/foot.jspf"%> --%>