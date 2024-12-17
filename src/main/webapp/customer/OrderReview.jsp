<%@page import="com.foodApp.Dao.RestaurantDaoImplmpl"%>
<%@page import="com.foodApp.Dto.Restaurant"%>
<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dto.FoodItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setAttribute("menu", "");
%>
<%@include file="/customer/CustomerSession.jsp"%>
<%
if (user == null) {
	RequestDispatcher requestDispatcher = request.getRequestDispatcher("/customer/Login.jsp");
	requestDispatcher.forward(request, response);
	return;
}
int foodId = request.getParameter("foodId") != null ? Integer.parseInt(request.getParameter("foodId")) : -1;
if (foodId == -1) {
	RequestDispatcher requestDispatcher = request.getRequestDispatcher("/customer/UserOrder.jsp");
	requestDispatcher.forward(request, response);
	return;
}

FoodItem foodItem = new FoodItemDaoImpl().getOne(foodId);
Restaurant restaurant = new RestaurantDaoImplmpl().getOne(foodItem.getRestaurantId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="<%=request.getContextPath() + "/Pagination.css"%>">
<%@include file="/CommonUtils.jsp"%>

<style type="text/css">
body {
	font-family: "outfit", sans-serif;
}

.review-section {
	max-width: 1700px;
	margin: 0 auto;
}

.not-found {
	min-height: 80vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.review-section {
	max-width: 70%;
	margin: 0 auto;
	padding: 20px;
}

.review-wrapper h1 {
	font-size: 1.6rem;
}

.review-wrapper div {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

.review-wrapper img {
	width: 350px;
	height: 250px;
	border-radius: 20px;
}

.details {
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	align-items: center;
}

.details h3 {
	font-size: 0.99rem;
	margin-bottom: 1px;
	color: #1d3557
}

.details p {
	margin-bottom: 1px;
	font-size: 0.9rem;
	color: #7209b7;
}

.details h4 {
	font-size: 0.987rem;
	color: #4361ee;
}

.rating-wrapper h1, .rating-wrapper h3 {
	font-size: 1rem;
	color: #3a0ca3;
}

#comment-input {
	margin: 5px 0px;
}

.star {
	font-size: 4vh;
	cursor: pointer;
	color: #efefef;
}

.one {
	color: rgb(255, 0, 0);
}

.two {
	color: #ff9f1c;
}

.three {
	color: rgb(251, 255, 120);
}

.four {
	color: #9ACD32;
}

.five {
	color: rgb(24, 159, 14);
}

.submit-btn-wrapper{
 display: flex;
 justify-content: flex-end;
 width: 100%;
}

.submit-btn-wrapper button {
	padding: 3px 8px;
	border: none;
	border-radius: 10px;
	background: black;
	color: white;
}

@media ( max-width :800px) {
	.review-wrapper img {
		width: 200px;
		height: 200px;
		border-radius: 20px;
	}
	.review-wrapper div {
		flex-direction: column;
	}
	.review-section {
		padding: 10px;
		max-width: 100%;
	}
	.review-wrapper h1{
	 text-align: center;
	}
}
</style>

</head>
<body>
	<%@include file="/customer/Navbar.jsp"%>
	<section class="review-section">

		<%
		if (foodItem == null) {
		%>

		<div class="not-found">
			<p>Page Not Found</p>
		</div>
		<%
		} else {
		%>

		<div class="review-wrapper">
			<h1>Add your review</h1>

			<div>
				<div class="details">
					<h3><%=foodItem.getName()%></h3>
					<p><%=foodItem.getDescription()%></p>
					<h4>
						Restaurant :
						<%=restaurant.getName()%></h4>
				</div>
				<img alt="" src="<%=foodItem.getImg()%>">
			</div>

		</div>
		<div class="rating-wrapper">
			<form action="<%=request.getContextPath()+"/user/food/review" %>" id="review-form" method="post">
			  <h1 class="mb-0">Rating:</h1>
			  <input type="hidden" name="rating" id="rating-input">
			  <input type="hidden" name="foodId" value="<%=foodId%>">
			<div class="review-card">
				<span onclick="gfg(1)" class="star">★ </span> <span onclick="gfg(2)"
					class="star">★ </span> <span onclick="gfg(3)" class="star">★
				</span> <span onclick="gfg(4)" class="star">★ </span> <span
					onclick="gfg(5)" class="star">★ </span>
			</div>
			<p class="error" id="rating-error"></p>
			<h3>Add Your Comment</h3>
			<textarea rows="5"  class="form-control" id="comment-input" name="comment"></textarea>
            <p class="error" id="comment-error"></p>
			 <div class="submit-btn-wrapper">
			    <button id="submit-btn" type="button">Submit</button>
			 </div>
			
			</form>
		</div>


		<%
		}
		%>


	</section>
	<script type="text/javascript"
		src="<%=request.getContextPath() + "/customer/js/ReviewJs.js"%>"></script>
</body>
</html>