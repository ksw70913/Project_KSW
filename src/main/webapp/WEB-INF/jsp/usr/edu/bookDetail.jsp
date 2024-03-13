<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head2.jspf"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle}</title>
<style>
/* Custom CSS for styling */

/* Table styling */
.table-container {
	margin-top: 20px;
}

.table-box-1 {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.table-box-1 th, .table-box-1 td {
	padding: 10px;
	border: 1px solid #ccc;
}

/* Add button styling */
.add-button-container {
	margin-top: 20px;
	text-align: center;
}

.add-button {
	padding: 10px 20px;
	background-color: #f5b987; /* Lighter orange color for button */
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

.add-button:hover {
	background-color: #efa764; /* Darker orange color on hover */
}

/* Table row colors */
.table-box-1 th {
	background-color: #ffe6b3; /* Light yellow color for table header */
	color: #333; /* Dark text color */
}

.table-box-1 tr:nth-child(even) {
	background-color: #fffce6; /* Creamy color for even rows */
}
</style>
</head>
<body>
	<section class="mt-8 text-xl px-4">
		<div class="table-container">
			<table class="table-box-1" border="1">
				<tbody>
					<tr>
						<th>번호</th>
						<td>${book.id}</td>
					</tr>
					<tr>
						<th>교육과정</th>
						<td>${book.curriculum}</td>
					</tr>
					<tr>
						<th>출판년도</th>
						<td>${book.publicationyear}</td>
					</tr>
					<tr>
						<th>국/검/인정</th>
						<td>${book.stateswordrecognition}</td>
					</tr>
					<tr>
						<th>자료형태</th>
						<td>${book.datatype}</td>
					</tr>
					<tr>
						<th>학교급</th>
						<td>${book.schoolLevel}</td>
					</tr>
					<tr>
						<th>학교구분</th>
						<td>${book.schoolclassification}</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${book.title}</td>
					</tr>
					<tr>
						<th>저자</th>
						<td>${book.author}</td>
					</tr>
					<tr>
						<th>출판사</th>
						<td>${book.publisher}</td>
					</tr>
					<tr>
						<th>정가</th>
						<td>${book.price}</td>
					</tr>
					<tr>
						<th>학년</th>
						<td>${book.grade}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>

	<section class="mt-8 text-xl px-4">
		<form action="../edu/addBook" method="POST">
			<div>
				<input type="hidden" name="id" value="${book.id}" /> <input type="hidden" name="title" value="${book.title}" />
				<div class="add-button-container">
					<button type="submit" class="add-button">추가하기</button>
				</div>
			</div>
		</form>
	</section>
</body>
</html>

<%@ include file="../common/foot.jspf"%>