package com.foodApp.restaurant.RestaurantController;

import java.io.BufferedReader;
import java.io.IOException;


import com.foodApp.Dao.RestaurantDao;
import com.foodApp.Dao.RestaurantDaoImplmpl;
import com.foodApp.Dto.Restaurant;
import com.foodApp.Exception.CustomException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class Register
 */
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Register() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("mobile");
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		RequestDispatcher requestDispatcher = null;
		try {
			
			if(name==null || email==null|| phone==null|| address==null|| password==null)
			{
				throw new CustomException("All fileds Required");
			}
			
			Restaurant restaurant = new Restaurant();
			restaurant.setName(name);
			restaurant.setEmail(email);
			restaurant.setAddress(address);
			restaurant.setPhoneNumber(phone);
			restaurant.setPassword(password);
			System.out.println(restaurant.getName());
			RestaurantDao restaurantDao = new RestaurantDaoImplmpl();
			

			restaurant = restaurantDao.add(restaurant);
			if (restaurant == null) {
				throw new CustomException("Failed to Resgister");
			}
			HttpSession session = request.getSession();
			session.setAttribute("user", restaurant);
			requestDispatcher = request.getRequestDispatcher("/restaurant/Home.jsp");
			requestDispatcher.forward(request, response);

		} catch (CustomException e) {
			requestDispatcher = request.getRequestDispatcher("/restaurant/SignUp.jsp");
			request.setAttribute("errorMessage", e.getMessage());
			requestDispatcher.forward(request, response);
		}

	}

}
