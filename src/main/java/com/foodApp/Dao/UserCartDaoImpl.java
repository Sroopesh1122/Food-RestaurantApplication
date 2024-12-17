package com.foodApp.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodApp.Connection.ConnectionFactory;
import com.foodApp.Dto.UserCart;
import com.foodApp.Exception.CustomException;

public class UserCartDaoImpl implements UserCartDao {

	Connection connection=null;
	
	public UserCartDaoImpl() {
		connection = ConnectionFactory.getConnection();
	}
	
	@Override
	public UserCart add(UserCart userCart) throws CustomException {
		String query = "INSERT INTO USER_CART (USERID , FOODID) VALUES (?,?)";
		try {
			PreparedStatement preparedStatement =  connection.prepareStatement(query , Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setInt(1,userCart.getUserid());
			preparedStatement.setInt(2, userCart.getFoodId());
			if(preparedStatement.executeUpdate() >0)
			{
				ResultSet rs = preparedStatement.getGeneratedKeys();
				if(rs.next()) {
					userCart.setCartid(rs.getInt(1));
					return userCart;
				}
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public List<UserCart> getCartItems(int userId) throws CustomException {
		String query = "SELECT * FROM USER_CART WHERE USERID = ? ORDER BY CARTID DESC ";
		List<UserCart>  userCarts= new ArrayList<UserCart>();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
			ResultSet resultSet = preparedStatement.executeQuery();
			while(resultSet.next())
			{
				userCarts.add(new UserCart(resultSet.getInt(1),resultSet.getInt(2) ,resultSet.getInt(3)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userCarts;
	}
	
	

	@Override
	public List<UserCart> getCartItems(int userId ,int page , int limit) throws CustomException {
		String query = "SELECT * FROM USER_CART WHERE USERID = ? ORDER BY CARTID DESC LIMIT ? OFFSET ?";
		List<UserCart>  userCarts= new ArrayList<UserCart>();
		int skip = (page - 1) * limit;
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
			preparedStatement.setInt(2, limit);
			preparedStatement.setInt(3, skip);
			ResultSet resultSet = preparedStatement.executeQuery();
			while(resultSet.next())
			{
				userCarts.add(new UserCart(resultSet.getInt(1),resultSet.getInt(2) ,resultSet.getInt(3)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userCarts;
	}

	@Override
	public boolean deleteCart(int cartId) throws CustomException {
		boolean deleted = false;
		
		String query ="DELETE FROM USER_CART WHERE CARTID=?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, cartId);
			if(preparedStatement.executeUpdate()>0)
			{
				deleted = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return deleted;
	}

	@Override
	public boolean getCartItem(int userId, int foodId) throws CustomException {
		String query= "SELECT * FROM USER_CART WHERE USERID=? AND FOODID=?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
			preparedStatement.setInt(2, foodId);
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next())
			{
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
	@Override
	public int getTotalItem(int userId) throws CustomException {
		String query = "SELECT COUNT(*) FROM USER_CART WHERE USERID = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
			{
				return resultSet.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	@Override
	public boolean delete(int userId) throws CustomException {
		String query="DELETE FROM USER_CART WHERE USERID=?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
			if(preparedStatement.executeUpdate()>0)
			{
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	
}
