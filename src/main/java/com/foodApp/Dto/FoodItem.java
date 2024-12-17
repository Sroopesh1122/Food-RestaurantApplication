package com.foodApp.Dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class FoodItem
{
  private int foodId;
  private int restaurantId;
  private String name;
  private String description;
  private double price;
  private String category;
  private int availability;
  private Timestamp createdAt;
  private String img;
  private double rating;
}
