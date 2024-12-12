package com.foodApp.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.foodApp.Connection.ConnectionFactory;
import com.foodApp.Dto.Restaurant;
import com.foodApp.Exception.CustomException;

public class RestaurantDaoImplmpl implements RestaurantDao {

	Connection connection=null;
	
	public RestaurantDaoImplmpl() {
		connection = ConnectionFactory.getConnection();
	}
	
	@Override
	public Restaurant add(Restaurant r) throws CustomException {
		String query = "INSERT INTO RESTAURANTS (NAME,EMAIL,ADDRESS,PHONE_NUMBER,PASSWORD) VALUES (?,?,?,?,?)";
		if(getRestaurant(r.getEmail()) !=null)
		{
			throw new CustomException("Email Already exists");
		}
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, r.getName());
			preparedStatement.setString(2, r.getEmail());
			preparedStatement.setString(3, r.getAddress());
			preparedStatement.setString(4, r.getPhoneNumber());
			preparedStatement.setString(5, r.getPassword());
			if(preparedStatement.executeUpdate() >0 )
			{
				ResultSet keys = preparedStatement.getGeneratedKeys();
				if(keys.next())
				{
					r.setRestaurantId(keys.getInt(1));
					return r;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException("Something Went Wrong");
		}	
		return null;
	}

	@Override
	public Restaurant update(Restaurant r) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Restaurant getOne(int restaurantId) {
		String query="SELECT * FROM RESTAURANTS WHERE RESTAURANT_ID=?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, restaurantId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
			{
				Restaurant restaurant = new Restaurant();
				restaurant.setRestaurantId(resultSet.getInt(1));
				restaurant.setName(resultSet.getString(2));
				restaurant.setAddress(resultSet.getString(3));
				restaurant.setPhoneNumber(resultSet.getString(4));
				restaurant.setEmail(resultSet.getString(5));
				restaurant.setOpeningHours(resultSet.getString(6));
				restaurant.setRating(resultSet.getDouble(7));
				restaurant.setCreatedAt(resultSet.getTimestamp(8));
				restaurant.setPassword(resultSet.getString(9));
				return restaurant;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean delete(int restaurantId) {
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public Restaurant getRestaurant(String email) throws CustomException {
		String query = "SELECT * FROM RESTAURANTS WHERE EMAIL=?";
		
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, email);
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next())
			{
			   Restaurant restaurant = new Restaurant();
			   restaurant.setRestaurantId(rs.getInt(1));
			   restaurant.setName(rs.getString(2));
			   restaurant.setAddress(rs.getString(3));
			   restaurant.setPhoneNumber(rs.getString(4));
			   restaurant.setEmail(rs.getString(5));
			   restaurant.setOpeningHours(rs.getString(6));
			   restaurant.setRating(rs.getDouble(7));
			   restaurant.setCreatedAt(rs.getTimestamp(8));
			   restaurant.setPassword(rs.getString(9));
			   return restaurant;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new CustomException("Something Went Wrong");
		}
		return null;
	}

}
