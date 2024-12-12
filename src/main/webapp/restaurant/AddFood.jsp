<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("menu", "");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Your Food</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="/CommonUtils.jsp"%>
<style type="text/css">
.custom-section {
	width: 100%;
	padding: 30px 0px;
	position: relative;
	font-family: "outfit",sans-serif;
}

.back-btn {
	position: absolute;
	top: 10px;
	left: 10px;
	text-decoration: none;
	padding: 4px 8px;
	background: #e63946;
	color: white;
	border-radius: 10px;
	cursor: pointer;
}

.back-btn:hover {
	color: white;
}

.custom-section .title {
	font-size: 1.3rem;
}

.wrapper{
 display: flex;
 justify-content: center;
 align-items: flex-start;
 max-width: 1000px;
 margin: 0 auto;
 gap:10px;
}
.wrapper .img-wrapper{
  width: 400px;
  height: 400px;
}
.wrapper .img-wrapper button
{
  border: none;
  background: #e63946;
  color: white;
  border-radius: 8px;
  margin:5px auto;
  padding: 5px 9px;
}
.img-container{
 width: 80%;
 height: 80%;
 margin: 0 auto;
 border:1px solid #ededed;
 border-radius: 10px;
 position: relative;
}
.img-container span{
 position: absolute;
 top: 10%;
 font-size: 0.8rem;
 left: 50%;
 transform:translateX(-50%);
}
.img-container img{
 width: 100%;
 height: 100%;
 border-radius: 10px;
}
.hidden{
 display: none;
}
.wrapper .form-wrapper{
 width: 300px;
 
}
.form-wrapper form {
 width: 100%;
}
form h5{
 font-size: 1rem;
}
#desc{
 resize: none;
}

/* Apply to specific element (e.g., textarea) */
textarea::-webkit-scrollbar {
  width: 10px; /* Width of the vertical scrollbar */
  height: 10px; /* Height of the horizontal scrollbar */
}

/* Track */
textarea::-webkit-scrollbar-track {
  background: #f0f0f0; 
  border-radius: 10px; 
}

/* Thumb */
textarea::-webkit-scrollbar-thumb {
  background: #888; 
  border-radius: 10px; 
  border: 2px solid #f0f0f0;
  cursor: pointer;
}

textarea::-webkit-scrollbar-thumb:hover {
  background: #555; 
}

/* Apply globally (for all scrollbars) */
::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: #f0f0f0;
}

::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
  background: #555;
}
#submit-btn{
 padding: 4px 9px;
 border: none;
 background: #e63946;
 color: white;
 border-radius: 8px;
 margin-top: 7px;
}

@media (max-width:786px) {

.wrapper{
 flex-direction: column;
 display: flex;
 justify-content: flex-start;
 align-items: center;
}

	
}

</style>
</head>
<body>
	<%@include file="/restaurant/Navbar.jsp"%>

	<section class="custom-section">

		<a class="back-btn" onclick="goBack()"><i
			class="fa-solid fa-circle-chevron-left"></i> Back</a>
		<h1 class="text-center title">Add Your New Food</h1>
		
		
		<div class="wrapper mt-4">
		
		 <div class="img-wrapper">
		      
		      <div class="img-container">
		        <span id="upload-indicator" >Select food Image</span>
		        <img alt="" src="" id="img-preview">
		      </div>
		      <div class="center">
		       <button id="upload-btn">Upload Food Photo</button>
		       <button id="upload-remove" class="hidden">Remove</button>
		      </div>
		 </div>
		 
		 <div class="form-wrapper">
		      
		      <form action="<%= request.getContextPath()+"/food/add"%>" method="post" enctype="multipart/form-data" id="addfoodForm">
		        
		        <h5 class="text-center">Please Fill below detils</h5>
		        
		        <input type="file" class="hidden" id="img-file" name="image" accept="image/*">

		        <div class="form-group mb-1">
				  <label for="name">Food name</label>
				   <input type="text" class="form-control" id="name" name="name">
				  <div class="error hidden">Please enter valid name</div>
			   </div>
			   
			   <div class="form-group mb-1">
				  <label for="desc">Description</label>
				   <textarea rows="5" cols="10"  class="form-control" id="desc" name="description" ></textarea>
				  <div class="error hidden">Please enter valid name</div>
			   </div>
			   
			   <div class="form-group mb-1">
				  <label for="price">Price(INR)</label>
				   <input type="number" class="form-control" id="price" name="price">
				  <div class="error hidden">Please enter valid price</div>
			   </div>
			   
			   <div class="form-group mb-1">
				  <label for="category">Food Category / Tags</label>
				   <input type="text" class="form-control" id="category" name="category">
				  <div class="error hidden">Please enter valid categories/tags</div>
			   </div>
			   
			  <div class="center">
			     <button type="button" id="submit-btn">Submit</button>
			  </div>
		      
		      </form>
		  
		 </div>
		</div>

	</section>	
	<script type="text/javascript" src="<%=request.getContextPath() + "/restaurant/js/AddFoodJs.js"%>"></script>
	
	<%
	if (request.getAttribute("errorMessage") != null) {
	   String errorMessage = (String) request.getAttribute("errorMessage");
	   request.removeAttribute("errorMessage");
	%>
	 <script>
          showNotification("Error", "error", "<%=errorMessage%>");
	</script>
	<%
	}
	%>
	
	<%
	if (request.getAttribute("successMessage") != null) {
	   String Message = (String) request.getAttribute("successMessage");
	   request.removeAttribute("successMessage");
	%>
	 <script>
          showNotification("Success", "success", "<%=Message%>");
	</script>
	<%
	}
	%>
	
	
	
	
</body>
</html>