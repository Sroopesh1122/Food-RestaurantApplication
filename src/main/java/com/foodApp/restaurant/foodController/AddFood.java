package com.foodApp.restaurant.foodController;

import java.io.File;
import java.io.IOException;


import com.foodApp.Dao.FoodItemDao;
import com.foodApp.Dao.FoodItemDaoImpl;
import com.foodApp.Dto.FoodItem;
import com.foodApp.Dto.Restaurant;
import com.foodApp.Exception.CustomException;
import com.foodApp.Utils.CloudinaryUploader;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@jakarta.servlet.annotation.WebServlet(urlPatterns = "/food/add")
@jakarta.servlet.annotation.MultipartConfig
public class AddFood extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public AddFood() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	   
		String name = request.getParameter("name");
		String desc = request.getParameter("description");
		String price = request.getParameter("price");
		String categories = request.getParameter("category");
		jakarta.servlet.http.Part image = request.getPart("image");
		RequestDispatcher requestDispatcher =null;

		if(request.getSession().getAttribute("user") == null)
		{
			requestDispatcher = request.getRequestDispatcher("/restaurant/Login.jsp");
			requestDispatcher.forward(request, response);
			return ;
		}
		try {
			if(name ==null || desc ==null || price ==null || categories ==null || image ==null)
			{
				throw new CustomException("All Fileds Required");
			}
				String filename = image.getSubmittedFileName();
				String uploadPath = getServletContext().getRealPath("/imgs");

				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					boolean dirsCreated = uploadDir.mkdirs();
					System.out.println("Directory created: " + dirsCreated); // Debugging: Check if directory was created
				}

				// Define the full file path
				String filePath = uploadPath + File.separator + filename;

				// Write the uploaded file to disk
				image.write(filePath);

				// Log file existence
				File file = new File(filePath);
				String uploadedUrl = CloudinaryUploader.upload(filePath);
				FoodItem foodItem = new FoodItem();
				foodItem.setAvailability(1);
				foodItem.setName(name);
				foodItem.setCategory(categories);
				foodItem.setDescription(desc);
				foodItem.setPrice(Double.parseDouble(price));
				Restaurant r = (Restaurant) request.getSession().getAttribute("user");
				foodItem.setRestaurantId(r.getRestaurantId());
				foodItem.setImg(uploadedUrl);
				
				FoodItemDao foodItemDao = new FoodItemDaoImpl();

				foodItem =  foodItemDao.add(foodItem);
				if(foodItem==null)
				{
					throw new CustomException("Failed to add");
				}
				requestDispatcher = request.getRequestDispatcher("/restaurant/AddFood.jsp");
				request.setAttribute("successMessage","Food added successfully");
				requestDispatcher.forward(request, response);
		} catch (CustomException e) {
			requestDispatcher = request.getRequestDispatcher("/restaurant/AddFood.jsp");
			request.setAttribute("errorMessage", e.getMessage());
			requestDispatcher.forward(request, response);
		}
	
	}

}
