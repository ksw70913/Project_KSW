<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!--     <div id="dataContainer"></div> -->

    <script>
        async function getData() {
            const API_KEY = 'uIOtZMu1BLpFtpMuzWkQRuFICA3QtxIYqybibr8HXZwaMVhmaEr1yAeXAxODa50Alw%2FxoMIvPRKtHonY1y3CBA%3D%3D';
            const url = 'http://api.data.go.kr/openapi/tn_pubr_public_elesch_mskul_lc_api?serviceKey=' + API_KEY + '&pageNo=1&numOfRows=10&type=JSON';
            const response = await fetch(url);
            const data = await response.json();
            console.log("data", data);
            
//             // �����͸� HTML�� �߰�
//             const dataContainer = document.getElementById('dataContainer');
//             dataContainer.innerHTML = ''; // �����͸� �߰��ϱ� ���� ���� ������ ����ݴϴ�.

//             if (data && data.data && data.data.length >= 3) { // �迭�� �����ϰ� �ּ��� �� ��° ��Ұ� ���� ��
//                 const thirdData = data.data[2]; // �� ��° ������ ����
//                 const dataItem = document.createElement('div');
//                 dataItem.textContent = JSON.stringify(thirdData);
//                 dataContainer.appendChild(dataItem);
//             } else {
//                 dataContainer.textContent = '�����͸� �ҷ����� ���߽��ϴ�.'; // �����Ͱ� ���� ��� ���� �޽��� ǥ��
//             }
        }

        getData();
    </script>

    123
</body>
</html>