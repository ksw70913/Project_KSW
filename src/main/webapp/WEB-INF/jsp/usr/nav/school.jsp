<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="학교 길찾기"></c:set>

<%@ include file="../common/head2.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>지도 이동시키기</title>

<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=8iNXBpO9RuasFtAJ1J2chh2BBTj39kI7R3Lvd0Ib"></script>
<script type="text/javascript">
			var map, marker;
			var markerArr = [], labelArr = [];
			
			function initTmap() {
				// 1. 지도 띄우기
				map = new Tmapv2.Map("map_div", {
					center : new Tmapv2.LatLng(${memberInfo.latitude}, ${memberInfo.longitude}),
					width : "70%",
					height : "400px",
					zoom : 17,
					zoomControl : true,
					scrollwheel : true
				});
	
				// 2. POI 통합 검색 API 요청
				$("#btn_select").click(function(){
					var searchKeyword = $('#searchKeyword').val();
					var headers = {}; 
					headers["appKey"]="8iNXBpO9RuasFtAJ1J2chh2BBTj39kI7R3Lvd0Ib";
					
					$.ajax({
						method:"GET", // 요청 방식
						headers : headers,
						url:"https://apis.openapi.sk.com/tmap/pois/search/around?version=1&format=json&callback=result", // url 주소
						data:{
							"categories" : searchKeyword,
							"resCoordType" : "EPSG3857",
							"searchType" : "name",
							"searchtypCd" : "A",
							"radius" : 1,
							"reqCoordType" : "WGS84GEO",
							"centerLon" : "${memberInfo.longitude}",
							"centerLat" : "${memberInfo.latitude}",
							"count" : 10
						},
						success:function(response){
							console.log(response);
							
							var resultpoisData = response.searchPoiInfo.pois.poi;
							
							// 2. 기존 마커, 팝업 제거
							if(markerArr.length > 0){
								for(var i in markerArr){
									markerArr[i].setMap(null);
								}
								markerArr = [];
							}
		
							if(labelArr.length > 0){
								for(var i in labelArr){
									labelArr[i].setMap(null);
								}
								labelArr = [];
							}
							
							var innerHtml = ""; // Search Reulsts 결과값 노출 위한 변수
							var positionBounds = new Tmapv2.LatLngBounds(); //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
							
							// 3. POI 마커 표시
							for(var k in resultpoisData){
								// POI 마커 정보 저장
								var noorLat = Number(resultpoisData[k].noorLat);
								var noorLon = Number(resultpoisData[k].noorLon);
								var name = resultpoisData[k].name;
								
								// POI 정보의 ID
								var id = resultpoisData[k].id;
								
								// 좌표 객체 생성
								var pointCng = new Tmapv2.Point(noorLon, noorLat);
								
								// EPSG3857좌표계를 WGS84GEO좌표계로 변환
								var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);
								
								var lat = projectionCng._lat;
								var lon = projectionCng._lng;
								
								// 좌표 설정
								var markerPosition = new Tmapv2.LatLng(lat, lon);
								
								// Marker 설정
								marker = new Tmapv2.Marker({
							 		position : markerPosition,
							 		//icon : "/upload/tmap/marker/pin_b_m_a.png",
							 		icon : "https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_b_m_" + k + ".png",
									iconSize : new Tmapv2.Size(24, 38),
									title : name,
									map:map
							 	});
								// 결과창에 나타날 검색 결과 html
								innerHtml += "<li><div><img src='https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_b_m_" 
								+ k + ".png' style='vertical-align:middle;'/><span>"+name+"</span>  "
								+"<button type='button' name='sendBtn' onClick='poiDetail("+id+");'>상세보기</button></div></li>";
								
								// 마커들을 담을 배열에 마커 저장
								markerArr.push(marker);
								positionBounds.extend(markerPosition);	// LatLngBounds의 객체 확장
							}
							
							$("#searchResult").html(innerHtml);	//searchResult 결과값 노출
							map.panToBounds(positionBounds);	// 확장된 bounds의 중심으로 이동시키기
							map.zoomOut();
						},
						error:function(request,status,error){
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
				}).trigger("click");
			}
			
			// 4. POI 상세 정보 API
			function poiDetail(poiId){
			var headers = {}; 
			headers["appKey"]="8iNXBpO9RuasFtAJ1J2chh2BBTj39kI7R3Lvd0Ib";

					
				$.ajax({
					method:"GET",
					headers : headers,
					url:"	https://apis.openapi.sk.com/tmap/pois/"+poiId+"?version=1&resCoordType=EPSG3857&format=json&callback=result",
					async:false,
					success:function(response){
						var detailInfo = response.poiDetailInfo;
						var name = detailInfo.name;
						var address = detailInfo.address;
						
						var noorLat = Number(detailInfo.frontLat);
						var noorLon = Number(detailInfo.frontLon);
						
						var pointCng = new Tmapv2.Point(noorLon, noorLat);
						var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);
						
						var lat = projectionCng._lat;
						var lon = projectionCng._lng;
						
						var labelPosition = new Tmapv2.LatLng(lat, lon);
						
						var content = "<div style=' border-radius:10px 10px 10px 10px;background-color:#2f4f4f; position: relative;"
								+ "line-height: 15px; padding: 5 5px 2px 4; right:65px;'>"
								+ "<div style='font-size: 11px; font-weight: bold ; line-height: 15px; color : white'>"
								+ "name : "
								+ name
								+ "</br>"
								+ "address : "
								+ address + "</div>" + "</div>";
						
						var labelInfo = new Tmapv2.Label({
							position : labelPosition,
							content : content,
							map:map
						});//popup 생성
						
						labelArr.push(labelInfo);
						
					},
					error:function(request,status,error){
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}
</script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	const findPathButton = document.querySelector('.directions');

	findPathButton.addEventListener('click', function() {
		window.location.href = '../nav/navi'; // 버튼 클릭 시 이동할 페이지 URL
	});
});
</script>

<style>
.rst_wrap {
	height: 400px; /* Set the maximum height for the scrollable container */
	overflow-y: auto; /* Enable verhhhhh-tical scrolling */
}
</style>
<body onload="initTmap();">
	<div>
		<input type="text" class="text_custom" id="searchKeyword" name="searchKeyword" value="학교">
		<button id="btn_select">적용하기</button>
	</div>
	<div>
		<div style="width: 30%; float: left;">
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
		<div id="map_div" class="map_wrap" style="float: left"></div>
	</div>
	<br />
	<div>
		<button class="directions">길찾기</button>
	</div>


</body>
</html>