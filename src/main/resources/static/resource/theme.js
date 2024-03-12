
// 시간
function worldClock(zone, region) {
	var dst = 0
	var time = new Date()
	var gmtMS = time.getTime() + (time.getTimezoneOffset() * 60000)
	var gmtTime = new Date(gmtMS)
	var day = gmtTime.getDate()
	var month = gmtTime.getMonth()
	var year = gmtTime.getYear()
	if (year < 1000) {
		year += 1900
	}
	var monthArray = new Array("January", "February", "March", "April", "May", "June", "July", "August",
		"September", "October", "November", "December")
	var monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31")
	if (year % 4 == 0) {
		monthDays = new Array("31", "29", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31")
	}
	if (year % 100 == 0 && year % 400 != 0) {
		monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31")
	}

	var hr = gmtTime.getHours() + zone
	var min = gmtTime.getMinutes()
	var sec = gmtTime.getSeconds()

	if (hr >= 24) {
		hr = hr - 24
		day -= -1
	}
	if (hr < 0) {
		hr -= -24
		day -= 1
	}
	if (hr < 10) {
		hr = " " + hr
	}
	if (min < 10) {
		min = "0" + min
	}
	if (sec < 10) {
		sec = "0" + sec
	}
	if (day <= 0) {
		if (month == 0) {
			month = 11
			year -= 1
		}
		else {
			month = month - 1
		}
		day = monthDays[month]
	}
	if (day > monthDays[month]) {
		day = 1
		if (month == 11) {
			month = 0
			year -= -1
		}
		else {
			month -= -1
		}
	}


	if (dst == 1) {
		hr -= -1
		if (hr >= 24) {
			hr = hr - 24
			day -= -1
		}
		if (hr < 10) {
			hr = " " + hr
		}
		if (day > monthDays[month]) {
			day = 1
			if (month == 11) {
				month = 0
				year -= -1
			}
			else {
				month -= -1
			}
		}
		return monthArray[month] + " " + day + ", " + year + "<br>" + hr + ":" + min + ":" + sec + " DST"
	}
	else {
		return monthArray[month] + " " + day + ", " + year + "<br>" + hr + ":" + min + ":" + sec
	}
}

function worldClockZone() {

	document.getElementById("Seoul").innerHTML = worldClock(9, "Seoul")

	setTimeout("worldClockZone()", 1000)
}
window.onload = worldClockZone;

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

document.addEventListener('DOMContentLoaded', function() {
	const findPathButton = document.querySelector('.books');

	findPathButton.addEventListener('click', function() {
		window.location.href = '../edu/book'; // 버튼 클릭 시 이동할 페이지 URL
	});
});


// 날씨

const apiKey = '5992c62bb27f9966f1497a8fb4ae54d5';
const city = 'Daejeon'; // 원하는 도시 이름으로 대체하세요.

const url = `http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;

fetch(url)
	.then(response => {
		if (!response.ok) {
			throw new Error('네트워크 응답이 정상적이지 않습니다.');
		}
		return response.json();
	})
	.then(data => {
		// 응답에서 관련된 날씨 정보 추출
		const weatherDescription = data.weather[0].description;
		const temperature = data.main.temp;
		const humidity = data.main.humidity;
		const windSpeed = data.wind.speed;

		// 날씨 아이콘 코드 가져오기
		const iconCode = data.weather[0].icon;
		const iconUrl = `http://openweathermap.org/img/wn/${iconCode}.png`;

		// 날씨 정보를 표시할 요소 생성
		const weatherInfoContainer = document.getElementById('weather-info');
		const cityElement = document.createElement('p');
		cityElement.innerHTML = `<strong>도시:</strong> ${city}`;
		const descriptionElement = document.createElement('p');
		descriptionElement.innerHTML = `<strong>날씨:</strong> ${weatherDescription}`;
		const temperatureElement = document.createElement('p');
		temperatureElement.innerHTML = `<strong>온도:</strong> ${temperature}°C`;
		const humidityElement = document.createElement('p');
		humidityElement.innerHTML = `<strong>습도:</strong> ${humidity}%`;
		const windSpeedElement = document.createElement('p');
		windSpeedElement.innerHTML = `<strong>풍속:</strong> ${windSpeed} m/s`;

		// 날씨 아이콘을 위한 img 요소 생성
		const iconElement = document.createElement('img');
		iconElement.src = iconUrl;
		iconElement.alt = '날씨 아이콘';
		iconElement.style.width = '100px'; // 아이콘의 너비를 조정하여 크기를 변경
		iconElement.style.height = 'auto'; // 비율 유지

		// 요소를 weather-info div에 추가
		weatherInfoContainer.appendChild(cityElement);
		weatherInfoContainer.appendChild(descriptionElement);
		weatherInfoContainer.appendChild(temperatureElement);
		weatherInfoContainer.appendChild(humidityElement);
		weatherInfoContainer.appendChild(windSpeedElement);
		weatherInfoContainer.appendChild(iconElement);
	})
	.catch(error => {
		console.error('날씨 데이터를 가져오는 중 문제가 발생했습니다:', error);
	});
