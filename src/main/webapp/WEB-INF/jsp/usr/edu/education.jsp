<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�н� ��Ȳ</title>
</head>
<body>

<script>
	
	async function getData() {
		const API_KEY = 'sXaDVMwIwuh2aZb8F9GvAYdPmMxf134ec9pyG%2FtL1HvM2XEm0%2FWMuWh69sVIN48d1%2BPkD3tHpaH%2F%2Bd8Pg%2FWw6g%3D%3D';
		const url = 'https://apis.data.go.kr/6300000/openapi2022/shard/getshard?serviceKey='+ API_KEY +'&pageNo=1&numOfRows=5';
		const response = await fetch(url);
		const data = await response.json();
		console.log("data", data);
	}
	
	</script>

</body>
</html>