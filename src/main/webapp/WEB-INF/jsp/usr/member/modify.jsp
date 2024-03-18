<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 페이지 제목을 "회원 수정"으로 설정 -->
<c:set var="pageTitle" value="회원 수정"></c:set>

<!-- 공통 헤더 포함 -->
<%@ include file="../common/head2.jspf"%>

<!-- 회원 수정 섹션 -->
<!-- 폼 제출 유효성 검사를 위한 스크립트 -->
<script type="text/javascript">
    // 폼 제출 여부를 추적하는 변수
    let MemberModify__submitFormDone = false;
    function MemberModify__submit(form) {
        // 이미 제출된 경우 무시
        if (MemberModify__submitFormDone) {
            return;
        }
        // 입력값 트림 및 유효성 검사
        form.loginPw.value = form.loginPw.value.trim();
        if (form.loginPw.value.length > 0) {
            form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
            if (form.loginPwConfirm.value.length == 0) {
                alert('비밀번호 확인을 입력해주세요');
                form.loginPwConfirm.focus();
                return;
            }
            if (form.loginPw.value != form.loginPwConfirm.value) {
                alert('비밀번호가 일치하지 않습니다');
                form.loginPw.focus();
                return;
            }
        }
        // 다른 입력값 트림
        form.name.value = form.name.value.trim();
        form.nickname.value = form.nickname.value.trim();
        form.cellphoneNum.value = form.cellphoneNum.value.trim();
        form.email.value = form.email.value.trim();

        // 폼 제출 완료 표시하여 다중 제출 방지
        MemberModify__submitFormDone = true;
        // 폼 제출
        form.submit();
    }
</script>

<!-- 다음 우편번호 및 카카오 지도 API 포함 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85425c32b3a10c0c8fef41ad4e316852&libraries=services" type="text/javascript"></script>

<!-- 다음 우편번호 API 및 주소 구성을 위한 스크립트 -->
<script>
    // 다음 우편번호 API 실행 함수
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 수신된 데이터를 기반으로 주소 구성
                var roadAddr = data.roadAddress;
                var extraRoadAddr = '';

                if (data.bname !== '' && /[dong|ro|ga]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraRoadAddr !== '') {
                    extraRoadAddr = '(' + extraRoadAddr + ')';
                }

                // 데이터로 주소 필드 채우기
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;

                if (roadAddr !== '') {
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                if (data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명주소: ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';
                } else if (data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번주소: ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }

                // 카카오 지도 API를 사용하여 위도와 경도 좌표 찾기
                const geocoder = new kakao.maps.services.Geocoder();
                geocoder.addressSearch(data.roadAddress, function (result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        var latitude = result[0].y;
                        var longitude = result[0].x;
                        document.getElementById('latitude').value = latitude;
                        document.getElementById('longitude').value = longitude;
                    }
                });
            }
        }).open();
    }
</script>

<!-- CSS 스타일 -->
<style>
    /* 주소 스타일링 */
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
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
    }
    #postcode-button:hover {
        background-color: #0056b3;
    }
    #address-container {
        margin-top: 10px;
    }
    #roadAddress, #jibunAddress, #detailAddress, #extraAddress {
        width: calc(100% - 10px);
        margin-right: 10px;
        margin-top: 5px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }
</style>

<!-- 회원 수정 섹션 -->
<section class="mt-8 text-xl px-4">
    <div class="mx-auto">
        <!-- 회원 수정 폼 -->
        <form action="../member/doModify" method="POST" onsubmit="MemberModify__submit(this); return false;">
            <table class="member-modify-box table-box-1" border="1">
                <tbody>
                    <!-- 수정할 회원 정보 표시 -->
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
                        <td><input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly
                            value="${rq.loginedMember.postcode }"> <input type="button" id="postcode-button"
                            onclick="execDaumPostcode()" value="우편번호 찾기"><br> <input type="text" id="roadAddress"
                            name="roadAddress" placeholder="도로명주소" readonly value="${rq.loginedMember.roadAddress }"> <input
                            type="text" id="jibunAddress" name="jibunAddress" placeholder="지번주소" readonly
                            value="${rq.loginedMember.jibunAddress }"> <span id="guide" style="color: #999; display: none"></span> <input
                            type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" value="${rq.loginedMember.detailAddress }">
                            <input type="text" id="extraAddress" placeholder="참고항목" readonly>
                            <input type="hidden" id="latitude" name="latitude" readonly>
                            <input type="hidden" id="longitude" name="longitude" readonly></td>
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
        <!-- 뒤로 가기 버튼 -->
        <div class="btns">
            <button class="btn btn-outline" class="" type="button" onclick="history.back();">뒤로가기</button>
        </div>
    </div>
</section>

<!-- 공통 풋터 포함 -->
<%@ include file="../common/foot.jspf"%>