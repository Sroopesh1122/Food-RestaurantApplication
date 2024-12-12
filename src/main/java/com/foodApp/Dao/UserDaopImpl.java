package com.foodApp.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.foodApp.Connection.ConnectionFactory;
import com.foodApp.Dto.User;
import com.foodApp.Exception.CustomException;

public class UserDaopImpl implements UserDao
{
	Connection connection=null;
	
	public UserDaopImpl() {
		connection = ConnectionFactory.getConnection();
	}

	@Override
	public User add(User u) {		
		String query = "INSERT INTO USERS (NAME,EMAIL , PASSWORD , PHONE_NUMBER) VALUES (?,?,?,?)";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, u.getName());
			preparedStatement.setString(2, u.getEmail());
			preparedStatement.setString(3, u.getPassword());
			preparedStatement.setString(4, u.getPhoneNumer());
			
			if(preparedStatement.executeUpdate()>0)
			{
				ResultSet rs = preparedStatement.getGeneratedKeys();
				if(rs.next())
				{
					u.setUserId(rs.getInt(1));
					return u;
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public User update(User u) {
		
		return null;
	}

	@Override
	public User getOne(int userId) {
		String query = "SELECT * FROM USERS WHERE USER_ID = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
				ResultSet rs = preparedStatement.executeQuery();
				if(rs.next())
				{
					User u = new User();
					u.setUserId(rs.getInt(1));
					u.setName(rs.getString(2));
					u.setEmail(rs.getString(3));
					u.setPassword(rs.getString(4));
					u.setPhoneNumer(rs.getString(5));
					u.setAddress(rs.getString(6));
					u.setCreatedAt(rs.getTimestamp(7));
					return u;
				}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public User getOne(String email) {
		String query = "SELECT * FROM USERS WHERE EMAIL = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, email);
				ResultSet rs = preparedStatement.executeQuery();
				if(rs.next())
				{
					User u = new User();
					u.setUserId(rs.getInt(1));
					u.setName(rs.getString(2));
					u.setEmail(rs.getString(3));
					u.setPassword(rs.getString(4));
					u.setPhoneNumer(rs.getString(5));
					u.setAddress(rs.getString(6));
					u.setCreatedAt(rs.getTimestamp(7));
					return u;
				}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean delete(int userId) {
		// TODO Auto-generated method stub
		return false;
	}

}
