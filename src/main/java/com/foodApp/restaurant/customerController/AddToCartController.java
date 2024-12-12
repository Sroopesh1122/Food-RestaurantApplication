package com.foodApp.restaurant.customerController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;



import com.foodApp.Dao.UserCartDao;
import com.foodApp.Dao.UserCartDaoImpl;
import com.foodApp.Dto.User;
import com.foodApp.Dto.UserCart;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(urlPatterns = "/user/cart/add")
public class AddToCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		StringBuilder jsonString =  new StringBuilder();
		
		try(BufferedReader reader = request.getReader())
		{
			String line;
			while((line = reader.readLine()) !=null)
			{
				jsonString.append(line);
			}
		}
		
		System.out.println(jsonString);
			
		JsonObject jsonData = new Gson().fromJson(jsonString.toString(), JsonObject.class);
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if(user ==null)
		{
			try (PrintWriter out = response.getWriter()) {
				
				   JsonObject jsonObject = new JsonObject();
				   jsonObject.addProperty("error", true);
				   jsonObject.addProperty("message", "Login In Save Item");
	               out.write(jsonObject.toString());
	               out.flush();
	        }
			return ;
		}
		int userId = user.getUserId();
        int foodId = jsonData.get("foodId").getAsInt();
        UserCartDao userCartDao = new UserCartDaoImpl();
        UserCart userCart = new UserCart();
        userCart.setUserid(userId);
        userCart.setFoodId(foodId);
        userCart =  userCartDao.add(userCart);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (userCart != null) {
            	JsonObject jsonObject = new JsonObject();
				   jsonObject.addProperty("error", false);
				   jsonObject.addProperty("failed", false);
				   jsonObject.addProperty("message", "Food Added");
	               out.write(jsonObject.toString());
	               out.flush();
            } else {
            	JsonObject jsonObject = new JsonObject();
				   jsonObject.addProperty("failed", true);
				   jsonObject.addProperty("message", "Failed to add to cart");
	               out.write(jsonObject.toString());
	               out.flush();
            }
        }
        
		
	}

}
