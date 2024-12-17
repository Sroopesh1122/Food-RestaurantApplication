<%@page import="com.foodApp.Dao.ReviewDaoImpl"%>
<%@page import="com.foodApp.Dto.Review"%>
<%@page import="com.foodApp.Dao.OrderDao"%>
<%@page import="com.foodApp.Dao.RestaurantDaoImplmpl"%>
<%@page import="com.foodApp.Dao.RestaurantDao"%>
<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dao.FoodItemDao"%>
<%@page import="com.foodApp.Dto.Restaurant"%>
<%@page import="com.foodApp.Dto.FoodItem"%>
<%@page import="com.foodApp.Dto.OrderItems"%>
<%@page import="com.foodApp.Dao.OrderItemDaoImpl"%>
<%@page import="com.foodApp.Dao.OrderItemDao"%>
<%@page import="com.foodApp.Dao.OrderDaoImpl"%>
<%@page import="com.foodApp.Dto.Orders"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setAttribute("menu", "Orders");
%>
<%@include file="/customer/CustomerSession.jsp"%>
<%
if (user == null) {
	RequestDispatcher requestDispatcher = request.getRequestDispatcher("/customer/Login.jsp");
	requestDispatcher.forward(request, response);
	return;
}
int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
int limit = request.getParameter("limit") != null ? Integer.parseInt(request.getParameter("limit")) : 10;
OrderDao orderDao = new OrderDaoImpl();
List<Orders> orders = orderDao.getAllOrders(user.getUserId(), currentPage, limit);
int totalData = orderDao.totalOrder(user.getUserId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Orders</title>
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

.order-section {
	max-width: 1700px;
	margin: 0 auto;
}

.no-order-wrapper {
	width: 100%;
	height: 80vh;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding: 20px;
}

.no-order-wrapper img {
	width: 250px;
	height: 250px;
	border-radius: 20px;
	box-shadow: 1px 2px 5px graytext !important;
}

.no-order-wrapper p {
	margin-top: 10px;
	font-size: 1.2rem;
	font-weight: 500;
	font-size: 1.2rem;
}

.order-items {
	max-width: 70%;
	margin: 0 auto;
	padding: 10px 5px;
}

.order-card {
	width: 100%;
	border-radius: 20px;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	justify-content: center;
	margin: 5px 0px;
	border: 1px solid #e0e1dd;
	padding: 10px 20px;
	position: relative;
}

.review-tag{
 font-size: 0.7rem;
 color: #2a9d8f;
}


.details-wrapper {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	gap: 10px;
	width: 100%;
}

.details-wrapper img {
	width: 150px;
	height: 150px;
	border-radius: 5px;
}

.details-wrapper h5 {
	margin-bottom: 0;
}

.details-wrapper .details {
	margin-left: 10px;
}

.details .order-title {
	font-size: 1.1rem;
	font-weight: 500;
}

.details .order-desc {
	font-size: 0.8rem;
	color: #393d3f;
	font-weight: 300;
}

.restaurant-title {
	font-size: 0.89rem;
	font-weight: 400;
	color: #4e148c;
}

.price {
	font-size: 0.85rem;
	color: #e83f6f;
}
.status {
 width: fit-content;
 padding: 2px 5px;
 margin:4px 0px;
 border-radius: 8px;
 font-size: 0.98rem;
 font-weight: 400;
 color: #3a0ca3;
 background: white;
 border: 1px solid #3a0ca3;
}

.order-card-footer {
	width: 100%;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 10px;
}

.cancel-btn, .review-btn {
	padding: 4px 8px;
	border-radius: 10px;
	font-size: 0.9rem;
	border: none;
}

.cancel-btn {
	background: #f25f5c;
	color: white;
}

.review-btn {
	background: #1d2d44;
	color: white;
}

.section-title{
 display: flex;
 justify-content: space-between;
 align-items: center;
 font-size: 1.5rem;
 margin-top: 10px; 
}

a{
 text-decoration: none;
}



@media ( max-width :500px) {
	.no-order-wrapper img {
		width: 150px;
		height: 150px;
	}
	.no-order-wrapper p {
		font-size: 0.9rem;
		text-align: center;
	}
	.order-items {
		max-width: 100%;
	}
	.details-wrapper img {
		width: 100px;
		height: 100px;
		border-radius: 5px;
	}
	.section-title{
	 font-size: 0.99rem;
	}
	
}

@media ( max-width :300px) {
	
	.details-wrapper img {
		width: 70px;
		height: 70px;
		border-radius: 5px;
	}
}
</style>
</head>
<body>
	<%@include file="/customer/Navbar.jsp"%>

	<section class="order-section">
		<%
		if (orders.size() > 0) {
			OrderItemDao orderItemDao = new OrderItemDaoImpl();
			FoodItemDao foodItemDao = new FoodItemDaoImpl();
			RestaurantDao restaurantDao = new RestaurantDaoImplmpl();
		%>
		<article class="order-items">
			<h1 class="section-title"><span>Your Orders</span><span>Total Orders : <%=totalData %></span></h1>
			<%
			for (Orders order : orders) {
				OrderItems orderItem = orderItemDao.getByOrderId(order.getOrderId());
				FoodItem foodItem = null;
				Restaurant restaurant = null;
				if (orderItem != null) {
					foodItem = foodItemDao.getOne(orderItem.getFoodId());
					restaurant = restaurantDao.getOne(order.getRetaurantId());
				}

				if (order != null && foodItem != null && restaurant != null) {
					
					List<Review> reviews = new ReviewDaoImpl().getReview(foodItem.getFoodId(), user.getUserId());
			%>

			<div class="order-card">
                   
                  

				<div class="details-wrapper">
					<img alt="<%=foodItem.getName()%>" src="<%=foodItem.getImg()%>">
					<div class="details">
						<h5 class="order-title"><%=foodItem.getName()%></h5>
						<h5 class="order-desc"><%=foodItem.getDescription().length() < 50 ? foodItem.getDescription()
		: foodItem.getDescription().substring(0, 50) + "..."%></h5>
						<h5 class="restaurant-title">
							Restaurant :<%=restaurant.getName()%></h5>
						<h5 class="status">Status : <%=order.getOrderStatus() %></h5>	
						<p class="price mb-0"><%=orderItem.getQuantity()%>
							*
							<%=foodItem.getPrice()%>
							= <i class="fa-solid fa-indian-rupee-sign"></i>
							<%=orderItem.getQuantity() * foodItem.getPrice()%></p>
							<%
                     if(reviews.size()>0)
                     {
                    	 %>
                    	  <p class="review-tag"><%=reviews.size() %> review by you</p>
                    	 <% 
                     }
                   %>
					</div>
					
					
				</div>
				<div class="order-card-footer">
					<button class="cancel-btn">Cancel Order</button>
					<button class="review-btn" onclick="handleReviewBtnClick('<%=request.getContextPath()+"/customer/OrderReview.jsp?foodId="+foodItem.getFoodId()%>')">Review</button>
				</div>
			</div>

			<%
			}
			}
			%>

		</article>


		<%
		} else {
		%>
		<div class="no-order-wrapper">
			<img alt="empty"
				src="<%=request.getContextPath() + "/images/empty.webp"%>">
			<p>No delicious meals found on your table yet! Start exploring
				our menu and place your first order today.</p>

		</div>

		<%
		}
		%>
		
		
		<%
		int noOfPages = (int) Math.ceil((double) totalData / limit);
		int startPage = Math.max(1, currentPage - 2);
		int endPage = Math.min(noOfPages, currentPage + 2);
		%>

		<div class="pagination center mt-2">

			<%
			if (currentPage > 1) {
			%>
			<a class="pagination-btn center" href="<%= request.getContextPath()+"/customer/UserOrders.jsp?page="+(currentPage-1)+"&limit="+limit%>">Prev</a>
			<%
			}
			%>
			<%
			for (int i = startPage; i < endPage; i++) {
			%>
			<a class="pagination-btn center <%=currentPage == i ? "active" : ""%>"><%=i%></a>
			<%
			}
			%>
			<%
			if (currentPage < noOfPages) {
			%>
			<a class="pagination-btn center" href="<%= request.getContextPath()+"/customer/UserOrders.jsp?page="+(currentPage+1)+"&limit="+limit%>">Next</a>
			<%
			}
			%>
		</div>

	</section>
	
	<script type="text/javascript" src="<%= request.getContextPath()+"/customer/js/UserOrderJs.js"%>"></script>
</body>
</html>