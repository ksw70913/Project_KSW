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
            
            // �����͸� HTML�� �߰�
            const dataContainer = document.getElementById('dataContainer');
            dataContainer.innerHTML = ''; // �����͸� �߰��ϱ� ���� ���� ������ ����ݴϴ�.

            if (data && data.data && data.data.length >= 3) { // �迭�� �����ϰ� �ּ��� �� ��° ��Ұ� ���� ��
                const thirdData = data.data[2]; // �� ��° ������ ����
                const dataItem = document.createElement('div');
                dataItem.textContent = JSON.stringify(thirdData);
                dataContainer.appendChild(dataItem);
            } else {
                dataContainer.textContent = '�����͸� �ҷ����� ���߽��ϴ�.'; // �����Ͱ� ���� ��� ���� �޽��� ǥ��
            }
        }

        getData();
    </script>

    123
</body>
</html>