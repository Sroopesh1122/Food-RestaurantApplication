<%@page import="com.foodApp.Dto.FoodItem"%>
<%@page import="com.foodApp.Dao.FoodItemDaoImpl"%>
<%@page import="com.foodApp.Dao.FoodItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("menu", "");
%>
<%
int foodId = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : -1;
if (foodId == -1) {
	request.getRequestDispatcher("/restaurant/AllFoodItems.jsp").forward(request, response);
	return;
}

FoodItemDao foodItemDao = new FoodItemDaoImpl();
FoodItem foodItem = foodItemDao.getOne(foodId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=foodItem != null ? foodItem.getName() : "Not Found"%></title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="/CommonUtils.jsp"%>

<style type="text/css">
body {
	font-family: "outfit", sans-serif;
	max-width: 1800px;
	margin: 0 auto;
}

section {
	padding: 30px;
}

.not-found {
	height: 200px;
}

.header {
	position: relative;
}

#back-btn {
	gap: 2px;
	padding: 3px 8px;
	border-radius: 7px;
	background: #e63946;
	color: white;
	position: absolute;
	top: 5%;
	left: 5%;
	cursor: pointer;
}

.wrapper {
	gap: 10px;
	margin-top: 10px;
	display: flex;
	justify-content: center;
	align-items: flex-start;
}

.wrapper form {
	width: 350px;
	padding: 10px;
}

.wrapper .img-container {
	width: 400px;
	height: 300px;
}

.wrapper .img-container img {
	width: 100%;
	height: 100%;
	border-radius: 10px;
}

.form-row {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: 10px 0;
	gap: 10px;
	border-bottom: 1px solid #f0f0f0;
}

.form-row:last-child {
	border-bottom: none;
}

.form-row span {
	font-size: 1rem;
	color: #333;
}

.form-row span.title {
	font-weight: 600;
	white-space: nowrap;
}

.hashTags {
	color: blue !important;
	font-size: 0.9rem !important;
}

#update-btn{
 width: 80%;
 display: flex;
 margin: 0 auto;
 justify-content: center;
 border: none;
 padding: 3px 0px;
 border-radius: 6px;
 background: #e63946;
 color: white;
}

.price-container{
 display: flex;
 flex-direction: column;
 justify-content: center;
 align-items: flex-start;
}

.price-error{
 font-size: 0.8rem !important;
 color: red !important;
}



@media ( max-width : 425px) {
	section {
		padding: 10px;
	}
	.wrapper{
	 display: flex;
	 flex-direction: column-reverse;
	 align-items: center;
	 justify-content: flex-start;
	}
	
	.wrapper form {
	width: 260px;
	padding: 5px;
}

.wrapper .img-container {
	width: 250px;
	height: 250px;
}
}
</style>

</head>
<body>
	<%@include file="/restaurant/Navbar.jsp"%>
	<section>

		<%
		if (foodItem == null) {
		%>

		<div class="not-found center">
			<h6>Not Found</h6>
		</div>

		<%
		return;
		}
		%>

		<div class="header center">
			<span id="back-btn" onclick="goBack()" class="center"><i
				class="fa-solid fa-circle-chevron-left"></i>Back</span>
			<h3><%=foodItem.getName()%></h3>
		</div>

		<div class="wrapper">

			<form action="<%=request.getContextPath()+"/food/update" %>" id="update-form" method="post">
				<h3 class="text-center">Details</h3>

				<div class="form-row">
					<span class="title">Food Id:</span> <span><%=foodItem.getFoodId()%></span>
					<input type="hidden" name="foodId" value="<%= foodItem.getFoodId()%>">
				</div>

				<div class="form-row">
					<span class="title">Description:</span> <span><%=foodItem.getDescription()%></span>
				</div>

				<div class="form-row">
					<span class="title">Price:</span> <span></span>
					<div class="price-container">
					   <input class="ps-1 form-control" type="number" name="price" id="price" value="<%=foodItem.getPrice()%>">
					   <span class="error price-error" ></span>
					</div>
				</div>
				
				<div class="form-row">
					<span class="title">Available:</span> 
					<span> 
					<select class="form-control" id="available" name="availability">
					   <option value="not-available" <%= foodItem.getAvailability() == 0 ? "selected='selected'":"" %>" >Not Available</option>
					   <option value="available" <%= foodItem.getAvailability() == 1 ? "selected='selected'":"" %>" >Available</option>
					</select>
					 </span>
				</div>

				<div class="form-row">
					<span class="title">Category / Tags:</span>
					<div >
						<%
						String[] categories = foodItem.getCategory().split(",");
						for (int i = 0; i < categories.length; i++) {
						%>
						<span class="hashTags"><%= "#"+categories[i] + (i == categories.length - 1 ? " " : ",")%></span>
						<%
						}
						%>
					</div>
				</div>
				
				<div class="form-row">
				 <button type="button" id="update-btn">Update</button>
				</div>

			</form>

			<div class="img-container">
				<img alt="" src="<%=foodItem.getImg()%>">
			</div>
		</div>

	</section>

	<script type="text/javascript">
		function goBack() {
			window.history.back();
		}
	</script>
	
	<script type="text/javascript" src="<%= request.getContextPath()+"/restaurant/js/FoodItem.js"%>"></script>
<script type="text/javascript">
<%
String success = (String) request.getAttribute("success");
 if( success !=null)
 {
	 %>
	 
 	showNotification("Success","success","<%=success %>")
 	<%
 }
%>
<%
String error = (String) request.getAttribute("error");
 if( error !=null)
 {
	 %>
	 
 	showNotification("Error","error","<%=error %>")
 	<%
 }
%>

</script>
   

</body>
</html>