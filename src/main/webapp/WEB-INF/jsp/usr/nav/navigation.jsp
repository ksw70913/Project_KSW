<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="학교 길찾기"></c:set>

<%@ include file="../common/head2.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 이동시키기</title>

</head>
<body>
	<div id="map" style="width: 100%; height: 350px;"></div>
	<p>
		<button onclick="setCenter()">지도 중심좌표 이동시키기</button>
		<button onclick="panTo()">대전으로 이동시키기</button>
		<button onclick="findRoute()">길찾기</button>

		<!-- New button for finding route -->
	</p>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85425c32b3a10c0c8fef41ad4e316852"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85425c32b3a10c0c8fef41ad4e316852&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), mapOption = {
			center : new kakao.maps.LatLng(36.35101072771798,
					127.38031136394397),
			level : 3,
			mapTypeId : kakao.maps.MapTypeId.ROADMAP
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);

		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

						kakao.maps.event.addListener(map, 'center_changed', function() {
							console.log('지도의 중심 좌표는 ' + map.getCenter().toString() + ' 입니다.');
						});

		function findRoute() {
			var REST_API_KEY = "1ec93b2e1a5214eb880459640d7a12f5"; // 카카오디벨로퍼스에서 발급 받은 API 키 값

			var data = {
				"origins" : [ {
					"x" : "127.37188176060631",
					"y" : "36.3570616114436",
					"key" : "0"
				}, {
					"x" : "127.3690068546786",
					"y" : "36.35637662015051",
					"key" : "1"
				} ],
				"destination" : {
					"x" : "127.3780796375117",
					"y" : "36.358321828078424"
				},
				"radius" : 5000
			};

			var xhr = new XMLHttpRequest();
			xhr
					.open("POST",
							"https://apis-navi.kakaomobility.com/v1/origins/directions");
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.setRequestHeader("Authorization", "KakaoAK " + REST_API_KEY);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					var response = JSON.parse(xhr.responseText);
					// 여기서 경로 정보를 이용하여 지도에 표시하는 작업을 수행할 수 있습니다.
					console.log(response);
				}
			};
			xhr.send(JSON.stringify(data));
		}

		function displayRoute(routeData) {
			var path = routeData.features[0].geometry.coordinates.map(function(
					coord) {
				return new kakao.maps.LatLng(coord[1], coord[0]);
			});

			var polyline = new kakao.maps.Polyline({
				path : path,
				strokeWeight : 5,
				strokeColor : '#FF0000',
				strokeOpacity : 0.7,
				strokeStyle : 'solid'
			});

			polyline.setMap(map);

			// Adjust map bounds to fit the route
			var bounds = new kakao.maps.LatLngBounds();
			path.forEach(function(coord) {
				bounds.extend(coord);
			});
			map.setBounds(bounds);
		}

		function panTo() {
			var center = new kakao.maps.LatLng(36.35059345364761,
					127.38538377908473);
			map.panTo(center);
		}
	</script>
</body>
</html>