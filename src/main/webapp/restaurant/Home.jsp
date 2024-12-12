<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setAttribute("menu", "Home"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant</title>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="/CommonUtils.jsp" %>

<style type="text/css">

.home-section{
  max-width: 70%;
  height: 600px;
  margin: 0 auto;
  position: relative;
  border-radius: 10px;
  overflow: hidden;
}
.home-section .overlay{
 position: absolute;
 top: 0;
 left: 0;
 width: 100%;
 height: 100%;
 background: rgba(0,0,0,0.5);
 display: flex;
 justify-content: center;
 align-items: center;
 flex-direction: column;
}
.home-section img{
 width: 100%;
 height: 100%;
}

.home-section .overlay h1{
 font-size: 3rem;
 font-weight: 700;
 color: white;

}
.home-section .overlay a {
  padding: 5px 10px;
  text-decoration:none;
  border-radius: 10px;
  border: none;
  background: #e63946;
  color: white;
}
 
@media ( max-width :768px) {
 .home-section{
  max-width: 100%;
  height: 200px;
  border-radius: 0;
 }	
 .home-section .overlay h1{
  font-size: 1rem;
 }
}
</style>

</head>
<body>
<%@include file="/restaurant/Navbar.jsp"%>
 
 <section class="home-section">
    
    <img alt="" src="<%=request.getContextPath()+"/images/img2.jpg"%>">
    
    <div class="overlay">
      <h1>Welcome Owner</h1>
      <a href="<%= request.getContextPath()+"/restaurant/AddFood.jsp"%>" >Add Your Food</a>
    </div>
    
 </section>

</body>
</html>