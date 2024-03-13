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
.graph-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh; /* Adjust height as needed */
}

.graph {
	text-align: center;
	padding: 20px;
	background-color: #f0f0f0;
	border-radius: 10px;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.button-container {
	margin-top: 20px;
}

.button-container button {
	padding: 10px 20px;
	background-color: #007bff; /* Example color */
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.button-container button:hover {
	background-color: #0056b3; /* Example color */
}

.graph h1 {
	font-size: 24px;
	margin-bottom: 10px;
}

.graph h2 {
	font-size: 18px;
	margin-bottom: 10px;
}

.graph label {
	display: block;
	font-size: 16px;
	margin-bottom: 10px;
}

.graph input[type="number"] {
	font-size: 16px;
	padding: 8px;
	margin-bottom: 10px;
}

.graph button {
	font-size: 18px;
	padding: 10px 20px;
	background-color: #DB7F67;
	color: #ffffff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.graph button:hover {
	background-color: #C56A51;
}

.graph canvas {
	margin-top: 20px;
	border: 2px solid #DB7F67;
	border-radius: 50%;
}
</style>
</head>
<body>


	<div class="graph-container">
		<div class="graph">
			<h1>교과목 선택</h1>
			<h2>Circular Graph</h2>
			<label for="inputNumber">0부터 100 사이의 숫자를 입력하세요:</label> <input type="number" id="inputNumber" min="0" max="100"
				value="50">
			<div class="button-container">
				<button onclick="drawCircularGraph()">그래프 그리기</button>
			</div>
			<canvas id="graphCanvas" width="200" height="200"></canvas>
		</div>
	</div>





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

			// Calculate radius based on canvas size
			const radius = Math.min(canvas.width, canvas.height) / 2 - 20;

			// Draw circular graph
			ctx.beginPath();
			ctx.arc(centerX, centerY, radius, -0.5 * Math.PI, endAngle - 0.5
					* Math.PI);
			ctx.strokeStyle = '#2ecc71'; // Green color
			ctx.lineWidth = 30;
			ctx.lineCap = 'round'; // Rounded line ends
			ctx.stroke();
		}
	</script>

</body>
</html>
<%@ include file="../common/foot.jspf"%>