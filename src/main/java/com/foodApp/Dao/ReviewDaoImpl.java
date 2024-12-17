package com.foodApp.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodApp.Connection.ConnectionFactory;
import com.foodApp.Dto.Review;
import com.foodApp.Exception.CustomException;

public class ReviewDaoImpl implements ReviewDao {

	
	Connection connection=null;
	public ReviewDaoImpl() {
		connection = ConnectionFactory.getConnection();
	}
	
	@Override
	public Review add(Review review) throws CustomException {
		String query = "INSERT INTO REVIEWS (USER_ID,RESTAURANT_ID,RATING,COMMENT,REVIEW_DATE,FOODID) VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
		    preparedStatement.setInt(1, review.getUserId());
		    preparedStatement.setInt(2, review.getRestaurantId());
		    preparedStatement.setInt(3, review.getRating());
		    preparedStatement.setString(4, review.getComment());
		    preparedStatement.setTimestamp(5, review.getReviewDate());
		    preparedStatement.setInt(6, review.getFoodId());
		    if(preparedStatement.executeUpdate()>0)
		    {
		    	ResultSet resultSet= preparedStatement.getGeneratedKeys();
		    	if(resultSet.next())
		    	{
		    		review.setReviewId(resultSet.getInt(1));
		    		updateFoodRating(review.getFoodId());
		    		return review;
		    	}
		    }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public Review getReviewById(int reviewId) throws CustomException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Review> getReviewByFoodId(int foodId) throws CustomException {
		String query ="SELECT * FROM REVIEWS WHERE FOODID=? ORDER BY REVIEW_ID DESC";
		List<Review> reviews = new ArrayList<Review>();
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
			preparedStatement.setInt(1, foodId);
			ResultSet resultSet = preparedStatement.executeQuery();
			while(resultSet.next())
			{
				Review review= new Review();
				review.setReviewId(resultSet.getInt(1));
				review.setUserId(resultSet.getInt(2));
				review.setRestaurantId(resultSet.getInt(3));
				review.setRating(resultSet.getInt(4));
				review.setComment(resultSet.getString(5));
				review.setReviewDate(resultSet.getTimestamp(6));
				review.setFoodId(resultSet.getInt(7));
				reviews.add(review);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return reviews;
	}

	@Override
	public List<Review> getReviewByRestaurantId(int restaurantId) throws CustomException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Review> getReview(int fooId, int userId) throws CustomException {
		String query ="SELECT * FROM REVIEWS WHERE USER_ID =? AND FOODID=?";
		List<Review> reviews = new ArrayList<Review>();
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
			preparedStatement.setInt(2, fooId);
			ResultSet resultSet = preparedStatement.executeQuery();
			while(resultSet.next())
			{
				Review review= new Review();
				review.setReviewId(resultSet.getInt(1));
				review.setUserId(resultSet.getInt(2));
				review.setRestaurantId(resultSet.getInt(3));
				review.setRating(resultSet.getInt(4));
				review.setComment(resultSet.getString(5));
				review.setReviewDate(resultSet.getTimestamp(6));
				review.setFoodId(resultSet.getInt(7));
				reviews.add(review);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return reviews;
	}
	
	@Override
	public double getRating(int foodId) throws CustomException {
		String query1="SELECT COUNT(*) FROM REVIEWS WHERE FOODID = ?";
		String query2="SELECT RATING FROM REVIEWS WHERE FOODID = ?";
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query1);
			PreparedStatement preparedStatement2 = connection.prepareStatement(query2);
			preparedStatement.setInt(1, foodId);
			preparedStatement2.setInt(1, foodId);
			int totalRatingCount =0;
			double rating=0;
			boolean found=false;
			ResultSet resultSet = preparedStatement.executeQuery();
			ResultSet resultSet2 = preparedStatement2.executeQuery();
			if(resultSet.next())
			{
				found=true;
				totalRatingCount = resultSet.getInt(1);
			}
			while(resultSet2.next())
			{
				rating+=resultSet2.getInt(1);
			}
			if(found)
			{
				rating = rating / totalRatingCount;
				double roundedNumber = Math.round(rating * 10.0) / 10.0; 
				return roundedNumber;
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	private boolean updateFoodRating(int foodId)
	{
		String query = "UPDATE FOOD_ITEMS SET RATING = ? WHERE FOOD_ID=?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			double rating = getRating(foodId);
			preparedStatement.setDouble(1, rating);
			preparedStatement.setInt(2, foodId);
			if(preparedStatement.executeUpdate()>0)
			{
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	

}
