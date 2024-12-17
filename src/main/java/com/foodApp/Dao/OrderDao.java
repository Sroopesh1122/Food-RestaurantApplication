package com.foodApp.Dao;

import java.util.List;

import com.foodApp.Dto.Orders;

public interface OrderDao 
{
  public Orders add(Orders order);
  public Orders getByOrderId(int orderId);
  public Orders getByOrderReferenceId(String referenceId);
  public Orders update(int orderId);
  public List<Orders> getAllOrders(int userId,int page,int limit);
  public int totalOrder(int userId);
}
