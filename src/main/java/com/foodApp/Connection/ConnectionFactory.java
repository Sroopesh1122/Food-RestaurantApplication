package com.foodApp.Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory
{
	static String url = "jdbc:mysql://localhost:3306/online_food_management";
	static String username = "root";
	static String password = "root";
	static Connection conn = null;

	public static Connection getConnection() {

		if (conn == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(url, username, password);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
		return conn;

	}
}
