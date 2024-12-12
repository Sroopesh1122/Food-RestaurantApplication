<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignUp</title>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/Icon.ico">
<%@include file="/CommonUtils.jsp"%>

<style type="text/css">
body {
	font-family: "Outfit", sans-serif;
}

.signup-section {
	min-height: 100vh;
}

#signupForm {
	width: 400px;
}

.error {
	display: none;
}

.signup-section form {
	padding: 40px 10px;
	box-shadow: 0px 0px 4px gray !important;
	border-radius: 20px;
	color: #0d1b2a;
}

.signup-section form  h4 {
	color: #e63946;
}

.signup-section form #register-btn {
	display: block;
	width: 70%;
	margin: 0 auto;
	background: #e63946;
	color: white;
}

.signup-section form label {
	font-size: 0.92rem;
}

.signup-section form #register-btn:hover {
	border: 1px solid #e63946;
	color: #e63946;
	background: transparent;
}

.signup-section form .divider {
	font-size: 0.6rem;
	width: 100%;
}

.signup-section form .divider div {
	display: flex;
	height: 1px;
	background: black;
	flex: 1;
	margin: 0px 4px;
}

.signup-footer {
	font-size: 0.8rem;
	margin-top: 20px;
}

.signup-footer a {
	text-decoration: none;
	color: #e63946;
}
</style>

</head>
<body>
	<section class="center signup-section">

		<form action="<%=request.getContextPath() + "/restaurant/register"%>"
			method="post" id="signupForm">
			<h4 class="text-center mb-3">Add Your Restaurant</h4>

			<div class="form-group mb-1">
				<label for="name">Name</label> <input type="text"
					class="form-control" id="name" name="name">
				<div class="error">Please enter restaurant name</div>
			</div>

			<div class="form-group mb-1">
				<label for="email">Email</label> <input type="text"
					class="form-control" id="email" name="email">
				<div class="error">Please enter valid email</div>
			</div>

			<div class="form-group mb-1">
				<label for="mobile">Mobile</label> <input type="text"
					class="form-control" id="mobile" name="mobile">
				<div class="error">Please enter valid phone no</div>
			</div>

			<div class="form-group mb-1">
				<label for="address">Address</label> <input type="text"
					class="form-control" id="address" name="address">
				<div class=" error">Please enter valid address</div>
			</div>

			<div class="form-group mb-1">
				<label for="password">Password</label> <input type="text"
					class="form-control" id="password" name="password">
				<div class=" error">Please enter password</div>
			</div>

			<div class="form-group mb-1">
				<label for="cpassword">Confirm Password</label> <input type="text"
					class="form-control" id="cpassword" name="cpassword">
				<div class=" error">Please enter confirm password</div>
			</div>

			<button type="button" class="btn mt-3 signin-btn" id="register-btn">
				Register <i class="fa-solid fa-spinner hidden animte-spin"
					id="register-loading"></i>
			</button>

			<div class="divider center mt-2">
				<div></div>
				<span>OR</span>
				<div></div>
			</div>
			<p class="text-center signup-footer">
				Already have an account ? <a
					href="<%=request.getContextPath() + "/restaurant/Login.jsp"%>">Login</a>
			</p>

		</form>
	</section>
	
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() + "/restaurant/js/SignUp.js"%>"></script>

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