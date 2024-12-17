package com.foodApp.restaurant.customerController;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

import com.foodApp.Dao.FoodItemDao;
import com.foodApp.Dao.FoodItemDaoImpl;
import com.foodApp.Dao.OrderDao;
import com.foodApp.Dao.OrderDaoImpl;
import com.foodApp.Dao.OrderItemDao;
import com.foodApp.Dao.OrderItemDaoImpl;
import com.foodApp.Dto.FoodItem;
import com.foodApp.Dto.OrderItems;
import com.foodApp.Dto.Orders;
import com.foodApp.Dto.User;
import com.foodApp.Dto.Orders.Status;


@WebServlet("/user/food/order")
public class BuyOrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public BuyOrderController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user =  (User) session.getAttribute("user");
		int foodId = request.getParameter("foodId")!=null ? Integer.parseInt(request.getParameter("foodId")) :-1;
		int quantity = request.getParameter("quantity")!=null ? Integer.parseInt(request.getParameter("quantity")) :-1;
		String deliveryAddress = request.getParameter("address");
		RequestDispatcher requestDispatcher = null;
		if(user == null)
		{
			requestDispatcher = request.getRequestDispatcher("/customer/Login.jsp");
			request.setAttribute("errorMessage","Please Login");
			requestDispatcher.forward(request, response);
			return;
		}
		if(foodId !=-1 && quantity !=-1 && deliveryAddress!=null)
		{
			FoodItemDao foodItemDao = new FoodItemDaoImpl();
			OrderDao orderDao = new OrderDaoImpl();
			OrderItemDao orderItemDao = new OrderItemDaoImpl();
			String OrderReferenceId = OrderIdGenerator.generateString();
			
			FoodItem foodItem = foodItemDao.getOne(foodId);
			OrderItems orderItem = new OrderItems();
			orderItem.setFoodId(foodItem.getFoodId());
			orderItem.setQuantity(quantity );
	        orderItem.setPrice(quantity * foodItem.getPrice());
	        Orders order = new Orders();
	        order.setUserId(user.getUserId());
	        order.setRetaurantId(foodItem.getRestaurantId());
	        order.setOrderStatus(Status.PENDING);
	        order.setTotalPrice(quantity * foodItem.getPrice());
	        order.setDeliveryAddress(deliveryAddress);
	        order.setOrderReferenceId(OrderReferenceId);
	        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
	        boolean orderPlaced= false;
	        boolean itemAdded =false;
	        order = orderDao.add(order);
	        if(order != null)
	        {
	        	orderPlaced=true;
	        }
	        orderItem.setOrderId(order.getOrderId());
	        orderItem = orderItemDao.add(orderItem);
	        if(orderItem!=null)
	        {
	        	itemAdded =true;
	        }
	        if(itemAdded && orderPlaced)
	        {
	        	requestDispatcher = request.getRequestDispatcher("/customer/UserOrders.jsp");
	        	requestDispatcher.forward(request, response);
	        }
		}
	}

}
