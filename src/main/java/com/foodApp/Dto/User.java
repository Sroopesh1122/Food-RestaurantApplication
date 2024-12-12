package com.foodApp.Dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
public class User
{
	
  private int userId;
  private String name;
  private String email;
  private String password;
  private String phoneNumer;
  private String address;
  private Timestamp createdAt; 
}
