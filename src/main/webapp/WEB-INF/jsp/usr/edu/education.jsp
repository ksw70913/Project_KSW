<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="학습 현황"></c:set>
<%@ include file="../common/head2.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학습 현황</title>
<style>
.graph-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 100vh;
	position: relative;
	margin-top: 50px;
}

.bookStatus {
	position: absolute; /
	top: 50px;
	font-size: 1.2em;
	margin-right: 20%;
}

.changeLearning {
	margin-top: 200px;
	top: 50px; /* Adjust position as needed */
	right: 10%;
	font-size: 1.2em;
	top: 50px;
}

.graph canvas {
	border: 2px solid #DB7F67;
	border-radius: 50%;
}

.option-label {
	position: absolute;
	top: 200px;
	left: 50%;
	transform: translateX(-50%);
	font-size: 24px;
	font-weight: bold;
}

.learning-label {
	margin-top: 50px;
	font-size: 18px;
}
</style>
<body>
	<!-- 과목 선택 -->
	<div class="bookStatus">
		<!-- 옵션 선택 상자 -->
		<select id="bookStatus" onchange="drawGraph()">
			<option value="null">선택</option>
			<c:forEach var="Status" items="${bookStatus}" varStatus="loop">
				<option value="${Status.id}" data-learning="${Status.learning}">${Status.title}</option>
			</c:forEach>
		</select>
	</div>

	<!-- 학습 내용 수정 폼 -->
	<div class="changeLearning">
		<form id="learningForm" action="../edu/doLearning" method="POST">
			<input type="hidden" name="id" id="selectedOptionId" value="" /> 학습현황 <input type="text" name="learning" /><input
				type="submit" />
		</form>
	</div>

	<!-- 교과서 삭제 -->
	<div class="deleteLearning" id="deleteLearningSection">
		<!-- 여기에 옵션 선택에 따라 동적으로 생성될 삭제 링크 -->
	</div>


	<!-- 그래프 컨테이너 -->
	<div class="graph-container">
		<canvas id="graphCanvas" width="200" height="200"></canvas>
		<div class="option-label" id="optionLabel"></div>
		<div class="learning-label" id="learningLabel"></div>
	</div>

	<!-- 그래프 그리는 자바스크립트 -->
	<script>
		function drawGraph() {
			// 콘솔에 그래프 그리기 로그 표시
			console.log("Drawing circular graph...");
			// 캔버스 요소 가져오기
			const canvas = document.getElementById('graphCanvas');
			const select = document.getElementById('bookStatus');
			const selectedOption = select.options[select.selectedIndex];
			const deleteLearningSection = document
					.getElementById('deleteLearningSection');

			// 기존 삭제 링크 제거
			deleteLearningSection.innerHTML = '';

			// 새로운 삭제 링크 생성
			const deleteLink = document.createElement('a');
			deleteLink.setAttribute('class', 'btn btn-outline');
			deleteLink.setAttribute('href', '#');
			deleteLink.setAttribute('onclick',
					`deleteBook('${selectedOption.value}'); return false;`);
			deleteLink.textContent = '삭제';
			console.log("Selected Option Value:", selectedOption.value);

			deleteLearningSection.appendChild(deleteLink);

			// 캔버스가 없으면 오류 메시지 표시하고 함수 종료
			if (!canvas) {
				console.error("Canvas element not found.");
				return;
			}

			// 캔버스 컨텍스트 가져오기
			const ctx = canvas.getContext('2d');
			const centerX = canvas.width / 2;
			const centerY = canvas.height / 2;
			const radius = Math.min(canvas.width, canvas.height) / 2 - 20;
			const startAngle = -0.5 * Math.PI;
			const learningValue = selectedOption.getAttribute('data-learning');
			const percentage = parseFloat(learningValue) / 100;
			const endAngle = (2 * percentage * Math.PI) + startAngle;

			// 옵션 레이블과 학습 레이블 내용 설정
			document.getElementById('optionLabel').textContent = selectedOption.textContent;
			document.getElementById('learningLabel').textContent = "Learning: "
					+ learningValue + "%";

			// 선택한 옵션 ID를 폼에 설정
			document.getElementById('selectedOptionId').value = selectedOption.value;

			// 캔버스 초기화
			ctx.clearRect(0, 0, canvas.width, canvas.height);
			// 그래프 그리기 시작
			ctx.beginPath();
			ctx.arc(centerX, centerY, radius, startAngle, endAngle);
			ctx.strokeStyle = '#2ecc71'; // 그린 색상
			ctx.lineWidth = 30;
			ctx.lineCap = 'round';
			ctx.stroke();
		}

		// 학습삭제
		function deleteBook() {
			const select = document.getElementById('bookStatus');
			const selectedOption = select.options[select.selectedIndex];
			const bookId = selectedOption.value;

			if (bookId !== undefined && bookId.trim() !== '') {
				if (confirm('정말 삭제하시겠습니까?')) {
					// 삭제 작업을 수행할 URL에 해당 bookId를 포함시켜 전송하거나 다른 작업을 수행합니다.
					window.location.href = "../edu/doDelete?id=" + bookId;
				}
			} else {
				console.error("bookId is undefined or empty.");
			}
		}
	</script>
</body>
</html>
<%@ include file="../common/foot.jspf"%>