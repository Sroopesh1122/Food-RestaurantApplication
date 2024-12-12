package com.foodApp.Dao;

import com.foodApp.Dto.Restaurant;
import com.foodApp.Exception.CustomException;

public interface RestaurantDao
{
  public Restaurant add(Restaurant r) throws CustomException;
  public Restaurant update(Restaurant r) throws CustomException;
  public Restaurant getOne(int restaurantId) throws CustomException;
  public boolean delete(int restaurantId) throws CustomException;
  public Restaurant getRestaurant(String email) throws CustomException;
}
