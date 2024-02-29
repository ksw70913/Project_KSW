<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST2"></c:set>

<%@ include file="../common/head.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 생성하기</title>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>다음 지도 API</title>
</head>
<body>
	<div id="map" style="width: 750px; height: 350px;"></div>

	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85425c32b3a10c0c8fef41ad4e316852"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(36.35103281071609,
					127.37974330854786), // 지도의 중심좌표
			level : 2, // 지도의 확대 레벨
			mapTypeId : kakao.maps.MapTypeId.ROADMAP
		// 지도종류
		};

		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 지도에 확대 축소 컨트롤을 생성한다
		var zoomControl = new kakao.maps.ZoomControl();

		// 지도의 우측에 확대 축소 컨트롤을 추가한다
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		// 지도 확대 레벨 변화 이벤트를 등록한다
		kakao.maps.event.addListener(map, 'zoom_changed', function() {
			console.log('지도의 현재 확대레벨은 ' + map.getLevel() + '레벨 입니다.');
		});

		// 지도 클릭 이벤트를 등록한다 (좌클릭 : click, 우클릭 : rightclick, 더블클릭 : dblclick)
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			console.log('지도에서 클릭한 위치의 좌표는 ' + mouseEvent.latLng.toString()
					+ ' 입니다.');
		});

		// 지도 드래깅 이벤트를 등록한다 (드래그 시작 : dragstart, 드래그 종료 : dragend)
		kakao.maps.event.addListener(map, 'drag', function() {
			var message = '지도를 드래그 하고 있습니다. ' + '지도의 중심 좌표는 '
					+ map.getCenter().toString() + ' 입니다.';
			console.log(message);
		});
	</script>

	<script>
	curl -v -X POST "https://apis-navi.kakaomobility.com/v1/origins/directions" \
	-H "Content-Type: application/json" \
	-H "Authorization: KakaoAK ${REST_API_KEY}" \ // 카카오디벨로퍼스에서 발급 받은 API 키 값
	-d '{
	  "origins": [
	    {
	      "x": "127.1331694942593",
	      "y": "37.4463137562622",
	      "key": "0"
	    },
	    {
	      "x": "127.13243772760565",
	      "y": "37.44148514309502",
	      "key": "1"
	    }
	  ],
	  "destination": {
	    "x": "127.14816492905383",
	    "y": "37.4401690139602"
	  },
	  "radius": 5000
	}'
	
	</script>
</body>
</html>

<%@ include file="../common/foot.jspf"%>