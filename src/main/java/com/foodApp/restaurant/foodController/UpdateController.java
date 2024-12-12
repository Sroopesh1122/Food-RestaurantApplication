package com.foodApp.restaurant.foodController;

import java.io.IOException;



import com.foodApp.Dao.FoodItemDao;
import com.foodApp.Dao.FoodItemDaoImpl;
import com.foodApp.Dto.FoodItem;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateController
 */
@WebServlet(urlPatterns = "/food/update")
public class UpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  
		String priceStr = request.getParameter("price");
		String availabilityStr = request.getParameter("availability");
		String foodIdStr = request.getParameter("foodId");
		Double price = Double.parseDouble(priceStr);
		int available = availabilityStr.toLowerCase().equalsIgnoreCase("available") ? 1 :0;
		RequestDispatcher requestDispatcher =  request.getRequestDispatcher("/restaurant/FoodItem.jsp?id="+Integer.parseInt(foodIdStr));
		FoodItemDao foodItemDao = new FoodItemDaoImpl();
		
		
		System.out.println(foodIdStr);
		
		FoodItem foodItem =  foodItemDao.getOne(Integer.parseInt(foodIdStr));
		if(foodItem != null)
		{
	       foodItem.setPrice(price);
	       foodItem.setAvailability(available);
	       foodItem = foodItemDao.update(foodItem);
	       if(foodItem !=null)
	       {
	    	   request.setAttribute("success","Food Item updated successfully");
	       }else {
	    	   request.setAttribute("error","Failed to update");
	       }
		}else {
			request.setAttribute("error","Food Item not found");
		}
		
		requestDispatcher.forward(request, response);
	
	}

}
