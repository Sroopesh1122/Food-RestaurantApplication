package com.foodApp.Dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class Restaurant
{
  private int restaurantId;
  private String name;
  private String address;
  private String phoneNumber;
  private String email;
  private String OpeningHours;
  private Double rating;
  private Timestamp createdAt;
  private String password;
  
}
