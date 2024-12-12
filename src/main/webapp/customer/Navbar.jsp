<%@page import="com.foodApp.Dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	 User customer = (User) session.getAttribute("user");
	
	%>
<style>

.nav-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 5px 20px;
	max-width: 1800px;
	background: #001219;
	color: white;
	font-family: "outfit", sans-serif;
	width: 100%;
	position: relative;
	margin: 0 auto;
}

.nav-bar .brand img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
}

.nav-bar .brand span {
	font-size: 1.2rem;
	font-weight: 600;
	margin-left: 4px;
}

.nav-bar .menu {
	gap: 10px;
}

.nav-bar .menu button {
	padding: 5px;
	border-radius: 8px;
	border: none;
	background: white;
}

.nav-bar .menu ul {
	margin-bottom: 0px;
	gap: 10px;
}

.nav-bar .menu ul a {
    color:white;
	padding: 2px 5px;
	border-radius: 8px;
	cursor: pointer;
	text-decoration: none;
}

.nav-bar .menu ul li {
	list-style: none;
}

.nav-bar .menu ul .active {
	background: #f05d5e;
	color: white;
}

.desktop-nav {
	display: flex;
}

.mobile-nav {
	width: 0vw;
	height: 100vh;
	position: absolute;
	top: 0;
	right: 0vw;
	background: #e63946;
	color: white;
	display: none;
}

.fa-bars {
	display: none;
}

#login-btn{
  cursor: pointer;
  color: white;
  text-decoration: none;
}

@media ( max-width :768px) {
	.desktop-nav {
		display: none;
	}
	.mobile-nav {
		display: block;
		overflow: hidden;
		transition: width 0.3s;
		padding: 20px 0px;
		z-index: 999;
	}
	.mobile-nav .menu-list {
		width: 100%;
		height: 100%;
		padding: 30px;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.mobile-nav .menu-list button {
		background: white;
		margin: 10px auto;
		padding: 4px 8px;
		width: 70%;
		border-radius: 10px;
		border: none;
		font-size: 0.96rem;
	}
	.mobile-nav .menu-list ul {
		padding: 0px;
		width: 90%;
		margin: 0 auto;
		display: flex;
		justify-content: center;
		flex-direction: column;
		align-items: center;
		gap:20px;
	}
	.mobile-nav .menu-list ul a{
		color: white;
		text-decoration: none;
		text-align: center;
		width: fit-content;
		padding: 5px 8px;
	}
	.mobile-nav .menu-list ul .active{
	 background: white;
	 border-radius: 9px;
	 color: #e63946;
	}
	.mobile-nav .menu-list ul a li {
		list-style: none;
	}
	.fa-arrow-right {
		cursor: pointer;
	}
	.fa-bars {
		display: block;
		cursor: pointer;
	}
	.open-mobile-nav {
		width: 50vw;
	}
}
</style>

<nav class="nav-bar">
	<div class="brand">
		<img alt="logo"
			src="<%=request.getContextPath() + "/images/Img1.webp"%>"> <span>FOS</span>
	</div>

	<div class="menu center desktop-nav">
		<ul class="center">
			<a href="<%=request.getContextPath() + "/customer/Home.jsp"%>" class="<%=request.getAttribute("menu").toString().equalsIgnoreCase("Home") ? "active" : ""%>" ><li >Home</li></a>
			<a href="<%=request.getContextPath() + "/customer/AllFoodItems.jsp"%>" class="<%=request.getAttribute("menu").toString().equalsIgnoreCase("Food Items") ? "active" : ""%>" ><li >Food Items</li></a>
			<%
			 if(customer!=null)
			 {
				 %>
				  <a class="<%=request.getAttribute("menu").toString().equalsIgnoreCase("Orders") ? "active" : ""%>"><li >Orders</li></a>
				  <a href="<%=request.getContextPath() + "/customer/UserCart.jsp"%>" class="<%=request.getAttribute("menu").toString().equalsIgnoreCase("Cart") ? "active" : ""%>"><li >Cart</li></a>
				 <% 
			 }
			%>
		</ul>

        <%
         if(customer==null)
         {
        	 %>
        	    <a id="login-btn" href="<%=request.getContextPath()+"/customer/Login.jsp"%>">Login</a>
        	 <%
         }else{
        	 %>
        	  <button type="button" class="custom-btn">Logout</button>
        	 <% 
         }
        
        %>
		
	</div>

	<i class="fa-solid fa-bars" id="menu-icon"></i>

	<div class="mobile-nav ">
		<span class="p-2"><i class="fa-solid fa-arrow-right"
			id="menu-close-icon"></i></span>
		<div class="menu-list">

			<ul>
				<a href="" class="<%=request.getAttribute("menu").toString().equalsIgnoreCase("Home") ? "active" : ""%>" ><li >Home</li></a>
				<a href="" class="<%=request.getAttribute("menu").toString().equalsIgnoreCase("Food Menu") ? "active" : ""%>" ><li >Food Items</li></a>
				<a href="" class="<%=request.getAttribute("menu").toString().equalsIgnoreCase("Orders") ? "active" : ""%>" ><li >Orders</li></a>
			</ul>
			<button type="button">Logout</button>
		</div>
	</div>
</nav>
<script type="text/javascript">
	let openMenu = false;

	$("#menu-icon").on('click', function() {
		$(".mobile-nav").addClass("open-mobile-nav")

	})

	$("#menu-close-icon").on('click', function() {
		$(".mobile-nav").removeClass("open-mobile-nav")

	})
</script>




