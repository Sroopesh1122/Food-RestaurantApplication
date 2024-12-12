<%@page import="com.foodApp.Dto.FoodItem"%>
<%@page import="java.util.List"%>
<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dao.FoodItemDao"%>
<%@page import="com.foodApp.Dto.Restaurant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("menu", "Food Menu");
%>
<%
Restaurant restaurant = (Restaurant) session.getAttribute("user");
if (restaurant == null) {
	response.sendRedirect(request.getContextPath() + "/restaurant/Login.jsp");
	return;
}

int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
int limit = request.getParameter("limit") != null ? Integer.parseInt(request.getParameter("limit")) : 10;
String searchText = request.getParameter("q"); 

FoodItemDao foodItemDao = new FoodItemDaoImpl();
List<FoodItem> foodItems = foodItemDao.getFoodItem(restaurant.getRestaurantId(),searchText,currentPage,limit);
int totalData = foodItemDao.totalFoodItem(restaurant.getRestaurantId(),searchText);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Food Menu</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath() + "/Pagination.css"%>">
<%@include file="/CommonUtils.jsp"%>
<style type="text/css">
body {
	font-family: "outfit", sans-serif;
	max-width: 1800px;
	margin: 0 auto;
}
a{
 text-decoration: none;
}

section {
	padding: 50px 20px 20px 20px;
	
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.header form {
	gap: 5px;
}

.header form  button {
	border: none;
	border-radius: 8px;
	padding: 4px 8px;
	background: #efefef;
	font-size: 0.9rem;
}

.header form input {
	padding: 2px 4px;
}

.custom-grid {
    margin-top:10px;
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 10px;
}

.food-card{
	background-color: #fdfffc;
	box-shadow: 0 4px 6px rgba(0, 0, 0,0.2) !important;
	padding: 5px;
	border-radius: 10px;
	cursor: pointer;
}
.food-card img{
 width: 100%;
 height: 200px;
 border-radius: 10px;
}

.food-card  h4{
 white-space: nowrap;
 overflow: hidden;
 text-overflow: ellipsis;
 font-size: 1.01rem;
 margin-top: 5px;
 color: black;
}

.food-card .desc {
  font-size: 0.8rem;
  color: #282828;
  font-weight: 400;
  display: -webkit-box;
  -webkit-line-clamp: 2; 
  -webkit-box-orient: vertical;
  overflow: hidden; 
  text-overflow: ellipsis; 
}

.food-card div{
 display: flex;
 justify-content: flex-end;
 align-items: center;
 padding-right: 10px;
}
.food-card .price-tag{
 font-size: 0.7rem;
 gap:2px;
 padding: 3px;
 border-radius: 5px;
 background: #e63946;
 color: white;
}

.not-found{
 height:300px;
 width: 100%; 
}

.search-input{
 width:300px;
 position: relative;
}

.search-input #suggestion{
 width: 100%;
 height: 200px;
 background: white;
 position: absolute;
 top: 110%;
 left: 0;
 display: none;
 border-radius: 10px;
 box-shadow: 0px 0px 5px gray !important; 
}
.suggestion-results span{
  display: block;
  padding: 2px 8px 2px 10px;
  border-top: 1px solid #efefef;
  margin-top: 2px;
  cursor: pointer;
}
.suggestion-results span:hover{
 background: #efefef;
}

.suggestion-active{
  background: #efefef;
}
.suggestion-results span:first-child{
 border: none;
 border-radius: 10px 10px 0px 0px;
}


.suggestion-not-found{
 
 display: flex !important;
 justify-content: center;
 align-items: center;

}






@media ( max-width :425px) {
	section {
		padding: 10px;
	}
	.header{
	 flex-direction: column;
	}
	.search-input{
	 width: 200px;
	}
}
</style>

</head>
<body>
	<%@include file="/restaurant/Navbar.jsp"%>
	<section>
		<h1 class="text-center">Your Food Menu</h1>

		<div class="header">
			<h6>
				Search results :
				<%=totalData%></h6>
			<form action="<%=request.getContextPath()+"/restaurant/AllFoodItems.jsp" %>" class="center" id="search-form">
				<div class="search-input">
				   <input class="form-control" id="search-input" placeholder="Search food here" name="q" autocomplete="off">
				   <div id="suggestion" class="">
				     
				   </div>
				</div>
				<button  >Search</button>
			</form>
		</div>

		<%
		  if(totalData >0 )
		  {
			  %>
			   <div class="custom-grid">
			<%
			 for(FoodItem foodItem :foodItems)
			 {
				 %>
			 	  <a class="food-card" href="<%= request.getContextPath()+"/restaurant/FoodItem.jsp?id="+foodItem.getFoodId() %>">
			       <img alt="<%=foodItem.getName() %>" src="<%=foodItem.getImg()%>">
			      <h4><%=foodItem.getName()%></h4>
			       <h6 class="desc"><%=foodItem.getDescription() %></h6>
			       <div>
			        <span class="center price-tag"><i class="fa-solid fa-indian-rupee-sign"></i> <%=foodItem.getPrice() %></span>
			        </div>
			       </a>
				 <%
			 }
			%>
		      </div>
			  
			  <%
		  }else{
			  %> 
			     <div class="not-found center">
			        
			         <h6>No matched food item</h6>
			      
			     </div>
			   
			  <%
		  }
		%>
		
		<%
		  int noOfPages = (int) Math.ceil((double) totalData / limit);
		  int startPage = Math.max(1, currentPage-2);
		  int endPage =  Math.min(noOfPages,currentPage+2);
		%>
		
		<div class="pagination center mt-2">
		 
		 <%
		   if(currentPage >1)
		   {
			   %> 
			    <a class="pagination-btn center">Prev</a>
			   <%
		   }
		 %>
		  <%
		   for(int i=startPage ;i<endPage;i++)
		   {
			   %>
			     <a class="pagination-btn center <%= currentPage == i ? "active":""%>"><%=i %></a>
			   <% 
		   }
		  %>
		 <%
		   if(currentPage <noOfPages)
		   {
			   %> 
			    <a class="pagination-btn center">Next</a>
			   <%
		   }
		 %>
		</div>
	</section>
	<script type="text/javascript" src="<%=request.getContextPath()+"/restaurant/js/AllFoodItemsJs.js"%>"></script>
</body>
</html>