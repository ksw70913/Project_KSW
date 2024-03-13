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

.books {
	position: absolute;
	top: 50px;
	right: 20%;
	font-size: 1.2em;
}

.changeLearning {
	top: 50px; /* Adjust position as needed */
	right: 10%;
	font-size: 1.2em;
}

.graph canvas {
	border: 2px solid #DB7F67;
	border-radius: 50%;
}

.option-label {
	position: absolute;
	top: 0;
	left: 50%;
	transform: translateX(-50%);
	font-size: 24px;
	font-weight: bold;
}

.learning-label {
	margin-top: 20px;
	font-size: 18px;
}
</style>
</head>
<body>
	<!-- 과목 선택 -->
	<div class="bookStatus">
		<select id="bookStatus" onchange="drawGraph()">
			<c:forEach var="Status" items="${bookStatus}" varStatus="loop">
				<option value="${Status.id}" data-learning="${Status.learning}">${Status.title}</option>
			</c:forEach>
		</select>
	</div>

	<div class="changeLearning">
		<form id="learningForm" action="../edu/doLearning" method="POST">
			<input type="hidden" name="id" id="selectedOptionId" value="" /> 학습현황 <input type="text" name="learning" /> <input
				type="submit" />
		</form>
	</div>

	<div class="graph-container">
		<canvas id="graphCanvas" width="200" height="200"></canvas>
		<div class="option-label" id="optionLabel"></div>
		<div class="learning-label" id="learningLabel"></div>
	</div>



	<script>
		function drawGraph() {
			console.log("Drawing circular graph...");
			const canvas = document.getElementById('graphCanvas');
			const select = document.getElementById('bookStatus');
			const selectedOption = select.options[select.selectedIndex];

			if (!canvas) {
				console.error("Canvas element not found.");
				return;
			}

			const ctx = canvas.getContext('2d');
			const centerX = canvas.width / 2;
			const centerY = canvas.height / 2;
			const radius = Math.min(canvas.width, canvas.height) / 2 - 20;
			const startAngle = -0.5 * Math.PI;
			const learningValue = selectedOption.getAttribute('data-learning');
			const percentage = parseFloat(learningValue) / 100;
			const endAngle = (2 * percentage * Math.PI) + startAngle;

			document.getElementById('optionLabel').textContent = selectedOption.textContent;
			document.getElementById('learningLabel').textContent = "Learning: "
					+ learningValue + "%";

			// Set the selected option id in the form
			document.getElementById('selectedOptionId').value = selectedOption.value;

			ctx.clearRect(0, 0, canvas.width, canvas.height);
			ctx.beginPath();
			ctx.arc(centerX, centerY, radius, startAngle, endAngle);
			ctx.strokeStyle = '#2ecc71'; // Green color
			ctx.lineWidth = 30;
			ctx.lineCap = 'round';
			ctx.stroke();
		}
	</script>
</body>
</html>
<%@ include file="../common/foot.jspf"%>