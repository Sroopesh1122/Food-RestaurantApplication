package com.foodApp.restaurant.RestaurantController;

import java.io.IOException;


import com.foodApp.Dao.RestaurantDao;
import com.foodApp.Dao.RestaurantDaoImplmpl;
import com.foodApp.Dto.Restaurant;
import com.foodApp.Exception.CustomException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Login() {
        super();
    }



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher reqDispatcher = null;
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		try {
			RestaurantDao restaurantDao = new RestaurantDaoImplmpl();
		    Restaurant restaurant = restaurantDao.getRestaurant(email);
		    if(restaurant ==null)
		    {
		    	throw new CustomException("Email Not Found");
		    }
			
		    if(!password.equals(restaurant.getPassword()))
		    {
		    	throw new CustomException("Incorrect Password");
		    }
		    reqDispatcher = request.getRequestDispatcher("/restaurant/Home.jsp");
		    HttpSession session = request.getSession();
		    session.setAttribute("user", restaurant);
		    reqDispatcher.forward(request, response);
		} catch (CustomException e) {
			// TODO: handle exception
//			e.printStackTrace();
			reqDispatcher = request.getRequestDispatcher("/restaurant/Login.jsp");
			request.setAttribute("errorMessage",e.getMessage());
			reqDispatcher.forward(request, response);
			
		}
		
		
	}

}
