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
import java.util.ArrayList;
import java.util.List;

import com.foodApp.Dao.FoodItemDao;
import com.foodApp.Dao.FoodItemDaoImpl;
import com.foodApp.Dao.OrderDao;
import com.foodApp.Dao.OrderDaoImpl;
import com.foodApp.Dao.OrderItemDao;
import com.foodApp.Dao.OrderItemDaoImpl;
import com.foodApp.Dao.UserCartDao;
import com.foodApp.Dao.UserCartDaoImpl;
import com.foodApp.Dto.FoodItem;
import com.foodApp.Dto.OrderItems;
import com.foodApp.Dto.Orders;
import com.foodApp.Dto.Orders.Status;
import com.foodApp.Dto.User;
import com.foodApp.Dto.UserCart;


@WebServlet(urlPatterns = "/user/checkout")
public class Checkout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Checkout() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user =  (User) session.getAttribute("user");
		RequestDispatcher requestDispatcher = null;
		if(user == null)
		{
			requestDispatcher = request.getRequestDispatcher("/customer/Login.jsp");
			request.setAttribute("errorMessage","Please Login");
			requestDispatcher.forward(request, response);
			return;
		}
		FoodItemDao foodItemDao = new FoodItemDaoImpl();
		UserCartDao userCartDao = new UserCartDaoImpl();
		OrderDao orderDao = new OrderDaoImpl();
		OrderItemDao orderItemDao = new OrderItemDaoImpl();
		List<UserCart> cartItems = userCartDao.getCartItems(user.getUserId());

		String OrderReferenceId = OrderIdGenerator.generateString();
		
		List<OrderItems> orderItems = new ArrayList<OrderItems>();
		String deliveryAddress = request.getParameter("address");
		for(UserCart uc :cartItems)
		{
			FoodItem foodItem = foodItemDao.getOne(uc.getFoodId());
			OrderItems orderItem = new OrderItems();
			orderItem.setFoodId(foodItem.getFoodId());
			int quantity = Integer.parseInt( request.getParameter(foodItem.getFoodId()+""));
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
	        //Adding order data
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
	        
	        if(orderPlaced && itemAdded)
	        {
	        	userCartDao.deleteCart(uc.getCartid());
	        }
		}

	}

}
