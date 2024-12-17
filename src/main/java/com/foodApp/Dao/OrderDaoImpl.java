package com.foodApp.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodApp.Connection.ConnectionFactory;
import com.foodApp.Dto.Orders;
import com.foodApp.Dto.Orders.Status;

public class OrderDaoImpl implements OrderDao {
	
	Connection connection=null;
	
	public OrderDaoImpl() {
		connection = ConnectionFactory.getConnection();
	}
	

	@Override
	public Orders add(Orders order) {
		String query = "INSERT INTO ORDERS (USER_ID,RESTAURANT_ID,ORDER_STATUS,TOTAL_PRICE,ORDER_DATE,DELIVERY_ADDRESS,ORDER_REFERENCE_ID) VALUES (?,?,?,?,?,?,?)";
		
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setInt(1, order.getUserId());
			preparedStatement.setInt(2, order.getRetaurantId());
			preparedStatement.setString(3,order.getOrderStatus().name());
			preparedStatement.setDouble(4, order.getTotalPrice());
			preparedStatement.setTimestamp(5, order.getOrderDate());
			preparedStatement.setString(6, order.getDeliveryAddress());
			preparedStatement.setString(7, order.getOrderReferenceId());
			
			if(preparedStatement.executeUpdate()>0)
			{
				ResultSet rs = preparedStatement.getGeneratedKeys();
				if(rs.next())
				{
					order.setOrderId(rs.getInt(1));
					return order;
				}
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}

	@Override
	public Orders getByOrderId(int orderId) {
		String query ="SELECT * FROM ORRDER WHERE ORDER_ID=?";
		
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
			preparedStatement.setInt(1, orderId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
			{
			  Orders order = new Orders();
			  order.setOrderId(resultSet.getInt(1));
			  order.setUserId(resultSet.getInt(2));
			  order.setRetaurantId(resultSet.getInt(3));
			  order.setOrderStatus(Status.valueOf(resultSet.getString(4)));
			  order.setTotalPrice(resultSet.getDouble(5));
			  order.setOrderDate(resultSet.getTimestamp(6));
			  order.setDeliveryAddress(resultSet.getString(7));
			  order.setOrderReferenceId(resultSet.getString(8));
			  return order;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public Orders getByOrderReferenceId(String referenceId) {
		String query ="SELECT * FROM ORRDER WHERE ORDER_REFERENCE_ID=?";
		
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
			preparedStatement.setString(1, referenceId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
			{
			  Orders order = new Orders();
			  order.setOrderId(resultSet.getInt(1));
			  order.setUserId(resultSet.getInt(2));
			  order.setRetaurantId(resultSet.getInt(3));
			  order.setOrderStatus(Status.valueOf(resultSet.getString(4)));
			  order.setTotalPrice(resultSet.getDouble(5));
			  order.setOrderDate(resultSet.getTimestamp(6));
			  order.setDeliveryAddress(resultSet.getString(7));
			  order.setOrderReferenceId(resultSet.getString(8));
			  return order;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public Orders update(int orderId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Orders> getAllOrders(int userId, int page, int limit) {
		String query ="SELECT * FROM ORDERS WHERE USER_ID=? ORDER BY ORDER_ID DESC LIMIT ? OFFSET ?";
		int skip = (page  -1 )*limit ; 
		
		List<Orders> orders = new ArrayList<Orders>();
		
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
			preparedStatement.setInt(1, userId);
			preparedStatement.setInt(2, limit);
			preparedStatement.setInt(3, skip);
			ResultSet resultSet = preparedStatement.executeQuery();
			while(resultSet.next())
			{
			  Orders order = new Orders();
			  order.setOrderId(resultSet.getInt(1));
			  order.setUserId(resultSet.getInt(2));
			  order.setRetaurantId(resultSet.getInt(3));
			  order.setOrderStatus(Status.valueOf(resultSet.getString(4).toUpperCase()));
			  order.setTotalPrice(resultSet.getDouble(5));
			  order.setOrderDate(resultSet.getTimestamp(6));
			  order.setDeliveryAddress(resultSet.getString(7));
			  order.setOrderReferenceId(resultSet.getString(8));
			  orders.add(order);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return orders;
	}
	
	@Override
	public int totalOrder(int userId) {
		String query ="SELECT COUNT(*) FROM ORDERS WHERE USER_ID=?";
				
		try {
			PreparedStatement preparedStatement= connection.prepareStatement(query);
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

}
