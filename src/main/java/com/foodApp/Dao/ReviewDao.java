package com.foodApp.Dao;

import java.util.List;

import com.foodApp.Dto.Review;
import com.foodApp.Exception.CustomException;

public interface ReviewDao 
{
  public Review add(Review review) throws CustomException;
  public Review getReviewById(int reviewId) throws CustomException;
  public List<Review> getReviewByFoodId(int foodId) throws CustomException;
  public List<Review> getReviewByRestaurantId(int restaurantId) throws CustomException;
  public List<Review> getReview(int fooId,int userId) throws CustomException;
  public double getRating(int foodId) throws CustomException;
}
