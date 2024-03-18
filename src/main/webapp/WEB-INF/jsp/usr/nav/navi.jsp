<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="길찾기"></c:set>

<%@ include file="../common/head2.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>지도 이동시키기</title>

<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=8iNXBpO9RuasFtAJ1J2chh2BBTj39kI7R3Lvd0Ib"></script>
<script type="text/javascript">
	var map, marker;
	var markerArr = [];
	var resultdrawArr = [];

	function initTmap() {
		// 지도 띄우기
		map = new Tmapv2.Map("map_div", {
			center: new Tmapv2.LatLng(${memberInfo.latitude}, ${memberInfo.longitude}),
			width : "100%",
			height : "400px",
			zoom : 17,
			zoomControl : true,
			scrollwheel : true
		});

		// 시작, 도착 심볼찍기
		// 시작
		$("#btn_search")
				.click(
						function() {
							var startLat = $("#start_lat").val(); // 출발지 위도
							var startLon = $("#start_lon").val(); // 출발지 경도
							var endLat = $("#end_lat").val(); // 도착지 위도
							var endLon = $("#end_lon").val(); // 도착지 경도

							var marker_s = new Tmapv2.Marker(
									{
										position : new Tmapv2.LatLng(startLat,
												startLon),
										icon : "https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_r_m_s.png",
										iconSize : new Tmapv2.Size(24, 38),
										map : map
									});

							// 도착
							var marker_e = new Tmapv2.Marker(
									{
										position : new Tmapv2.LatLng(endLat,
												endLon),
										icon : "https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_r_m_e.png",
										iconSize : new Tmapv2.Size(24, 38),
										map : map
									});
							// 경로탐색 API 사용요청
							var headers = {};
							headers["appKey"] = "8iNXBpO9RuasFtAJ1J2chh2BBTj39kI7R3Lvd0Ib";

							$
									.ajax({
										method : "POST",
										headers : headers,
										url : "https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&format=json&callback=result",
										async : false,
										data : {
											"startX" : startLon,
											"startY" : startLat,
											"endX" : endLon,
											"endY" : endLat,
											"reqCoordType" : "WGS84GEO",
											"resCoordType" : "EPSG3857",
											"startName" : "출발지",
											"endName" : "도착지"
										},
										success : function(response) {
											var resultData = response.features;

											// 결과 출력
											var tDistance = "총 거리 : "
													+ (resultData[0].properties.totalDistance / 1000)
															.toFixed(1) + "km,";
											var tTime = " 총 시간 : "
													+ (resultData[0].properties.totalTime / 60)
															.toFixed(0) + "분";

											$("#result")
													.text(tDistance + tTime);

											// 기존 그려진 라인 & 마커가 있다면 초기화
											if (resultdrawArr.length > 0) {
												for ( var i in resultdrawArr) {
													resultdrawArr[i]
															.setMap(null);
												}
												resultdrawArr = [];
											}

											drawInfoArr = [];

											for ( var i in resultData) {
												// for문 [S]
												var geometry = resultData[i].geometry;
												var properties = resultData[i].properties;
												var polyline_;

												if (geometry.type == "LineString") {
													for ( var j in geometry.coordinates) {
														// 경로들의 결과값(구간)들을 포인트 객체로 변환
														var latlng = new Tmapv2.Point(
																geometry.coordinates[j][0],
																geometry.coordinates[j][1]);
														// 포인트 객체를 받아 좌표값으로 변환
														var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																latlng);
														// 포인트객체의 정보로 좌표값 변환 객체로 저장
														var convertChange = new Tmapv2.LatLng(
																convertPoint._lat,
																convertPoint._lng);
														// 배열에 담기
														drawInfoArr
																.push(convertChange);
													}
												} else {
													var markerImg = "";
													var pType = "";
													var size;

													if (properties.pointType == "S") {
														// 출발지 마커
														markerImg = "https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_r_m_s.png";
														pType = "S";
														size = new Tmapv2.Size(
																24, 38);
													} else if (properties.pointType == "E") {
														// 도착지 마커
														markerImg = "https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_r_m_e.png";
														pType = "E";
														size = new Tmapv2.Size(
																24, 38);
													} else {
														// 각 포인트 마커
														markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
														pType = "P";
														size = new Tmapv2.Size(
																8, 8);
													}

													// 경로들의 결과값들을 포인트 객체로 변환
													var latlon = new Tmapv2.Point(
															geometry.coordinates[0],
															geometry.coordinates[1]);

													// 포인트 객체를 받아 좌표값으로 다시 변환
													var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
															latlon);

													var routeInfoObj = {
														markerImage : markerImg,
														lng : convertPoint._lng,
														lat : convertPoint._lat,
														pointType : pType
													};

													// Marker 추가
													marker_p = new Tmapv2.Marker(
															{
																position : new Tmapv2.LatLng(
																		routeInfoObj.lat,
																		routeInfoObj.lng),
																icon : routeInfoObj.markerImage,
																iconSize : size,
																map : map
															});
												}
											} // for문 [E]
											drawLine(drawInfoArr);
										},
										error : function(request, status, error) {
											console.log("code:"
													+ request.status + "\n"
													+ "message:"
													+ request.responseText
													+ "\n" + "error:" + error);
										}
									});
						});
		// POI 통합 검색 API 요청
		$("#btn_select")
				.click(
						function() {
							var searchKeyword = $('#searchKeyword').val();
							var headers = {};
							headers["appKey"] = "8iNXBpO9RuasFtAJ1J2chh2BBTj39kI7R3Lvd0Ib";

							$
									.ajax({
										method : "GET",
										headers : headers,
										url : "https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
										async : false,
										data : {
											"searchKeyword" : searchKeyword,
											"resCoordType" : "EPSG3857",
											"reqCoordType" : "WGS84GEO",
											"count" : 3
										},
										success : function(response) {
											var resultpoisData = response.searchPoiInfo.pois.poi;
											console.log(response); // Log the entire response object to the console

											// 기존 마커, 팝업 제거
											if (markerArr.length > 0) {
												for ( var i in markerArr) {
													markerArr[i].setMap(null);
												}
											}
											var innerHtml = ""; // Search Reulsts 결과값 노출 위한 변수
											var positionBounds = new Tmapv2.LatLngBounds(); //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성

											for ( var k in resultpoisData) {

												var noorLat = Number(resultpoisData[k].noorLat);
												var noorLon = Number(resultpoisData[k].noorLon);
												var name = resultpoisData[k].name;

												var pointCng = new Tmapv2.Point(
														noorLon, noorLat);
												var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
														pointCng);

												var lat = projectionCng._lat;
												var lon = projectionCng._lng;

												var markerPosition = new Tmapv2.LatLng(
														lat, lon);

												marker = new Tmapv2.Marker(
														{
															position : markerPosition,
															icon : "https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_b_m_"
																	+ k
																	+ ".png",
															iconSize : new Tmapv2.Size(
																	24, 38),
															title : name,
															map : map
														});

												innerHtml += "<li><img src='https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_b_m_" + k + ".png' style='vertical-align:middle;'/><span>"
														+ "<span>"
														+ name
														+ "<button class='btn_start' onclick='setStartLocation(\""
														+ name
														+ "\", \""
														+ lat
														+ "\", \""
														+ lon
														+ "\")'>출발지 지정</button>"
														+ "<button class='btn_start' onclick='setEndLocation(\""
														+ name
														+ "\", \""
														+ lat
														+ "\", \""
														+ lon
														+ "\")'>목적지 지정</button>"
														+ "</li>";
												markerArr.push(marker);
												positionBounds
														.extend(markerPosition); // LatLngBounds의 객체 확장
											}

											$("#searchResult").html(innerHtml); //searchResult 결과값 노출
											map.panToBounds(positionBounds); // 확장된 bounds의 중심으로 이동시키기
											map.zoomOut();

										},
										error : function(request, status, error) {
											console.log("code:"
													+ request.status + "\n"
													+ "message:"
													+ request.responseText
													+ "\n" + "error:" + error);
										}
									});
						});
	}

	// 이동경로 그리기
	function addComma(num) {
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}

	function drawLine(arrPoint) {
		var polyline_;

		polyline_ = new Tmapv2.Polyline({
			path : arrPoint,
			strokeColor : "#DD0000",
			strokeWeight : 6,
			map : map
		});
		resultdrawArr.pusah(polyline_);
	}

	// 이름 위도 경도 가져오기
	function setStartLocation(name, lat, lon) {
		document.getElementById("start").value = name;
		document.getElementById("start_lat").value = lat;
		document.getElementById("start_lon").value = lon;
	}

	function setEndLocation(name, lat, lon) {
		document.getElementById("end").value = name;
		document.getElementById("end_lat").value = lat;
		document.getElementById("end_lon").value = lon;
	}
</script>
<style>
.container {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

.search {
	width: 30%;
}

.map {
	width: 70%;
}
</style>
</head>
<body onload="initTmap();">
	<div class="container">
		<div class="search">
			<input type="text" class="text_custom" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하세요.">
			<button id="btn_select">검색하기</button>
			<div class="title">
				<strong>Search</strong> Results
			</div>
			<div class="rst_wrap">
				<div class="rst mCustomScrollbar">
					<ul id="searchResult" name="searchResult">
						<li>검색결과</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="searchroad">
			<input type="text" class="text_custom" id="start" name="start" placeholder="출발지"> <input type="hidden"
				id="start_lat" name="start_lat"> <input type="hidden" id="start_lon" name="start_lon"> <input
				type="text" class="text_custom" id="end" name="end" placeholder="목적지"> <input type="hidden" id="end_lat"
				name="end_lat"> <input type="hidden" id="end_lon" name="end_lon">
			<button id="btn_search">길찾기</button>
		</div>
		<div class="map" id="map_div"></div>
	</div>
	<p id="result"></p>
</body>
</html>