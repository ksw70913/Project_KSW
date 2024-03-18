<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST"></c:set>

<%@ include file="../common/head.jspf"%>

<script>
	
	async function getData() {
		const API_KEY = 'ixQo%2FUislf4YkHMgIBaDkwtFr%2FjmxRZLI55pNfsWntbXQewj3hrI50T6IoARyuZNWhk10ra5m39wMU57zRKeIw%3D%3D';
		const url = 'https://apis.data.go.kr/6300000/openapi2022/shard/getshard?serviceKey='+ API_KEY +'&pageNo=1&numOfRows=5';
		const response = await fetch(url);
		const data = await response.json();
		console.log("data", data);
	}
	
	getData();
	
	async function getData2() {
		const API_KEY = 'ixQo%2FUislf4YkHMgIBaDkwtFr%2FjmxRZLI55pNfsWntbXQewj3hrI50T6IoARyuZNWhk10ra5m39wMU57zRKeIw%3D%3D';
		const url = 'https://www.yuseong.go.kr/ys_parking/ysparkingList/ORP/getJSONData.do?_wadl&type=json';
		const response = await fetch(url);
		const data = await response.json();
		console.log("data", data);
	}
	
	getData2();
	
	var xhr = new XMLHttpRequest();
	var url = 'http://api.data.go.kr/openapi/tn_pubr_public_elesch_mskul_lc_api'; /*URL*/
	var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'sXaDVMwIwuh2aZb8F9GvAYdPmMxf134ec9pyG%2FtL1HvM2XEm0%2FWMuWh69sVIN48d1%2BPkD3tHpaH%2F%2Bd8Pg%2FWw6g%3D%3D'; /*Service Key*/
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('100'); /**/
	queryParams += '&' + encodeURIComponent('type') + '=' + encodeURIComponent('xml'); /**/
	queryParams += '&' + encodeURIComponent('schoolId') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('schoolNm') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('schoolSe') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('fondDate') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('fondType') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('bnhhSe') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('operSttus') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('lnmadr') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('rdnmadr') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('cddcCode') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('cddcNm') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('edcSport') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('edcSportNm') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('creatDate') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('changeDate') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('latitude') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('longitude') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('referenceDate') + '=' + encodeURIComponent(''); /**/
	queryParams += '&' + encodeURIComponent('instt_code') + '=' + encodeURIComponent(''); /**/
	xhr.open('GET', url + queryParams);
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
	        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
	    }
	};

	xhr.send('');
	
</script>

<%@ include file="../common/foot.jspf"%>