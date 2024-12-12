<%@page import="com.foodApp.Dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("menu", "Home");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FOS</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="/CommonUtils.jsp"%>
<style type="text/css">
body {
	font-family: "outfit", sans-serif;
}

section {
	max-width: 1800px;
	margin: 0 auto;
}

.hero-wrapper {
	max-width: 1800px;
	margin: 0 auto;
	min-height: 600px;
	background: white;
	position: relative;
}

.hero-section {
	width: 100%;
	height: 100%;
	background: #001219;
	position: absolute;
	top: 0;
	left: 0;
	clip-path: polygon(77% 0, 100% 0, 100% 100%, 48% 100%);
}

.hero-wrapper header {
	width: 60%;
	height: 600px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	position: relative;
}

.hero-wrapper header div {
	position: relative;
}

.hero-wrapper header h1 {
	font-size: 5.5rem;
	font-family: "Barlow Condensed", sans-serif;
	z-index: 20;
}

.hero-wrapper header h1:first-child span {
	color: #f05d5e;
}

#coco-img {
	width: 150px;
	position: absolute;
	height: 250px;
	right: 0%;
	filter: drop-shadow(0px 2px 6px black);
	transform: rotate(-40deg);
	bottom: 25%;
	z-index: 1;
}

#plate {
	width: 500px;
	position: absolute;
	height: 500px;
	right: 300px;
	top: 10%;
	filter: drop-shadow(0px 2px 6px black);
}

.food-menu-section {
	padding: 80px 20px;
	background: #001219;
	color: white;
}

.food-menu-section .header {
	width: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.food-menu-section .header h1:last-child {
	color: #f05d5e;
}

.content-wrapper {
	width: 60%;
	margin: 40px auto 0px auto;
}

.food-card {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 100px;
	margin-top: 30px;
}

.food-card img {
	width: 450px;
	height: 350px;
	border-radius: 10px;
}

.food-card .food-content {
	width: 450px;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 10px;
	max-height: 300px;
	color: white;
	flex-direction: column;
	padding: 15px;
	background: rgba(255, 255, 255, 0.05);
	box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37) !important;
	backdrop-filter: blur(0.5px);
	-webkit-backdrop-filter: blur(0.5px);
	border-radius: 10px;
	transition: all 0.3s;
}

.food-card .food-content:hover {
	transform: scale(1.05);
}

.food-content .title {
	color: #f05d5e;
}

.food-content p {
	text-align: justify;
	font-size: 0.8rem;
}

.food-card:nth-child(even) {
	flex-direction: row-reverse;
}

@media ( max-width :1024px) {
	#coco-img {
		transform: scale(0.7) rotate(-40deg);
	}
	#plate {
		width: 400px;
		position: absolute;
		height: 400px;
		right: 100px;
		top: 30%;
	}
	.food-card {
		flex-direction: column !important;
		gap: 3px;
	}
	.food-card img {
		width: 300px;
		height: 250px;
		border-radius: 10px;
	}
	.food-card .food-content {
		width: 300px;
	   max-height: 100%;
	}
}

@media ( max-width :768px) {
	#coco-img {
		transform: scale(0.8) rotate(-40deg);
		filter: drop-shadow(0px 2px 6px white);
	}
	#plate {
		transform: scale(0.9);
		right: 10px;
		top: 10%;
	}
	.hero-wrapper header h1 {
		font-size: 3.5rem;
		color: white;
	}
	.hero-section {
		clip-path: none;
	}
}

@media ( max-width :425px) {
	#coco-img {
		transform: scale(0.6) rotate(-40deg);
		filter: drop-shadow(0px 2px 6px white);
	}
	#plate {
		transform: scale(0.4);
		right: -100px !important;
		top: -10%
	}
	.hero-wrapper header h1 {
		font-size: 3.5rem;
		color: white;
	}
	.hero-section {
		clip-path: none;
	}
	.hero-wrapper header {
		width: 100%;
	}
}
</style>
</head>
<body>
	<%@include file="/customer/Navbar.jsp"%>
	<section class="hero-wrapper">
		<div class="hero-section"></div>

		<header>
			<div>
				<h1>
					FOODS <span>&</span>
				</h1>
				<h1>RESTAURANTS</h1>
				<img alt="" id="coco-img"
					src="<%=request.getContextPath() + "/images/img7.png"%>">
			</div>
		</header>
		<img alt="" id="plate"
			src="<%=request.getContextPath() + "/images/img8.png"%>">
	</section>

	<section class="food-menu-section">

		<div class="header">
			<h1>Your Food is Waiting for you</h1>
			<h1>Choose your Menu &#128523;</h1>
		</div>

		<div class="content-wrapper">

			<article class="food-card">

				<img alt=""
					src="https://img.freepik.com/premium-photo/top-view-south-indian-foods-served-platter_641503-88185.jpg">

				<div class="food-content">
					<h1 class="text-center title">South Indian</h1>
					<p>South Indian cuisine is celebrated for its bold flavors,
						aromatic spices, and wholesome ingredients. Staples like rice,
						lentils, and coconut form the base of many dishes, complemented by
						tamarind, curry leaves, and spices like mustard seeds and chilies.
						Popular dishes include idli, soft rice-lentil cakes served with
						sambar and chutneys, and dosa, crispy rice-lentil pancakes often
						stuffed with spiced potatoes. This vibrant cuisine offers a
						perfect balance of flavors and textures.</p>
				</div>

			</article>

			<article class="food-card">

				<img alt=""
					src="https://static.vecteezy.com/system/resources/previews/030/760/696/non_2x/vibrant-indian-curries-and-naan-arranged-on-a-black-background-generative-ai-photo.jpg">

				<div class="food-content">
					<h1 class="text-center title">North Indian</h1>
					<p>North Indian cuisine is known for its rich, hearty flavors
						and a wide variety of dishes that reflect the diverse cultural
						heritage of the region. The cuisine heavily features wheat-based
						staples like roti, naan, and paratha, along with flavorful curries
						and gravies made using ghee, cream, and aromatic spices such as
						cardamom, cumin, and cinnamon. Popular dishes include butter
						chicken, paneer tikka, and dal makhani, often accompanied by
						fragrant basmati rice or biryanis. Known for its indulgent
						textures and robust flavors, North Indian food offers a delightful
						balance of spices, tanginess, and richness that makes it a
						favorite across the world.</p>
				</div>

			</article>

			<article class="food-card">

				<img alt=""
					src="https://media.istockphoto.com/id/1038065454/photo/bowls-with-chow-mein.jpg?s=612x612&w=0&k=20&c=Um-yBOKIzCrccvMRjIpm0_h6xFhkx5q8okrYdGa75aM=">

				<div class="food-content">
					<h1 class="text-center title">Chinese</h1>
					<p>Chinese cuisine is renowned for its rich diversity, bold
						flavors, and emphasis on balance and harmony in taste and texture.
						It features a variety of cooking techniques, including
						stir-frying, steaming, and deep-frying, often using ingredients
						like soy sauce, garlic, ginger, and sesame oil. Rice, noodles, and
						dumplings are staples, complemented by fresh vegetables, tofu, and
						meats. Popular dishes include fried rice, kung pao chicken, sweet
						and sour pork, and dim sum. Chinese food is celebrated for its
						ability to combine savory, sweet, spicy, and sour flavors,
						creating dishes that are both satisfying and flavorful.</p>
				</div>

			</article>

		</div>


	</section>


</body>
</html>