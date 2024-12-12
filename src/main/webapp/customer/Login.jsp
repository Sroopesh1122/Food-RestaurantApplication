<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignIn</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<%@include file="/CommonUtils.jsp"%>

<style type="text/css">
body {
	font-family: "Outfit", sans-serif;
	
}
.signin-section {
	min-height: 100vh;
	}
 
#signinForm {
	width: 400px;
}

.error {
	display: none;
}

.signin-section form {
	padding: 40px 10px;
	box-shadow: 0px 0px 4px gray !important;
	border-radius: 20px;
	color: #0d1b2a;
}

.signin-section form  h4 {
	color: #e63946;
}

.signin-section form #login-btn {
	display: block;
	width: 70%;
	margin: 0 auto;
	background: #e63946;
	color: white;
}

.signin-section form label {
	font-size: 0.92rem;
}

.signin-section form #login-btn:hover {
	border: 1px solid #e63946;
	color: #e63946;
	background: transparent;
}

.signin-section form .divider {
	font-size: 0.6rem;
	width: 100%;
}

.signin-section form .divider div {
	display: flex;
	height: 1px;
	background: black;
	flex: 1;
	margin: 0px 4px;
}

.signin-footer {
	font-size: 0.8rem;
	margin-top: 20px;
}

.signin-footer a {
	text-decoration: none;
	color: #e63946;
}
</style>

</head>
<body>
	<section class="center signin-section">
		
		<form action="<%=request.getContextPath()+"/customer/login" %>" method="POST" id="signinForm">

			<h4 class="text-center mb-3">Login</h4>
			<div class="form-group mb-1">
				<label for="email">Email</label> <input type="text"
					class="form-control" id="email" name="email">
				<div class="error">Please enter valid email</div>
			</div>

			<div class="form-group mb-1">
				<label for="password">Password</label> <input type="text"
					class="form-control" id="password" name="password">
				<div class=" error">Please enter password</div>
			</div>

			<button type="button" class="btn mt-3 signin-btn" id="login-btn">Login</button>

			<div class="divider center mt-2">
				<div></div>
				<span>OR</span>
				<div></div>
			</div>
			<p class="text-center signin-footer">
				Don't have account ? <a href="<%=request.getContextPath() + "/customer/SignUp.jsp"%>">Register</a>
			</p>

		</form>
	</section>
	<script type="text/javascript"
		src="<%=request.getContextPath() + "/restaurant/js/Login.js"%>"></script>
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
</body>
</html>