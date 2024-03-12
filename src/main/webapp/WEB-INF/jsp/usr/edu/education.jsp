<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="교과목 검색"></c:set>
<%@ include file="../common/head2.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학습 현황</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
	margin: 0;
	padding: 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

h1, h2 {
	text-align: center;
	color: #333;
}

label {
	font-size: 18px;
	margin-top: 10px;
}

input[type="number"] {
	font-size: 16px;
	padding: 8px;
	margin: 5px;
}

button {
	font-size: 18px;
	padding: 10px 20px;
	margin: 10px;
	background-color: #2ecc71;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #27ae60;
}

canvas {
	border: 2px solid #333;
	border-radius: 50%;
	margin-top: 20px;
}
</style>
</head>
<body>
	<h1>교과목 선택</h1>
	<h2>Circular Graph</h2>
	<label for="inputNumber">0부터 100 사이의 숫자를 입력하세요:</label>
	<input type="number" id="inputNumber" min="0" max="100" value="50">
	<button onclick="drawCircularGraph()">그래프 그리기</button>
	<canvas id="graphCanvas" width="200" height="200"></canvas>

	<script>
		function drawCircularGraph() {
			const canvas = document.getElementById('graphCanvas');
			const ctx = canvas.getContext('2d');

			// Clear canvas
			ctx.clearRect(0, 0, canvas.width, canvas.height);

			// Get input number from the user
			const inputNumber = document.getElementById('inputNumber').value;
			const percentage = parseFloat(inputNumber) / 100;

			// Calculate end angle based on percentage (360 degrees = 2 * Math.PI radians)
			const endAngle = percentage * 2 * Math.PI;

			// Center of the canvas
			const centerX = canvas.width / 2;
			const centerY = canvas.height / 2;

			// Radius of the circular graph
			const radius = Math.min(canvas.width, canvas.height) / 2 - 20;

			// Draw circular graph
			ctx.beginPath();
			ctx.arc(centerX, centerY, radius, 0, endAngle);
			ctx.strokeStyle = '#2ecc71'; // Green color
			ctx.lineWidth = 30;
			ctx.lineCap = 'round'; // Rounded line ends
			ctx.stroke();
		}
	</script>

</body>
</html>
<%@ include file="../common/foot.jspf"%>