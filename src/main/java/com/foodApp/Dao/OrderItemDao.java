package com.foodApp.Dao;

import com.foodApp.Dto.OrderItems;

public interface OrderItemDao
{
  public OrderItems add(OrderItems o);
  public OrderItems update(OrderItems o);
  public OrderItems getOne(int orderItemId);
  public boolean delete(int orderItemid);
   
}
