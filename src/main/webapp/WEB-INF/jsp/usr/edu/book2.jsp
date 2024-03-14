<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="#{board.code } BOOK LIST"></c:set>
<%@ include file="../common/head2.jspf"%>
<%
int cPage = (int) request.getAttribute("page");
int totalPage = (int) request.getAttribute("totalPage");
int pageSize = (int) request.getAttribute("pageSize");
int pageGroup = (int) request.getAttribute("pageGroup");
int from = (int) request.getAttribute("from");
int end = (int) request.getAttribute("end");
String searchKeyword = (String) request.getAttribute("searchKeyword");
%>

<style>
section {
	background-color: #F4CFC6;
}
</style>

<section class="mt-8 text-xl px-4">
	<div class="mx-auto overflow-x-auto">
		<div class="mb-4 flex">
			<div class="badge badge-outline">${booksCount }개</div>
			<div class="flex-grow"></div>
			<form action="">
				<input type="hidden" name="boardId" value="${param.boardId }" /> <select
					data-value="${param.searchKeywordTypeCode }" class="select select-bordered select-sm w-full max-w-xs"
					name="searchKeywordTypeCode">
					<option value="signature">제목</option>
					<option value="author">저자</option>
					<option value="signature,grade">제목+저자</option>
				</select><input value="${param.searchKeyword }" name="searchKeyword" type="text" placeholder="searchKeyword?"
					class="input-sm input input-bordered w-48 max-w-xs" />
				<button class="btn btn-ghost btn-sm" type="submit">검색</button>
			</form>
		</div>
	</div>
	<table class="table-box-1 table" border="1">
		<colgroup>
			<col style="width: 5%" />
			<col style="width: 15%" />
			<col style="width: 46%" />
			<col style="width: 5%" />
			<col style="width: 5%" />
			<col style="width: 10%" />
			<col style="width: 14%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>교육과정</th>
				<th>제목</th>
				<th>출판년도</th>
				<th>학교급</th>
				<th>저자</th>
				<th>출판사</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach var="book" items="${books }">
				<tr class="hover">
					<td>${book.id }</td>
					<td>${book.curriculum }</td>
					<td><a href="bookDetail?id=${book.id }">${book.title } </a></td>
					<td>${book.publicationyear }</td>
					<td>${book.schoolLevel }</td>
					<td>${book.author }</td>
					<td>${book.publisher }</td>
					<td>${book.boardId }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>


	<div class="pagination flex justify-center mt-3">
		<div class="btn-group">
			<%
			if (pageGroup * pageSize > totalPage) {
				end = totalPage;
			}

			if (from < 1) {
				from = 1;
			}

			if (end > totalPage) {
				end = totalPage;
			}
			int beforeBtn = cPage - pageSize;

			if (beforeBtn < 1) {
				beforeBtn = 1;
			}

			int afterBtn = pageGroup * pageSize + 1;

			if (cPage > 1) {
			%>
			<a
				href="?boardId=${board.id }&page=1&searchKeywordTypeCode=${param.searchKeywordTypeCode }&searchKeyword=${param.searchKeyword }">◀◀</a>
			<%
			}
			%>
			<a
				href="?boardId=${board.id }&page=<%=beforeBtn%>&searchKeywordTypeCode=${param.searchKeywordTypeCode }&searchKeyword=${param.searchKeyword }">◁</a>
			<c:forEach begin="<%=from%>" end="<%=end%>" var="i">
				<a class="btn btn-sm ${param.page == i ? 'btn-active' : '' }"
					href="?boardId=${param.boardId }&page=${i }&searchKeywordTypeCode=${param.searchKeywordTypeCode }&searchKeyword=${param.searchKeyword } ">${i }</a>
			</c:forEach>
			<%
			if (afterBtn < totalPage) {
			%>
			<a
				href="?boardId=${board.id }&page=<%=afterBtn%>&searchKeywordTypeCode=${param.searchKeywordTypeCode }&searchKeyword=${param.searchKeyword }">▷</a>
			<%
			}
			if (cPage < totalPage) {
			%>
			<a
				href="?boardId=${board.id }&page=<%=totalPage%>&searchKeywordTypeCode=${param.searchKeywordTypeCode }&searchKeyword=${param.searchKeyword }">▶▶</a>
			<%
			}
			%>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>