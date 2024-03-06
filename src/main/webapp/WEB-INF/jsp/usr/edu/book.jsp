<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="교과목 검색"></c:set>
<%@ include file="../common/head2.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
    .page-button {
        display: inline-block; /* 페이지 버튼을 가로로 표시 */
        margin: 5px; /* 각 페이지 버튼 사이의 간격 설정 */
        padding: 5px 10px; /* 페이지 버튼의 여백 설정 */
        background-color: #ffffff; /* 선택되지 않은 페이지 버튼의 배경색 */
        color: #000000; /* 선택되지 않은 페이지 버튼의 글자색 */
        border: 1px solid #ccc; /* 페이지 버튼의 테두리 설정 */
        cursor: pointer; /* 마우스를 올렸을 때 포인터 모양으로 변경 */
    }
    .selected-page {
        background-color: #007bff; /* 선택된 페이지 버튼의 배경색 */
        color: #ffffff; /* 선택된 페이지 버튼의 글자색 */
    }
</style>
</head>
<body>
    <div>
        <input type="text" id="searchInput" placeholder="교과목을 입력하세요">
        <button onclick="searchData(1)">검색</button> <!-- 검색 버튼 클릭 시 첫 번째 페이지 데이터 가져오도록 수정 -->
    </div>
    <div id="dataContainer"></div>
    <div id="pagination"></div> <!-- 페이지 번호를 표시할 영역 -->

    <script>
        let currentPage = 1; // 현재 페이지 변수 추가
        let pageSize = 10; // 페이지당 아이템 수

        async function getData(page) {
            const API_KEY = 'uIOtZMu1BLpFtpMuzWkQRuFICA3QtxIYqybibr8HXZwaMVhmaEr1yAeXAxODa50Alw%2FxoMIvPRKtHonY1y3CBA%3D%3D';
            const searchInput = document.getElementById('searchInput').value;
            const url = 'https://api.odcloud.kr/api/15110962/v1/uddi:8769d4d3-35a0-4a13-914d-a458385bcfe9?page=1&perPage=10&serviceKey=' + API_KEY + '&code=${searchInput}';
            if (searchInput) {
                url += `&code=${searchInput}`;
            }
            const response = await fetch(url);
            const data = await response.json();
            console.log("data", data);
            return data;
        }

        async function searchData(page) {
            currentPage = page; // 현재 페이지 업데이트
            const dataContainer = document.getElementById('dataContainer');
            dataContainer.innerHTML = ''; // 데이터를 추가하기 전에 기존 내용을 비워줍니다.

            const data = await getData(page);
            if (data && data.data && data.data.length > 0) {
                const startIndex = (page - 1) * pageSize;
                const endIndex = Math.min(startIndex + pageSize, data.data.length);
                for (let i = startIndex; i < endIndex; i++) {
                    const dataItem = document.createElement('div');
                    dataItem.textContent = JSON.stringify(data.data[i]);
                    dataContainer.appendChild(dataItem);
                }
                renderPagination(data.totalCount); // 페이지 번호를 생성하고 추가합니다.
            } else {
                dataContainer.textContent = '검색된 데이터가 없습니다.'; // 검색 결과가 없는 경우 에러 메시지 표시
            }
        }

        function renderPagination(totalCount) {
            const paginationContainer = document.getElementById('pagination');
            paginationContainer.innerHTML = '';

            const totalPages = Math.ceil(totalCount / pageSize); // 전체 페이지 수 계산

            // 이전 페이지 버튼 생성
            const prevButton = document.createElement('button');
            prevButton.textContent = '이전';
            prevButton.addEventListener('click', function() {
                if (currentPage > 1) {
                    searchData(currentPage - 1);
                }
            });
            paginationContainer.appendChild(prevButton);

            // 페이지 번호 버튼 생성
            for (let i = 1; i <= totalPages && i <= 10; i++) {
                const pageButton = document.createElement('button');
                pageButton.textContent = i;
                pageButton.classList.add('page-button'); // 페이지 버튼에 클래스 추가
                if (i === currentPage) {
                    pageButton.classList.add('selected-page'); // 선택된 페이지에 클래스 추가
                }
                pageButton.addEventListener('click', function() {
                    searchData(i); // 페이지 번호를 클릭하면 해당 페이지의 데이터를 가져옵니다.
                });
                paginationContainer.appendChild(pageButton);
            }

            // 다음 페이지 버튼 생성
            const nextButton = document.createElement('button');
            nextButton.textContent = '다음';
            nextButton.addEventListener('click', function() {
                if (currentPage < totalPages) {
                    searchData(currentPage + 1);
                }
            });
            paginationContainer.appendChild(nextButton);
        }

        searchData(1); // 페이지가 로드될 때 검색 수행
        


    </script>
</body>
</html>