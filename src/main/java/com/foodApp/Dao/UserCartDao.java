package com.foodApp.Dao;

import java.util.List;

import com.foodApp.Dto.UserCart;
import com.foodApp.Exception.CustomException;

public interface UserCartDao
{
  public UserCart add (UserCart userCart) throws CustomException;
  public List<UserCart> getCartItems(int userId ,int page , int limit) throws CustomException;
  public boolean deleteCart(int cartId) throws CustomException;
  
  //To check wheather the food item present in usercart or not
  public boolean getCartItem(int userId , int foodId) throws CustomException;
  
  //To get total available in userCart
  
  public int getTotalItem(int userId) throws CustomException;
  
}
