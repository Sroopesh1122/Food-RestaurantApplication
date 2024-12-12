<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
request.setAttribute("menu", "");
%>
<%@include file="/customer/CustomerSession.jsp"%>
<%
if (user == null) {
	response.sendRedirect(request.getContextPath() + "/customer/Login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Make Payment</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="<%=request.getContextPath() + "/Pagination.css"%>">
<%@include file="/CommonUtils.jsp"%>
</head>
<body>
   <%@include file="/customer/Navbar.jsp"%>
   <section id="order-section">
   
     <div>
       <h5>Please provide delivery address</h5>
       <input type="text" name="address">
     </div>
   
   </section>
</body>
</html>