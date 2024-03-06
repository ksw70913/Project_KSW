
// 시간
function worldClock(zone, region){
var dst = 0
var time = new Date()
var gmtMS = time.getTime() + (time.getTimezoneOffset() * 60000)
var gmtTime = new Date(gmtMS)
var day = gmtTime.getDate()
var month = gmtTime.getMonth()
var year = gmtTime.getYear()
if(year < 1000){
year += 1900
}
var monthArray = new Array("January", "February", "March", "April", "May", "June", "July", "August", 
				"September", "October", "November", "December")
var monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31")
if (year%4 == 0){
monthDays = new Array("31", "29", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31")
}
if(year%100 == 0 && year%400 != 0){
monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31")
}

var hr = gmtTime.getHours() + zone
var min = gmtTime.getMinutes()
var sec = gmtTime.getSeconds()

if (hr >= 24){
hr = hr-24
day -= -1
}
if (hr < 0){
hr -= -24
day -= 1
}
if (hr < 10){
hr = " " + hr
}
if (min < 10){
min = "0" + min
}
if (sec < 10){
sec = "0" + sec
}
if (day <= 0){
if (month == 0){
	month = 11
	year -= 1
	}
	else{
	month = month -1
	}
day = monthDays[month]
}
if(day > monthDays[month]){
	day = 1
	if(month == 11){
	month = 0
	year -= -1
	}
	else{
	month -= -1
	}
}

	
if (dst == 1){
	hr -= -1
	if (hr >= 24){
	hr = hr-24
	day -= -1
	}
	if (hr < 10){
	hr = " " + hr
	}
	if(day > monthDays[month]){
	day = 1
	if(month == 11){
	month = 0
	year -= -1
	}
	else{
	month -= -1
	}
	}
return monthArray[month] + " " + day + ", " + year + "<br>" + hr + ":" + min + ":" + sec + " DST"
}
else{
return monthArray[month] + " " + day + ", " + year + "<br>" + hr + ":" + min + ":" + sec
}
}

function worldClockZone(){

document.getElementById("Seoul").innerHTML = worldClock(9, "Seoul")

setTimeout("worldClockZone()", 1000)
}
window.onload=worldClockZone;

// 시간 끝

// 버튼

    document.addEventListener('DOMContentLoaded', function() {
        const findPathButton = document.querySelector('.nav');

        findPathButton.addEventListener('click', function() {
            window.location.href = '../nav/navigation'; // 버튼 클릭 시 이동할 페이지 URL
        });
    });
    
        document.addEventListener('DOMContentLoaded', function() {
        const findPathButton = document.querySelector('.edu');

        findPathButton.addEventListener('click', function() {
            window.location.href = '../edu/education'; // 버튼 클릭 시 이동할 페이지 URL
        });
    });