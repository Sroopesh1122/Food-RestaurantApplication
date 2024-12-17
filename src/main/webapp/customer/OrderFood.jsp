<%@page import="com.foodApp.Dao.RestaurantDaoImplmpl"%>
<%@page import="com.foodApp.Dto.Restaurant"%>
<%@page import="com.foodApp.Dto.FoodItem"%>
<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dao.FoodItemDao"%>
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
FoodItemDao foodItemDao = new FoodItemDaoImpl();
FoodItem foodItem = foodItemDao.getOne(foodId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=foodItem != null ? foodItem.getName() : "Food Item"%></title>
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

.order-wrapper{
  max-width: 1700px;
  margin: 0 auto;
  padding: 20px;
}
.not-found{
 width: 90%;
 margin: 0 auto;
 display: flex;
 justify-content: center;
 align-items: center;
}

.order-wrapper{
 width: 100%;
 min-height: 80vh;
 display: flex;
 justify-content: center;
 align-items:center;
}

.item-wrapper{
  display: flex;
  justify-content: center;
  align-items: flex-start;
  gap:10px;
  padding: 10px;
  border-radius: 20px;
  box-shadow: 2px 2px 5px #ededed !important;
}

.item-wrapper img{
 width: 200px;
 height: 200px; 
}
.details h4{
 margin-bottom: 0;
}
.food-title {
 font-size: 1.2rem;
 color: #003049;
}
.food-desc{
 font-size: 0.8rem;
}
.food-price{
 font-size: 1.02rem;
 color: #d90429;
}

.restaurant-details{
 padding: 5px;
 border-radius: 10px;
 border: 1px solid #ededed;
 margin: 10px 0px;
 box-shadow: 1px 1px 4px gray !important; 
}
.restaurant-details h4{
 font-size: 0.98rem;
 margin-bottom: 5px;
}

.restaurant-details h6{
 font-size: 0.81rem;
 margin-bottom: 0px;
 font-weight: 300;
}

.details-2 span{
 font-size: 0.95rem;
 margin-right: 5px;
}
.details-2 i{
cursor: pointer; 
}
.details-2 .quantity{
 width: 30px;
 text-align: center;
 border-radius: 8px;
 border: 1px solid #ededed;
 font-size: 0.8rem;
}

.footer{
 width: 100%;
 display: flex;
 justify-content: center;
 align-items: center;
 margin-top: 10px;
}

#order-btn{
 width: 80%;
 height: 30px;
 border-radius: 10px;
 border: none;
 background: #14213d;
 color: white;
}
#address{
 border :1px solid #ededed;
 padding: 1px 3px;
 border-radius: 8px;
}

.details-3 {
 font-size: 0.9rem;
}


@media (max-width:500px) {
	.item-wrapper{
	 flex-direction: column;
	}
}
</style>

</head>
<body>
	<%@include file="/customer/Navbar.jsp"%>
   <section class="order-wrapper">
     <%
       if(foodItem ==null)
       {
    	   %>
    	    <div class="not-found">
    	        <p>Page Not Found</p>
    	    </div>
    	   <%
       }else{
    	   Restaurant restaurant = new RestaurantDaoImplmpl().getOne(foodItem.getRestaurantId());
    	   %>
    	      
    	      <form class="item-wrapper" id="order-form" method="post" action="<%=request.getContextPath()+"/user/food/order"%>">
    	           <input type="hidden" name="foodId" value="<%=foodItem.getFoodId()%>">
    	           <img alt="" src="<%= foodItem.getImg()%>">
    	           <div class="details">
                      <h4 class="food-title"><%=foodItem.getName() %></h4>
                      <p class="food-desc"><%=foodItem.getDescription() %></p>
                      <h4 class="food-price"><i class="fa-solid fa-indian-rupee-sign"></i> <%=foodItem.getPrice() %></h4>
                      
                      <div class="restaurant-details">
                        <h4>Restaurant Details</h4>
                        <h6>Name: <%=restaurant.getName() %></h6>
                        <h6>Email : <%=restaurant.getEmail() %></h6>    
                      </div>
                      <%
                        double rating = foodItem.getRating();
                       if(rating >1)
                       {
                    	   %>
                    	   <h3><i class="fa-solid fa-star"> </i> <%=foodItem.getRating() %> </h3>
                    	   <%
                       }
                      %>
                      
                      <div class="details-2">
                           <span>Quantity : </span>
                           <i class="fa-solid fa-minus"
								onclick="handleQuantityDecrease('<%=foodItem.getFoodId()%>')"></i>
							
							<input class="quantity" data-price="<%=foodItem.getPrice()%>"
								id="<%=foodItem.getFoodId()%>" name="quantity"
								value=1 type="text"> 
								<i class="fa-solid fa-plus"
								onclick="handleQuantityIncrease('<%=foodItem.getFoodId()%>')"></i>
						</div>
						<p id="quantity-error hidden error">Please enter valid quantity</p>
						
						 <div class="details-3 mt-1">
                           <span>Address : </span>
							<input name="address" id="address" name="address" value="<%= user.getAddress()!=null ? user.getAddress() : "Enter Delivery Address"%>">
						</div>
						<p class="error hidden" id="address-error">Please enter Address</p>
						
						<div class="footer">
						   <button type="button" id="order-btn" onclick="handleSubmit()">Place Order</button>
						</div>    	           
    	           </div>
    	      </form>
    	      
    	   
    	   <%
       }
     
     %>
   
   </section>
   
   <script type="text/javascript" src="<%= request.getContextPath()+"/customer/js/OrderFoodJs.js"%>"></script>
</body>
</html>