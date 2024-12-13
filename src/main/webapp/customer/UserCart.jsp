<%@page import="com.foodApp.Dto.Restaurant"%>
<%@page import="com.foodApp.Dao.RestaurantDaoImplmpl"%>
<%@page import="com.foodApp.Dao.RestaurantDao"%>
<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dao.FoodItemDao"%>
<%@page import="com.foodApp.Dto.FoodItem"%>
<%@page import="java.util.List"%>
<%@page import="com.foodApp.Dao.UserCartDaoImpl"%>
<%@page import="com.foodApp.Dao.UserCartDao"%>
<%@page import="com.foodApp.Dto.UserCart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("menu", "Cart");
%>
<%@include file="/customer/CustomerSession.jsp"%>
<%
if (user == null) {
	response.sendRedirect(request.getContextPath() + "/customer/Login.jsp");
	return;
}

int currentPage = request.getAttribute("page") != null ? Integer.parseInt(request.getAttribute("page").toString()) : 1;
int limit = request.getAttribute("limit") != null ? Integer.parseInt(request.getAttribute("limit").toString()) : 1000;

UserCartDao userCartDao = new UserCartDaoImpl();
List<UserCart> usercartItems = userCartDao.getCartItems(user.getUserId(), currentPage, limit);
int totalCartItems = userCartDao.getTotalItem(user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="<%=request.getContextPath() + "/Pagination.css"%>">
<%@include file="/CommonUtils.jsp"%>

<style type="text/css">
#cart-section {
	background: white;
	min-height: 90vh;
	padding: 50px;
	width: 100%;
	max-width: 1800px;
	margin: 0 auto;
	display: flex;
	justify-content: center;
	align-content: flex-start;
	gap: 20px;
	font-family: "outfit", sans-serif;
}

#cart-items-wrapper {
	width: 70%;
	height: 50vh;
}

#cart-items-info-wrapper {
	width: 30%;
	height: fit-content;
}

.cart-items-container {
	padding: 10px 20px;
}

.cart-item {
	width: 100%;
	padding: 10px;
	border: 1px solid #d6d6d6;
	border-radius: 10px;
	margin-bottom: 5px;
	position: relative;
	box-shadow: 0px 2px 3px #d6d6d6 !important;
}

.cart-item .cart-info {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 5px;
}

.cart-info .cart-details {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	gap: 5px;
}

.cart-item .cart-info h3 {
	font-size: 1.2rem;
	max-width: 100px;
	overflow: hidden;
	margin: 0;
}

.cart-item .cart-info h6 {
	font-size: 0.9rem;
	color: #bfc0c0;
}

#cart-items-wrapper h1 {
	font-size: 1.5rem;
	color: #e63946;
}

#cart-items-wrapper h5 {
	font-size: 0.9rem;
}

.cart-item .cart-info .price-tag {
	background: #e63946;
	color: white;
	font-size: 0.8rem;
	padding: 2px 4px;
	border-radius: 6px;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 2px;
}

.cart-info img {
	width: 100px;
	height: 100px;
	border-radius: 10px;
}

.cart-item-footer i {
	cursor: pointer;
}

.quantity {
	width: 40px;
	text-align: center;
	border-radius: 8px;
	border: 1px solid gray;
}

.delete-btn {
	position: absolute;
	top: 5px;
	right: 5px;
	cursor: pointer;
	color: #001219;
	font-size: 0.9rem;
}

.delete-btn:hover {
	color: red;
}

#empty-cart {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

#empty-cart img {
	width: 400px;
	height: 400px;
}

#empty-cart h1 {
	font-size: 1.4rem;
}

#empty-cart a {
	color: #f05d5e;
	cursor: pointer;
	text-decoration: none;
}

#cart-items-info-wrapper {
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0px 3px 5px #d6d6d6 !important;
	border: 1pd solid gray;
}

#cart-items-info-wrapper h1 {
	font-size: 1.2rem;
	background: #f05d5e;
	color:white;
	padding: 8px 10px;
	border-radius: 10px;
}

#cart-items-info-wrapper h5 {
	font-size: 0.95rem;
	font-weight: 500; display : flex;
	justify-content: flex-start;
	align-items: center;
	display: flex;
}

#cart-items-info-wrapper .footer {
	display: flex;
	width: 100%;
	padding: 5px 10px;
	justify-content: center;
	align-items: center;
}

#cart-items-info-wrapper .footer button {
	width: 90%;
	border: 1px solid #ededed;
	border-radius: 8px;
	background: #001219;
	color: white;
	padding: 5px 0px;
}

#totalQuantity {
	margin-left: 3px;
}

#totalAmount {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 3px;
	margin-left: 5px;
}

.hide{
  display: none !important;
}


@media ( max-width :425px) {
	#cart-section {
		padding: 5px;
		flex-direction: column-reverse;
		justify-content: flex-end;
	}
	#cart-items-wrapper {
		width: 90%;
		margin: 0 auto;
	}
	.cart-items-container {
		padding: 2px 4px;
	}
	#empty-cart img {
		width: 250px;
		height: 250px;
	}
	#empty-cart h1 {
		font-size: 0.9rem;
		text-align: center;
	}
	#cart-items-info-wrapper {
		width: 100%;
	}
	.cart-info img {
		width: 70px;
		height: 70px;
		border-radius: 10px;
	}
	#cart-items-info-wrapper h1{
	 font-size: 1rem;
	}
	.cart-item .cart-info .price-tag {
	 font-size: 0.7rem !important;
	 padding: 2px 2px !important;
	}
	.quantity {
	 width: 30px;
	}
	.fa-plus ,.fa-minus{
	 font-size: 0.8rem;
	 
	}
	.delete-btn{
	 color: red;
	}
}

@media ( max-width :350px) {
	#cart-section {
		padding: 2px;
		flex-direction: column-reverse;
		justify-content: flex-end;
	}
	#cart-items-wrapper {
		width: 98%;
		margin: 0 auto;
	}
}
</style>

</head>
<body>
	<%@include file="/customer/Navbar.jsp"%>

	<section id="cart-section">

		<%
		if (totalCartItems > 0) {
		%>
		<div id="cart-items-wrapper">
			<h1>Food Items</h1>
			<h5>
				Total Items
				<%=totalCartItems%></h5>
			<form class="w-full cart-items-container">

				<%
				FoodItemDao foodItemDao = new FoodItemDaoImpl();
				RestaurantDao restaurantDao = new RestaurantDaoImplmpl();
				for (UserCart usercart : usercartItems) {
					FoodItem foodItem = foodItemDao.getOne(usercart.getFoodId());
					Restaurant restaurant = foodItem != null ? restaurantDao.getOne(foodItem.getRestaurantId()) : null;

					if (foodItem != null && restaurant != null) {
				%>
				<div class="cart-item">
					<a class="delete-btn"
						href="<%=request.getContextPath() + "/user/cart/delete?cartId=" + usercart.getCartid()%>"><i
						class="fa-solid fa-trash"></i></a>
					<div class="cart-info">
						<div class="cart-details">
							<img alt="" src="<%=foodItem.getImg()%>">
							<div>
								<h3><%=foodItem.getName()%></h3>
								<h6><%=restaurant.getName()%></h6>
								<h5 class="price-tag">
									<i class="fa-solid fa-indian-rupee-sign"></i><span><%=foodItem.getPrice()%></span>
								</h5>
							</div>
						</div>

						<div class="cart-item-footer">
							<i class="fa-solid fa-plus"
								onclick="handleQuantityIncrease('<%=foodItem.getFoodId()%>')"></i>
							<input class="quantity" data-price="<%=foodItem.getPrice()%>"
								id="<%=foodItem.getFoodId()%>" name="<%=foodItem.getFoodId()%>"
								value=1 type="text"> <i class="fa-solid fa-minus"
								onclick="handleQuantityDecrease('<%=foodItem.getFoodId()%>')"></i>
						</div>
					</div>

				</div>
				<%
				}

				}
				%>
			</form>

		</div>

		<div id="cart-items-info-wrapper">

			<h1>Checkout Orders</h1>

			<div class="p-4">
				<h5>
					Total Quantity : <span id="totalQuantity"></span>
				</h5>
				<h5>
					Total Amount : <span id="totalAmount"></span>
				</h5>
				
				<hr/>
				
				<div>
				 
				 <h1>Delivering To :</h1>
				 
				  <div id="delivery-address">
				    
				     <p id="delivery-address-tag" ><%=user.getAddress()!=null ? user.getAddress() : "Enter Address" %></p>
				        	  
				     <button id="address-change-btn">Change</button>
				   </div>
				   
				
					  <div id="add-address-form" class="hide">
					     <h6>Add Address</h6>
				         <input type="text" id="new-deleivery-address">
				         <button id="saved-address-btn">Save Address</button>
					 </div>				
				</div>
				
			</div>

			<div class="footer">
				<button>Check Out</button>
			</div>

		</div>

		<%
		} else {
		%>

		<div id="empty-cart">

			<img alt=""
				src="https://img.clipart-library.com/2/clip-sad-cartoon-puppy/clip-sad-cartoon-puppy-13.jpg">
			<h1>Your cart is currently empty. Let's add some delicious
				items!</h1>
			<a
				href="<%=request.getContextPath() + "/customer/AllFoodItems.jsp"%>">Browser
				Here</a>
		</div>

		<%
		}
		%>


	</section>

	<script type="text/javascript"
		src="<%=request.getContextPath() + "/customer/js/Cart.js"%>"></script>
</body>
</html>