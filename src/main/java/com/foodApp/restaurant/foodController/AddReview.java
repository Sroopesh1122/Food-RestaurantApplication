package com.foodApp.restaurant.foodController;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

import com.foodApp.Dao.FoodItemDao;
import com.foodApp.Dao.FoodItemDaoImpl;
import com.foodApp.Dao.ReviewDao;
import com.foodApp.Dao.ReviewDaoImpl;
import com.foodApp.Dto.FoodItem;
import com.foodApp.Dto.Review;
import com.foodApp.Dto.User;

@WebServlet(urlPatterns = "/user/food/review")
public class AddReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddReview() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		System.out.println("Hai");
		HttpSession session = request.getSession();
		User user = (User)  session.getAttribute("user");
		RequestDispatcher requestDispatcher =null;
		if(user ==null)
		{
			requestDispatcher = request.getRequestDispatcher("/customer/Login.jsp");
			requestDispatcher.forward(request, response);
			return;
		}
		int rating = request.getParameter("rating")!=null ? Integer.parseInt(request.getParameter("rating"))  :0;
		String comment = request.getParameter("comment");
		int foodId = request.getParameter("foodId")!=null ? Integer.parseInt(request.getParameter("foodId"))  :-1;
		if(foodId!=-1 && rating!=0 && comment !=null)
		{
			FoodItemDao foodItemDao= new FoodItemDaoImpl();
			FoodItem foodItem = foodItemDao.getOne(foodId);
			Review review = new Review();
			review.setUserId(user.getUserId());
			review.setRestaurantId(foodItem.getRestaurantId());
			review.setRating(rating);
			review.setComment(comment);
			review.setReviewDate(new Timestamp(System.currentTimeMillis()));
			review.setFoodId(foodId);
			ReviewDao reviewDao= new ReviewDaoImpl();
			review = reviewDao.add(review);
			if(review!=null)
			{
				requestDispatcher = request.getRequestDispatcher("/customer/UserOrders.jsp");
				requestDispatcher.forward(request, response);
				return;
			}
			
		}
	}

}
