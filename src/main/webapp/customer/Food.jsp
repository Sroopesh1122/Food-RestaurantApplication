<%@page import="com.foodApp.Dao.UserDaopImpl"%>
<%@page import="com.foodApp.Dao.UserDao"%>
<%@page import="com.foodApp.Dto.Review"%>
<%@page import="com.foodApp.Dao.ReviewDaoImpl"%>
<%@page import="com.foodApp.Dao.ReviewDao"%>
<%@page import="com.foodApp.Dao.UserCartDaoImpl"%>
<%@page import="com.foodApp.Dao.UserCartDao"%>
<%@page import="java.util.List"%>
<%@page import="com.foodApp.Dao.RestaurantDaoImplmpl"%>
<%@page import="com.foodApp.Dto.Restaurant"%>
<%@page import="com.foodApp.Dto.FoodItem"%>
<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dao.FoodItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("menu", "");
int foodId = request.getParameter("foodId") != null ? Integer.parseInt(request.getParameter("foodId")) : -1;
FoodItemDao foodItemDao = new FoodItemDaoImpl();
FoodItem foodItem = foodItemDao.getOne(foodId);
Restaurant restaurant = null;
if (foodItem != null) {
	restaurant = new RestaurantDaoImplmpl().getOne(foodItem.getRestaurantId());
}
UserCartDao userCartDao = new UserCartDaoImpl();
%>
<%@include file="/customer/CustomerSession.jsp"%>
<%
int userId = user != null ? user.getUserId() : -1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Food</title>
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

.wrapper {
	max-width: 1700px;
	margin: 0 auto;
}

.not-found {
	min-height: 80vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.food-wrapper {
	max-width: 80%;
	margin: 0 auto;
	padding: 10px;
	display: flex;
	justify-content: flex-start;
	align-items: flex-start;
	gap: 50px;
}

.food-wrapper  img {
	width: 500px;
	height: 500px;
	border: 1px solid #efefef;
	padding: 5px;
	border-radius: 10px;
}

.food-details {
	display: flex;
	flex: 1;
	width: 100%;
	flex-direction: column;
	align-items: flex-start;
}

.details-row {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 1px;
}

.details-row-column {
	display: flex;
}

.food-title {
	font-size: 1.8rem;
}

.food-desc {
	font-weight: 300;
	font-size: 1.05rem;
	color: #14213d;
}

.food-categoies {
	font-size: 1.1rem;
	color: #f72585
}

.food-price-tag {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 2px;
	font-size: 1.5rem;
	font-weight: 300;
}

.restaurant-name {
	font-size: 1.02rem;
	font-weight: 300;
}

.rating-tag {
	padding: 2px 5px;
	border-radius: 5px;
	background: #007b55;
	color: white;
}

.food-rating .fa-star {
	color: #ffd60a;
}

#buy-btn, #cart-btn {
	border: none;
	border-radius: 10px;
	padding: 2px 10px;
	font-size: 0.98rem;
}

#cart-btn {
	background: #14213d;
	color: white;
}

#buy-btn {
	background: #ef233c;
	color: white;
	margin-right: 5px;
}

.no-review {
	width: 70%;
	border-radius: 10px;
	height: 20vh;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px solid #efefef;
}

.review-section {
	width: 80%;
	margin: 0 auto;
}

.review-section h6 {
	margin-bottom: 10px;
}

.review-card {
	border: 1px solid #efefef;
	padding: 10px;
	border-radius:10px;
	margin: 5px 0px;
}
.review-items-wrapper{
 padding: 10px;
}

.review-cart-title{
 display: flex;
 justify-content: space-between;
 padding: 0 10px;
 align-items: center;
}

.review-cart-title span:first-child {
	font-size: 0.9rem;
	font-weight: 300;

}
.review-cart-title span:last-child {
	font-size: 0.7rem;
	font-weight: 300;

}
.review-cart-title span:first-child i{
 color: #ffd60a;
}
.review-comment{
 padding: 10px;
}
.review-comment h6{
 font-weight: 200;
}
.review-comment p{
 padding: 5px;
 border-radius: 10px;
 border:1px solid #efefef;
}
@media (max-width: 768px) {

 .food-wrapper  img {
	width: 300px;
	height: 300px;
	border: 1px solid #efefef;
	padding: 5px;
	border-radius: 10px;
}
	
}

@media (max-width: 500px) {

 .food-wrapper {
	flex-direction: column;
	max-width: 98%;
	align-items: center;
}
.review-section {
	width: 98%;
	margin: 0 auto;
}
.review-cart-title span:first-child {
	font-size: 0.8rem;
	font-weight: 300;

}
.review-cart-title span:last-child {
	font-size: 0.5rem;
	font-weight: 300;

}
.review-comment{
 padding: 3px;
}

	
}
</style>

</head>
<body>
	<%@include file="/customer/Navbar.jsp"%>

	<section class="wrapper">

		<%
		if (foodItem == null || restaurant == null) {
		%>
		<div class="not-found">
			<p>Page Not Found</p>
		</div>

		<%
		return;
		}
		%>


		<div class="food-wrapper">

			<img alt="" src="<%=foodItem.getImg()%>">

			<div class="food-details">

				<div class="details-row">
					<div class="details-row-column">
						<h1 class="food-title"><%=foodItem.getName()%></h1>
					</div>

				</div>
				<div class="details-row">
					<div class="details-row-column">
						<p class="mb-0 food-desc"><%=foodItem.getDescription()%></p>
					</div>
				</div>

				<div class="details-row food-categoies">
					<div class="details-row-column">Catgories :</div>
					<div class="details-row-column">
						<p class="mb-0">
							<%
							String[] categories = foodItem.getCategory().split(",");
							for (String category : categories) {
							%>
							<span><%="#" + category%></span>
							<%
							}
							%>
						</p>
					</div>
				</div>

				<div class="details-row">
					<div class="details-row-column">
						<span class="food-price-tag"> <i
							class="fa-solid fa-indian-rupee-sign"></i><%=foodItem.getPrice()%></span>
					</div>
				</div>

				<div class="details-row restaurant-name">
					<div class="details-row-column">
						<span>Restaurant : </span>
					</div>
					<div class="details-row-column">
						<span><%=restaurant.getName()%></span>
					</div>
				</div>


				<%
				if (foodItem.getRating() > 0) {
				%>
				<div class="details-row food-rating">
					<div class="details-row-column">
						<span class="rating-tag"><i class="fa-solid fa-star"></i> <%=foodItem.getRating()%>
						</span>
					</div>
				</div>
				<%
				}
				%>

				<div class="details-row mt-3">
					<div class="details-row-column">
						<button id="buy-btn" onclick="handleBuyClick('<%=request.getContextPath()+"/customer/OrderFood.jsp?foodId="+foodItem.getFoodId() %>')" >Buy</button>
					</div>
					<div class="details-row-column">
						<%
						boolean isSaved = user != null ? userCartDao.getCartItem(userId, foodItem.getFoodId()) : false;
						if (!isSaved) {
						%>
						<button id="cart-btn"
							onclick="handleCartBtnClick('<%=userId%>' , '<%=foodItem.getFoodId()%>' , '<%=request.getContextPath() + "/customer/Login.jsp"%>', '<%=request.getContextPath() + "/user/cart/add"%>')">
							<i class="fa-solid fa-cart-shopping"></i> Add to cart
						</button>
						<%
						} else {
						%>
						<button id="cart-btn">
							<i class="fa-solid fa-cart-shopping"></i> Saved
						</button>
						<%
						}
						%>
						</button>
					</div>
				</div>

			</div>

		</div>


		<article class="review-section">
			<h6>Reviews</h6>
			<%
			ReviewDao reviewDao = new ReviewDaoImpl();
			List<Review> reviews = reviewDao.getReviewByFoodId(foodItem.getFoodId());
			if (reviews.size() == 0) {
			%>
			<div class="no-review">
				<p>No review found</p>
			</div>
			<%
			} else {
			%>
			<div class="review-items-wrapper">

				<%
				int reviewSize = (reviews.size() - 1 > 5) ? 5 : reviews.size() - 1;
				UserDao userDao = new UserDaopImpl();
				for (int i = 0; i <= reviewSize; i++) {
					Review review = reviews.get(i);
					User reviewUser = userDao.getOne(review.getUserId());
				%>

				<div class="review-card">
					<h5 class="review-cart-title">
						<span><%=reviewUser.getName()%> <i
							class="fa-solid fa-star"></i><%=review.getRating()%></span> <span><%=review.getReviewDate().toLocaleString()%></span>
					</h5>
					<div class="review-comment">
					     <h6>Comment : </h6>
						<p><%=review.getComment()%></p>
					</div>

				</div>
				<%
				}
				%>
			</div>

			<%
			}
			%>
		</article>
		
		

	</section>
	<script type="text/javascript"
		src="<%=request.getContextPath() + "/customer/js/Food.js"%>"></script>
</body>
</html>