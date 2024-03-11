<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="BOOK DETAIL"></c:set>
<%@ include file="../common/head2.jspf"%>

<section class="mt-8 text-xl px-4 ">
	<div class="">
		<table class="table-box-1 " border="1">
			<tbody>
				<tr>
					<th>번호</th>
					<td>${book.id }</td>
				</tr>
				<tr>
					<th>교육과정</th>
					<td>${book.curriculum }</td>
				</tr>
				<tr>
					<th>출판년도</th>
					<td>${book.publicationyear }</td>
				</tr>
				<tr>
					<th>국/검/인정</th>
					<td>${book.stateswordrecognition }</td>
				</tr>
				<tr>
					<th>자료형태</th>
					<td>${book.datatype }</td>
				</tr>
				<tr>
					<th>학교급</th>
					<td>${book.schoolLevel }</td>
				</tr>
				<tr>
					<th>학교구분</th>
					<td>${book.schoolclassification }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${book.title }</td>
				</tr>
				<tr>
					<th>저자</th>
					<td>${book.author }</td>
				</tr>
				<tr>
					<th>출판사</th>
					<td>${book.publisher }</td>
				</tr>
				<tr>
					<th>정가</th>
					<td>${book.price }</td>
				</tr>
				<tr>
					<th>학년</th>
					<td>${book.grade }</td>
				</tr>

			</tbody>
		</table>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>