<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>HELPER</title>
<link rel="stylesheet" href="/resource/main.css" />
<script src="/resource/common.js" defer="defer"></script>
<link rel="stylesheet" href="/resource/theme.css" />
<script src="/resource/theme.js" defer="defer"></script>
<!-- 테일윈드 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" />

<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

<!-- 제이쿼리 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<header>
	<nav>

		<div class="h-20 flex mx-auto items-center text-3xl">
			<a href="../home/main"><img
				src="https://velog.velcdn.com/images/pavico0913/post/ca2b48c6-583a-421d-80dd-6154a8073b1c/image.png" alt=""
				width="160" height="30"></a>

		</div>
		<ul class="navigation-menu">
			<li><a href="#">사이트 기능</a>
				<ul class="subnav">
					<li class="card-med" id="sup-dog">
						<div class="card-image">
							<a href="../edu/book"><img
								src="https://ouch-cdn2.icons8.com/qPvaAv2gxwM3l0z7dl_eoh9v6h58HlzewBUfEgX6AZE/rs:fit:368:386/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMTIv/ZmM4YjNlYmItMDNj/Ni00NGM3LTliNGUt/YTUyOWUzOGU4NTE2/LnBuZw.png"></a>

						</div> <a href="../edu/book"> <span>교과서 등록 </span> <!-- <span><span class="material-symbols-outlined">
									</span></span> -->
					</a>
					</li>
					<li class="card-med" id="sup-cat">
						<div class="card-image">
							<a href="../nav/navigation"> <img
								src="https://ouch-cdn2.icons8.com/US6gJ6fHUOJqruLB7KDe5zEa82iDSp7OdO-bv-aLtvU/rs:fit:368:310/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNjU5/LzdmOWU1ZjU0LTMx/ZDQtNDgwNS1iM2E2/LWM3NzgyMTcyNzJh/NC5wbmc.png"></a>
						</div> <a href="../nav/navigation"> <span>학교 길찾기</span> <!-- <span>Shop All <span class="material-symbols-outlined">
									arrow_forward </span></span> -->
					</a>
					</li>
					<li class="card-med" id="sup-bird">
						<div class="card-image">
							<a href="../edu/education"> <img
								src="https://ouch-cdn2.icons8.com/6OkSfKKP476ZKzGJoDlXfXuWzX-vjlDRotIVMTz3lmo/rs:fit:368:396/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNzA1/LzRkNmI1YjIwLTQy/YWQtNDVlMC05ZDI5/LTA0MTkyMWZkNWE1/NS5wbmc.png"></a>
						</div> <a href="../edu/education"> <span>학습 현황</span> <!-- <span>Shop All <span class="material-symbols-outlined">
									arrow_forward </span></span> -->
					</a>
					</li>
					<li class="card-med" id="sup-fish">
						<div class="card-image">
							<a href="../article/list"> <img
								src="https://ouch-cdn2.icons8.com/41Pv7w9rcbn7II_gB2vwvVCQRYE5mvpca1ZbsvMujR0/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNjE5/LzRlZjE1YTgyLTI3/NjYtNDlkNC1hMGE3/LWY4ZjRmNzhjM2M5/NS5wbmc.png"></a>
						</div> <a href="../article/list"> <span>커뮤니티</span></a> <a href="../article/list?boardId=1&page=1"><span>NOTICE</span></a>
						<a href="../article/list?boardId=2&page=1"><span>FREE</span></a> <a href="../article/list?boardId=3&page=1"><span>QnA</span></a>
					</li>
				</ul></li>
			<c:if test="${rq.isLogined() }">
				<li><a href="#">교과서</a>
					<ul class="subnav">
						<li class="card-med" id="sup-dog">
							<div class="card-image">
								<a href="../edu/book"> <img
									src="https://ouch-cdn2.icons8.com/5ccPOQq69UKQcbmXfjvOScfFc9NXKG0Xu6DPNQ8b0f8/rs:fit:368:247/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMTEw/LzFlODdiYzcyLTBl/OWEtNDFlNS05N2Ey/LTMzYTA4MDQ5MWU1/OC5wbmc.png"></a>
							</div> <a href="../edu/book"> <span>교과서</span></a> <a href="../edu/book?boardId=4&page=1"><span>초등학교</span></a> <a
							href="../edu/book?boardId=5&page=1"><span>중학교</span></a> <a href="../edu/book?boardId=6&page=1"><span>고등학교</span></a>
						</li>

						<li class="card-med" id="serv-board">
							<div class="card-image">
								<a href="../article/write"> <img
									src="https://ouch-cdn2.icons8.com/F5Ea1suZtMYimKDkJr0CJLO_1bju6-bTyT1EuDKEg8s/rs:fit:368:254/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMjcx/LzVjMzE4NWM0LWZh/NTMtNGQ1OS05ZTM2/LTZjYzBhNGU3ODg0/NC5wbmc.png"></a>
							</div> <a href="../article/write"> <span>글 쓰기</span> <!-- <span>More Info<span class="material-symbols-outlined">
									arrow_forward </span></span> -->
						</a>
					</ul></li>
			</c:if>
			<c:if test="${rq.isLogined() }">
				<li><a href="#">메뉴</a>
					<ul class="subnav">
						<li class="card-med" id="serv-groom">
							<div class="card-image">
								<a href="/usr/member/myPage"> <img
									src="https://ouch-cdn2.icons8.com/T11rfGmMKgcStJyAFKNgtOfE79cadabx0DVMnvzA9Pk/rs:fit:368:313/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNDQx/LzFlYWU4MWY3LWQ1/ZjYtNDM2Ny1hZjM5/LWVmNTFmMGM5Njk4/MS5wbmc.png"></a>
							</div> <a href="/usr/member/myPage"> <span>내 정보</span> <!-- <span>More Info <span class="material-symbols-outlined">
									arrow_forward </span></span> -->
						</a>
						</li>

						<li class="card-med" id="serv-board">
							<div class="card-image">
								<a href="../article/write"> <img
									src="https://ouch-cdn2.icons8.com/F5Ea1suZtMYimKDkJr0CJLO_1bju6-bTyT1EuDKEg8s/rs:fit:368:254/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMjcx/LzVjMzE4NWM0LWZh/NTMtNGQ1OS05ZTM2/LTZjYzBhNGU3ODg0/NC5wbmc.png"></a>
							</div> <a href="../article/write"> <span>글 쓰기</span> <!-- <span>More Info<span class="material-symbols-outlined">
									arrow_forward </span></span> -->
						</a>
					</ul></li>

			</c:if>
			<c:if test="${!rq.isLogined() }">
				<li><a href="../member/login">LOGIN &amp; JOIN</a></li>
			</c:if>
			<c:if test="${rq.isLogined() }">
				<li><a onclick="if(confirm('로그아웃 할래?') == false) return false;" class="hover:underline"
					href="../member/doLogout">LOGOUT</a></li>
			</c:if>
			<li><a href="#">회원 탈퇴</a></li>
		</ul>
		<div id="utility">
			<span class="material-symbols-outlined"><a href="#">↑</a> </span>
			<!--  <span class="material-symbols-outlined"> shopping_cart
			</span> -->

		</div>
	</nav>
</header>
<section class="hero">
	<h1>학교로 가는 안전한 길!</h1>
	<h1>온라인으로 만나는 학습 동기 부여!</h1>
	<div class="btn-group">
		<button class="btn-filled-dark nav">
			<span class="material-symbols-outlined"> 길 찾기 </span> (바로가기)
		</button>
		<button class="btn-outline-dark btn-hover-color edu">
			<span class="material-symbols-outlined"> 학습 상태 </span> (바로가기)
		</button>
	</div>

</section>
<section>
	<h2>Menu</h2>

	<ul class="shop-pets">
		<li class="card-large card-light" id="sup-dog">
			<div class="card-image">
				<img
					src="https://ouch-cdn2.icons8.com/5ccPOQq69UKQcbmXfjvOScfFc9NXKG0Xu6DPNQ8b0f8/rs:fit:368:247/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMTEw/LzFlODdiYzcyLTBl/OWEtNDFlNS05N2Ey/LTMzYTA4MDQ5MWU1/OC5wbmc.png">
			</div>
			<ul>
				교과서 등록
				<li><a href="../edu/book?boardId=4&page=1">초등학교</a></li>
				<li><a href="../edu/book?boardId=5&page=1">중학교</a></li>
				<li><a href="../edu/book?boardId=6&page=1">고등학교</a></li>

				<button class="btn-outline-light books">바로가기</button>

			</ul>


		</li>

		<li class="card-large card-dark" id="sup-cat">
			<div class="card-image">
				<img
					src="https://ouch-cdn2.icons8.com/RjiKOF2gGKiIVnIMFi0O1a4aU7DoHfhbkXr2JbUYZ3A/rs:fit:368:313/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMzEy/LzliNDQ3MmVlLWZh/YjMtNDQwNy1iOWVh/LWMwOTdlYWNjNWE3/NS5wbmc.png">
			</div>
			<ul>
				나의 정보
				<li><a href="/usr/member/myPage">내 정보</a></li>
				<li><a href="/usr/member/checkPw">정보 수정</a></li>
				<li><a href="#">회원 탈퇴</a></li>
				<button class="btn-outline-dark">					바로가기
					<!-- 					<span class="material-symbols-outlined"> arrow_forward </span> -->
				</button>
			</ul>

		</li>

		<li class="card-large card-dark" id="sup-bird">
			<div class="card-image">
				<img
					src="https://ouch-cdn2.icons8.com/DF-XRInvbvWS9fQSpWc_SegC3meXZK8BmE-PjrdrF3Q/rs:fit:368:396/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNzI3/LzQyYWIyNzliLWJj/ZDgtNGEyMC04MGRi/LTk3MzU4YWFmNTVk/OS5wbmc.png">
			</div>
			<ul>
				네비게이션
				<li><a href="#">내 학교 찾기</a></li>
				<li><a href="#">길 안내</a></li>
				<li><a href="#">Furniture</a></li>
				<button class="btn-outline-dark">바로가기</button>
			</ul>

		</li>
		<li class="card-large card-light" id="sup-fish">
			<div class="card-image">
				<img
					src="https://ouch-cdn2.icons8.com/41Pv7w9rcbn7II_gB2vwvVCQRYE5mvpca1ZbsvMujR0/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNjE5/LzRlZjE1YTgyLTI3/NjYtNDlkNC1hMGE3/LWY4ZjRmNzhjM2M5/NS5wbmc.png">
			</div>
			<ul>
				로그인 &amp; 회원가입
				<li><a href="#">로그인</a></li>
				<li><a href="#">회원가입</a></li>
				<li><a href="#">비밀번호 찾기</a></li>
				<button class="btn-outline-light">바로가기</button>
			</ul>

		</li>
	</ul>
</section>

<section>
	<h2>Our Services</h2>

	<ul class="services">
		<li class="card-large card-dark card-wide" id="serv-groom">
			<div class="card-image">
				<img
					src="https://ouch-cdn2.icons8.com/T11rfGmMKgcStJyAFKNgtOfE79cadabx0DVMnvzA9Pk/rs:fit:368:313/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNDQx/LzFlYWU4MWY3LWQ1/ZjYtNDM2Ny1hZjM5/LWVmNTFmMGM5Njk4/MS5wbmc.png">
			</div>
			<ul>
				나의 학습
				<span class="subtitle">Tail-wagging transformations are our specialty.</span>
				<li><a href="#">Coat Care</a><span>$80</span></li>
				<li><a href="#">Nail Care</a><span>$16</span></li>
				<li><a href="#">Doggie Deluxe Spa Day</a><span>$160</span></li>
				<button class="btn-filled-dark">
					<span class="material-symbols-outlined"> calendar_month </span>Book Now
				</button>

			</ul>


		</li>
		<li class="card-large card-dark card-wide" id="serv-board">
			<div class="card-image">
				<img
					src="https://ouch-cdn2.icons8.com/F5Ea1suZtMYimKDkJr0CJLO_1bju6-bTyT1EuDKEg8s/rs:fit:368:254/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMjcx/LzVjMzE4NWM0LWZh/NTMtNGQ1OS05ZTM2/LTZjYzBhNGU3ODg0/NC5wbmc.png">
			</div>
			<ul>
				네비게이션
				<span class="subtitle">Where fun and care never take a day off.</span>
				<li><a href="#">Doggie Daycare</a><span>$80</span></li>
				<li><a href="#">Short Term Boarding</a><span>$80</span></li>
				<button class="btn-filled-dark">
					<span class="material-symbols-outlined"> calendar_month </span>Book Now
				</button>
			</ul>

		</li>
	</ul>
</section>

<section id="locate"></section>

<style>
footer {
	color: #ffffff; /* 푸터 텍스트의 색상을 흰색으로 설정 */
	text-align: center;
	display: flex;
	justify-content: center;
}
</style>


<div class="sidebar">
	<div class="clock">
		<span id="Seoul"></span>
	</div>
</div>

<footer>

	<div>

		<!-- 		<div class="btn-group">
			<button class="btn-filled-dark">
				<span class="material-symbols-outlined"> pin_drop </span>Find a Store
			</button>
			<button class="btn-outline-dark btn-hover-color">
				<span class="material-symbols-outlined"> contact_support </span> Contact Us
			</button>
		</div> -->
		<!-- 	<ul> -->
		<!-- 		교과서 등록 -->
		<!-- 		<li><a href="#">국여</a></li> -->
		<!-- 		<li><a href="#">수학</a></li> -->
		<!-- 		<li><a href="#">영어</a></li> -->
		<!-- 		<li><a href="#">과학</a></li> -->
		<!-- 		<li><a href="#">도덕</a></li> -->
		<!-- 		<li><a href="#">Aquariums</a></li> -->
		<!-- 		<li><a href="#">Rocks &amp; Decorations</a></li> -->
		<!-- 	</ul> -->

		<!-- 	<ul> -->
		<!-- 		나의 정보 -->
		<!-- 		<li><a href="#">내 정보</a></li> -->
		<!-- 		<li><a href="#">회원 수정</a></li> -->
		<!-- 		<li><a href="#">회원 탈퇴</a></li> -->
		<!-- 		<li><a href="#">Fish</a></li> -->
		<!-- 	</ul> -->


		<!-- 	<ul> -->
		<!-- 		네비게이션 -->
		<!-- 		<li><a href="#">내 학교 찾기</a></li> -->
		<!-- 		<li><a href="#">길 안내</a></li> -->
		<!-- 	</ul> -->
		<!-- 	<ul> -->
		<!-- 		로그인 &amp; 회원가입 -->
		<!-- 		<li><a href="#">로그인</a></li> -->
		<!-- 		<li><a href="#">회원가입</a></li> -->
		<!-- 	</ul> -->
</footer>