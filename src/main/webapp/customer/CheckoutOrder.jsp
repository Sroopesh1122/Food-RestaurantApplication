<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dao.FoodItemDao"%>
<%@page import="com.foodApp.Dto.FoodItem"%>
<%@page import="com.foodApp.Dao.UserCartDaoImpl"%>
<%@page import="com.foodApp.Dao.UserCartDao"%>
<%@page import="com.foodApp.Dto.UserCart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setAttribute("menu", "");
%>
<%@include file="/customer/CustomerSession.jsp"%>
<%
 if(user ==null)
 {
	 RequestDispatcher requestDispatcher = request.getRequestDispatcher("/customer/Login.jsp");
	 requestDispatcher.forward(request, response);
	 return;
 }
  UserCartDao userCartDao = new UserCartDaoImpl();
  List<UserCart> cartItems = userCartDao.getCartItems(user.getUserId());
  FoodItemDao foodItemDao= new FoodItemDaoImpl();
%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout Order</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath() + "/Pagination.css"%>">
<%@include file="/CommonUtils.jsp"%>
<style type="text/css">

body{
 font-family: "outfit",sans-serif;
}

.checkout-section{
 max-width: 1700px;
 margin: 0 auto;
 min-height: 80vh;
 display: flex;
 justify-content: center;
 align-items: center;
}

.order_items{
width: 500px;
padding: 15px;
box-shadow: 1px 2px 4px #ededed !important;
border-radius: 10px;

}

.order_items h1{
 font-size: 1.2rem;
}

.order-card{
 display: flex;
 justify-content: space-between;
 align-items: center;
 padding: 5px;
 border-radius: 15px;
 border-bottom:1px solid #ededed; 
 margin: 5px 0px;
}

.order-img{
 width: 50px;
 height: 50px;
 border-radius: 10px;
}

.order-details h3{
 display: flex;
 justify-content: flex-start;
 align-items: center;
 font-size: 0.9rem;
}

.item-wrapper{
 display: flex;
 flex-direction: column;
 justify-content: center;
 align-items: center;
}

.result-footer{
 display: flex;
 flex-direction: column;
 justify-content: flex-end;
 align-items: flex-end;
 
}
.result-footer h6{
font-size: 0.8rem;
}
.btn-wrapper{
width: 100%;
display: flex;
justify-content: center;
align-items: center;
margin-top: 5px;
}

#pay-btn{
 width: 80%;
 margin: 0px auto !important;
 border-radius: 10px;
 border: none;
 padding: 3px 0px;
 background: #f05d5e;
 color: white;
}

.fa-indian-rupee-sign{
 font-size: 0.8rem;
}

@media ( max-width :500px) {
  .order_items{
   width: 280px;
  }
}
</style>

</head>
<body>
<%@include file="/customer/Navbar.jsp"%>

<section class="checkout-section">
 
  <div class="order_items">
    <h1>Order Items</h1>
     <form action="<%=request.getContextPath()+"/user/checkout" %>" method="post">
         <input type="hidden" name="address" value="<%= request.getParameter("address")%>">
         <%
         int totalQuantity = 0;
         double totalPrice = 0;
         for(UserCart uc :cartItems)
         {
        	 FoodItem foodItem =  foodItemDao.getOne(uc.getFoodId());
        	 %>
        	    <div class="order-card">
        	       <input type="hidden" name="<%=uc.getFoodId() %>" value="<%= request.getParameter(uc.getFoodId()+"")%>">
        	   
        	       <div class="item-wrapper">
        	          <img alt="<%= foodItem.getName()%>" src="<%= foodItem.getImg()%>" class="order-img">
        	          <h6 class="order-title"><%=foodItem.getName() %></h6>
        	       </div>
        	       <div class="order-details">
        	        <%
        	         int quantity = Integer.parseInt(request.getParameter(uc.getFoodId()+"")!=null ? request.getParameter(uc.getFoodId()+"") : "1" );
        	         totalQuantity+=quantity;
        	         totalPrice+= (quantity * foodItem.getPrice());
        	        
        	        %>
        	           <h3> <span><%=quantity %> </span> * <span> <%=foodItem.getPrice() %> = </span> <%= quantity* foodItem.getPrice() %> </h3>
        	       </div>
        	    </div>
        	 <%
         }
         
         %>
         
         <div class="result-footer">
          <input type="hidden" name="totalAmount" value="<%=totalPrice%>">
          <h6><span>Total Quantity : </span> <span><%=totalQuantity %></span> </h6>
          <h6><span>Total Amount : </span> <span><%=totalPrice %></span> </h6>
            
            
          
         </div>
         
         <div class="btn-wrapper">
             <button id="pay-btn" type="submit">Pay <i class="fa-solid fa-indian-rupee-sign"></i> <%=totalPrice %></button>
         </div>
     
     </form>       
  
  </div>


</section>


</body>
</html>