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