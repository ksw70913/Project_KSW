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
				<input type="hidden" name="boardId" value="${param.boardId }" /> <input type="hidden"
					data-value="${param.searchKeywordTypeCode1 }" class="input-sm input input-bordered w-48 max-w-xs"
					name="searchKeywordTypeCode1" value="title">제목 </input><input type="text" placeholder="제목을 입력해주세요."
					name="searchKeyword1" value="${param.searchKeyword1 }" /><input type="hidden"
					data-value="${param.searchKeywordTypeCode2 }" class="input-sm input input-bordered w-48 max-w-xs"
					name="searchKeywordTypeCode2" value="author">저자 </input><input type="text" placeholder="저자를 입력해주세요."
					name="searchKeyword2" value="${param.searchKeyword2 }" /> <input type="hidden"
					data-value="${param.searchKeywordTypeCode3 }" class="input-sm input input-bordered w-48 max-w-xs"
					name="searchKeywordTypeCode3" value="publisher">출판사 </input><input type="text" placeholder="출판사를 입력해주세요."
					name="searchKeyword3" value="${param.searchKeyword3 }" />
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
				href="?boardId=${board.id }&page=1&searchKeywordTypeCode1=${param.searchKeywordTypeCode1 }&searchKeyword1=${param.searchKeyword1 }&searchKeywordTypeCode2=${param.searchKeywordTypeCode2 }&searchKeyword2=${param.searchKeyword2 }&searchKeywordTypeCode3=${param.searchKeywordTypeCode3 }&searchKeyword3=${param.searchKeyword3 }">◀◀</a>
			<%
			}
			%>
			<a
				href="?boardId=${board.id }&page=<%=beforeBtn%>&searchKeywordTypeCode1=${param.searchKeywordTypeCode1 }&searchKeyword1=${param.searchKeyword1 }&searchKeywordTypeCode2=${param.searchKeywordTypeCode2 }&searchKeyword2=${param.searchKeyword2 }&searchKeywordTypeCode3=${param.searchKeywordTypeCode3 }&searchKeyword3=${param.searchKeyword3 }">◁</a>
			<c:forEach begin="<%=from%>" end="<%=end%>" var="i">
				<a class="btn btn-sm ${param.page == i ? 'btn-active' : '' }"
					href="?boardId=${param.boardId }&page=${i }&searchKeywordTypeCode1=${param.searchKeywordTypeCode1 }&searchKeyword1=${param.searchKeyword1 }&searchKeywordTypeCode2=${param.searchKeywordTypeCode2 }&searchKeyword2=${param.searchKeyword2 }&searchKeywordTypeCode3=${param.searchKeywordTypeCode3 }&searchKeyword3=${param.searchKeyword3 } ">${i }</a>
			</c:forEach>
			<%
			if (afterBtn < totalPage) {
			%>
			<a
				href="?boardId=${board.id }&page=<%=afterBtn%>&searchKeywordTypeCode1=${param.searchKeywordTypeCode1 }&searchKeyword1=${param.searchKeyword1 }&searchKeywordTypeCode2=${param.searchKeywordTypeCode2 }&searchKeyword2=${param.searchKeyword2 }&searchKeywordTypeCode3=${param.searchKeywordTypeCode3 }&searchKeyword3=${param.searchKeyword3 }">▷</a>
			<%
			}
			if (cPage < totalPage) {
			%>
			<a
				href="?boardId=${board.id }&page=<%=totalPage%>&searchKeywordTypeCode1=${param.searchKeywordTypeCode1 }&searchKeyword1=${param.searchKeyword1 }&searchKeywordTypeCode2=${param.searchKeywordTypeCode2 }&searchKeyword2=${param.searchKeyword2 }&searchKeywordTypeCode3=${param.searchKeywordTypeCode3 }&searchKeyword3=${param.searchKeyword3 }">▶▶</a>
			<%
			}
			%>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>