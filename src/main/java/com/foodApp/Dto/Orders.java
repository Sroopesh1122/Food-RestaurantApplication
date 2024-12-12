package com.foodApp.Dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class Orders 
{
	public enum Status{
		PENDING,CONFIRMED,PREPARING,OUT_FOR_DELIVERY,DELIVERED,CANCELLED
	}
	
  private int orderId;
  private int userId;
  private int retaurantId;
  private Status orderStatus;
  private double totalPrice;
  private Timestamp orderDate;
  private String deliveryAddress;
  
}
