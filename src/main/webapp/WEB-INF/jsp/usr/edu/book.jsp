<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
    <div id="dataContainer"></div>

    <script>
        async function getData() {
            const API_KEY = 'uIOtZMu1BLpFtpMuzWkQRuFICA3QtxIYqybibr8HXZwaMVhmaEr1yAeXAxODa50Alw%2FxoMIvPRKtHonY1y3CBA%3D%3D';
            const url = 'https://api.odcloud.kr/api/15110962/v1/uddi:8769d4d3-35a0-4a13-914d-a458385bcfe9?page=1&perPage=10&serviceKey=' + API_KEY;
            const response = await fetch(url);
            const data = await response.json();
            console.log("data", data);
            
            // 데이터를 HTML에 추가
            const dataContainer = document.getElementById('dataContainer');
            dataContainer.innerHTML = ''; // 데이터를 추가하기 전에 기존 내용을 비워줍니다.

            if (data && data.data && data.data.length >= 3) { // 배열이 존재하고 최소한 세 번째 요소가 있을 때
                const thirdData = data.data[2]; // 세 번째 데이터 선택
                const dataItem = document.createElement('div');
                dataItem.textContent = JSON.stringify(thirdData);
                dataContainer.appendChild(dataItem);
            } else {
                dataContainer.textContent = '데이터를 불러오지 못했습니다.'; // 데이터가 없는 경우 에러 메시지 표시
            }
        }

        getData();
    </script>

    123
</body>
</html>