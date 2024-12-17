package com.foodApp.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.foodApp.Connection.ConnectionFactory;
import com.foodApp.Dto.OrderItems;

public class OrderItemDaoImpl implements OrderItemDao {
	
	Connection connection=null;
	
	public OrderItemDaoImpl() {
		connection = ConnectionFactory.getConnection();
	}

	@Override
	public OrderItems add(OrderItems o) {
	
		String query="INSERT INTO ORDER_ITEMS (ORDER_ID,FOOD_ID,QUANTITY,PRICE) VALUES (?,?,?,?)";
		
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, o.getOrderId());
			preparedStatement.setInt(2, o.getFoodId());
			preparedStatement.setInt(3, o.getQuantity());
			preparedStatement.setDouble(4, o.getPrice());
			if(preparedStatement.executeUpdate() >0)
			{
				return o;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public OrderItems update(OrderItems o) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OrderItems getOne(int orderItemId) {
		String query = "SELECT * FROM ORDER_ITEMS WHERE ORDER_ITEM_ID=?";
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
			preparedStatement.setInt(1, orderItemId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
			{
				OrderItems orderItem = new OrderItems();
				orderItem.setOrderItemId(resultSet.getInt(1));
				orderItem.setOrderId(resultSet.getInt(2));
				orderItem.setFoodId(resultSet.getInt(3));
				orderItem.setQuantity(resultSet.getInt(4));
				orderItem.setPrice(resultSet.getDouble(5));
				return orderItem;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	@Override
	public OrderItems getByOrderId(int orderId) {
		String query = "SELECT * FROM ORDER_ITEMS WHERE ORDER_ID=?";
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
			preparedStatement.setInt(1, orderId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
			{
				OrderItems orderItem = new OrderItems();
				orderItem.setOrderItemId(resultSet.getInt(1));
				orderItem.setOrderId(resultSet.getInt(2));
				orderItem.setFoodId(resultSet.getInt(3));
				orderItem.setQuantity(resultSet.getInt(4));
				orderItem.setPrice(resultSet.getDouble(5));
				return orderItem;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public boolean delete(int orderItemid) {
		// TODO Auto-generated method stub
		return false;
	}

}
