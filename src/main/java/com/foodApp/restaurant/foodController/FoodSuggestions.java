package com.foodApp.restaurant.foodController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


import com.foodApp.Dao.FoodItemDao;
import com.foodApp.Dao.FoodItemDaoImpl;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/suggestion/food" ,loadOnStartup = 5)
public class FoodSuggestions extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public FoodSuggestions() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder jsonString =  new StringBuilder();
		 FoodItemDao foodItemDao = new	FoodItemDaoImpl();
		try(BufferedReader reader = request.getReader())
		{
			String line;
			while((line = reader.readLine()) !=null)
			{
				jsonString.append(line);
			}
		}
		JsonObject jsonObject =  new Gson().fromJson(jsonString.toString(), JsonObject.class);
		String text = jsonObject.get("text").getAsString();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (text != null) {
                // Get suggestions based on the input text
                List<String> suggestions = foodItemDao.getSuggestion(text);

                // Convert the list of suggestions to JSON
                String jsonResponse = new Gson().toJson(suggestions);

                // Write the JSON response
                out.write(jsonResponse);
                out.flush();
            } else {
                // If 'text' is null, return an empty array
                out.write("[]");
                out.flush();
            }
        }

		
	}

}
