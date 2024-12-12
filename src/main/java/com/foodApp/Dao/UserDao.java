package com.foodApp.Dao;

import com.foodApp.Dto.User;
import com.foodApp.Exception.CustomException;

public interface UserDao
{
  public User add(User u) throws CustomException;
  public User update(User u) throws CustomException;
  public User getOne(int userId) throws CustomException;
  public User getOne(String email) throws CustomException;
  public boolean delete(int userId) throws CustomException;
}
