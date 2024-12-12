package com.foodApp.Dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class OrderItems
{
 private int orderItemId;
 private int OrderId;
 private int foodId;
 private int quantity;
 private double price;
 
}
