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
		// Function to hide ID check message
		function hideIdCheckMessage() {
			$("#idCheckMessage").hide();
		}

		// Function to show ID check message
		function showIdCheckMessage(message) {
			$("#idCheckMessage").text(message).show();
		}

		// Click event for checking duplicate ID
		$("#checkDuplicate").click(function() {
			var id = $("#loginId").val();

			if (id.trim() === '') {
				showIdCheckMessage("아이디를 입력해주세요.");
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
						showIdCheckMessage("사용 가능한 아이디입니다.");
						$("#idCheckMessage").css("color",
						"green");
					} else if (data === "false") {
						showIdCheckMessage("중복된 아이디입니다.");
						$("#idCheckMessage").css("color",
						"red");
					}
				},
				error : function() {
					showIdCheckMessage("서버와의 통신 중 오류가 발생했습니다.");
				}
			});
		});

		// Submit event for signup form
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

		// Hide ID check message when typing in login ID input
		$("#loginId").on("input", function() {
			hideIdCheckMessage();
		});
	});
</script>

<script>
	$(document).ready(
			function() {
				$("input[name='loginPw'], input[name='loginPw2']")
						.on(
								"input",
								function() {
									var password = $("#loginPw").val(); // Targeting by ID instead of name
									var confirmPassword = $("#loginPw2").val(); // Targeting by ID instead of name
									if (password !== confirmPassword) {
										$("#passwordMatchMessage").text(
												"비밀번호가 일치하지 않습니다."); // Update message content
										$("#passwordMatchMessage").css("color",
												"red"); // Change text color to green
									} else {
										$("#passwordMatchMessage").text(
												"비밀번호가 일치합니다."); // Clear message content if passwords match
										$("#passwordMatchMessage").css("color",
												"green"); // Change text color to green
									}
								});
			});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85425c32b3a10c0c8fef41ad4e316852&libraries=services"
	type="text/javascript"></script>
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
						// Find latitude and longitude coordinates
						const geocoder = new kakao.maps.services.Geocoder();
						geocoder
								.addressSearch(
										data.roadAddress,
										function(result, status) {
											if (status === kakao.maps.services.Status.OK) {
												var latitude = result[0].y;
												var longitude = result[0].x;
												document
														.getElementById('latitude').value = latitude;
												document
														.getElementById('longitude').value = longitude;
											}
										});
					}
				}).open();
	}
</script>

<script>
	// 아이디 유효성 검사
	document.addEventListener('DOMContentLoaded', function() {
		// 아이디 입력창 정보 가져오기
		let elInputUsername = document.querySelector('#loginId'); // input#username
		// 실패 메시지 정보 가져오기 (글자수 제한: 4~12글자)
		let elFailureMessage = document.querySelector('.failure-message'); // div.failure-message.hide
		// 실패 메시지2 정보 가져오기 (영어 또는 숫자)
		let elFailureMessageTwo = document.querySelector('.failure-message2'); // div.failure-message2.hide
		// 중복 확인 버튼 가져오기
		let checkDuplicateButton = document.getElementById('checkDuplicate');

		function idLength(value) {
			return value.length >= 4 && value.length <= 12;
		}

		function onlyNumberAndEnglish(str) {
			return /^[A-Za-z0-9][A-Za-z0-9]*$/.test(str);
		}

		elInputUsername.onkeyup = function() {
			// 값이 입력된 경우
			if (elInputUsername.value.length !== 0) {
				// 영어 또는 숫자 외의 값을 입력했을 경우
				if (onlyNumberAndEnglish(elInputUsername.value) === false) {
					elFailureMessage.classList.add('hide');
					elFailureMessageTwo.classList.remove('hide'); // 영어 또는 숫자만 가능합니다
					checkDuplicateButton.disabled = true; // 중복 확인 버튼 비활성화
				}
				// 글자 수가 4~12글자가 아닐 경우
				else if (idLength(elInputUsername.value) === false) {
					elFailureMessage.classList.remove('hide'); // 아이디는 4~12글자이어야 합니다
					elFailureMessageTwo.classList.add('hide'); // 실패 메시지2가 가려져야 함
					checkDuplicateButton.disabled = true; // 중복 확인 버튼 비활성화
				}
				// 모든 조건이 충족될 경우
				else {
					elFailureMessage.classList.add('hide'); // 실패 메시지 숨기기
					elFailureMessageTwo.classList.add('hide'); // 실패 메시지2 숨기기
					checkDuplicateButton.disabled = false; // 중복 확인 버튼 활성화
				}
			}
			// 값이 입력되지 않은 경우
			else {
				elFailureMessage.classList.add('hide');
				elFailureMessageTwo.classList.add('hide');
				checkDuplicateButton.disabled = true; // 중복 확인 버튼 비활성화
			}
		};
	});

	//비밀번호 유효성 검사
document.addEventListener('DOMContentLoaded', function() {
    // 비밀번호 입력란 정보 가져오기
    let elInputPassword = document.querySelector('#loginPw');
    // 비밀번호 확인 입력란 정보 가져오기 (있는 경우)
    let elInputPasswordRetype = document.querySelector('#loginPw2');
    // 실패 메시지 정보 가져오기
    let elStrongPasswordMessage = document.querySelector('.strongPassword-message');

    // 강력한 비밀번호인지 확인하는 함수
    function strongPassword(str) {
        return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
    }

    // 강력한 비밀번호 메시지 표시 여부를 업데이트하는 함수
    function updatePasswordMessageVisibility() {
        if (elInputPassword.value.length !== 0) {
            if (strongPassword(elInputPassword.value)) {
                elStrongPasswordMessage.classList.add('hide');
            } else {
                elStrongPasswordMessage.classList.remove('hide');
            }
        } else {
            elStrongPasswordMessage.classList.add('hide');
        }
    }

    // 입력 이벤트에 대한 이벤트 리스너를 추가하여 실시간으로 비밀번호 강도를 확인합니다.
    elInputPassword.addEventListener('input', updatePasswordMessageVisibility);

    // 초기에 메시지 표시 여부를 올바르게 확인하기 위해 함수를 호출합니다.
    updatePasswordMessageVisibility();

    // 폼 제출 시 실행되는 함수
    document.getElementById('signupForm').addEventListener('submit', function(event) {
        // 비밀번호 확인을 요청하는 alert 표시
        if (!strongPassword(elInputPassword.value)) {
            alert("비밀번호를 다시 확인해주세요.");
            event.preventDefault(); // 제출 이벤트 중단
        }
    });
});
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

/* 비밀번호 */
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

.hide {
	display: none;
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
									<div class="failure-message hide">아이디는 4~12글자이어야 합니다</div>
									<div class="failure-message2 hide">영어 또는 숫자만 가능합니다</div>
								</div>
								<div class="group loginPw">
									<label for="pass" class="label">비밀번호</label> <input id="loginPw" name="loginPw" type="password" class="input"
										data-type="password">
								</div>
								<div class="strongPassword-message hide">8글자 이상, 영문, 숫자, 특수문자를 사용하세요</div>
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
									<input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly> <input type="button"
										id="postcode-button" onclick="execDaumPostcode()" value="우편번호 찾기"><br> <input type="text"
										id="roadAddress" name="roadAddress" placeholder="도로명주소" readonly> <input type="text" id="jibunAddress"
										name="jibunAddress" placeholder="지번주소" readonly> <span id="guide" style="color: #999; display: none"></span>
									<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"> <input type="text"
										id="extraAddress" placeholder="참고항목" readonly> <input type="hidden" id="latitude" name="latitude"
										readonly> <input type="hidden" id="longitude" name="longitude" readonly>
								</div>
								<div class="group">
									<label for="schoollevel" class="label">학교급</label> <select
										class="select select-bordered select-sm w-full max-w-xs" name="schoollevel" id="schoollevel">
										<option value="primary">초등학교</option>
										<option value="middle">중학교</option>
										<option value="high">고등학교</option>
									</select>
								</div>
								<div class="group">
									<label for="grade" class="label">학년</label> <select class="select select-bordered select-sm w-full max-w-xs"
										name="grade" id="grade">
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