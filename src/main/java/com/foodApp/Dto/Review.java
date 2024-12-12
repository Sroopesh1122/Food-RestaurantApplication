package com.foodApp.Dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class Review
{
 private int reviewId;
 private int userId;
 private int restaurantId;
 private int rating;
 private String comment;
 private Timestamp reviewDate;
}
