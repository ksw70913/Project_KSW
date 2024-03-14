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
        var markerArr = [];
        var resultdrawArr = [];

        function initTmap() {
            // 지도 띄우기
            map = new Tmapv2.Map("map_div", {
                center: new Tmapv2.LatLng(36.35101072771798, 127.38031136394397),
                width: "100%",
                height: "400px",
                zoom: 17,
                zoomControl: true,
                scrollwheel: true
            });

            // POI 통합 검색 API 요청
            $("#btn_select").click(function () {
                var searchKeyword = $('#searchKeyword').val();
                var headers = {};
                headers["appKey"] = "8iNXBpO9RuasFtAJ1J2chh2BBTj39kI7R3Lvd0Ib";

                $.ajax({
                    method: "GET",
                    headers: headers,
                    url: "https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
                    async: false,
                    data: {
                        "searchKeyword": searchKeyword,
                        "resCoordType": "EPSG3857",
                        "reqCoordType": "WGS84GEO",
                        "count": 10
                    },
                    success: function (response) {
                        var resultpoisData = response.searchPoiInfo.pois.poi;

                        // 기존 마커, 팝업 제거
                        if (markerArr.length > 0) {
                            for (var i in markerArr) {
                                markerArr[i].setMap(null);
                            }
                        }
                        var innerHtml = ""; // Search Reulsts 결과값 노출 위한 변수
                        var positionBounds = new Tmapv2.LatLngBounds(); //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성

                        for (var k in resultpoisData) {

                            var noorLat = Number(resultpoisData[k].noorLat);
                            var noorLon = Number(resultpoisData[k].noorLon);
                            var name = resultpoisData[k].name;

                            var pointCng = new Tmapv2.Point(noorLon, noorLat);
                            var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);

                            var lat = projectionCng._lat;
                            var lon = projectionCng._lng;

                            var markerPosition = new Tmapv2.LatLng(lat, lon);

                            marker = new Tmapv2.Marker({
                                position: markerPosition,
                                icon: "https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_b_m_" + k + ".png",
                                iconSize: new Tmapv2.Size(24, 38),
                                title: name,
                                map: map
                            });

                            innerHtml += "<li><img src='https://tmapapi.tmapmobility.com/upload/tmap/marker/pin_b_m_" + k + ".png' style='vertical-align:middle;'/><span>" + name + "</span></li>";

                            markerArr.push(marker);
                            positionBounds.extend(markerPosition); // LatLngBounds의 객체 확장
                        }

                        $("#searchResult").html(innerHtml); //searchResult 결과값 노출
                        map.panToBounds(positionBounds); // 확장된 bounds의 중심으로 이동시키기
                        map.zoomOut();

                    },
                    error: function (request, status, error) {
                        console.log("code:" + request.status + "\n"
                            + "message:" + request.responseText + "\n"
                            + "error:" + error);
                    }
                });
            });
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
        <input type="text" class="text_custom" id="searchKeyword" name="searchKeyword" value="검색어를 입력하세요.">
        <button id="btn_select">적용하기</button>
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
    <div class="map" id="map_div"></div>
</div>
</body>
</html>