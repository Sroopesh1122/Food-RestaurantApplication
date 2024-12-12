package com.foodApp.restaurant.customerController;

import java.io.IOException;
import com.foodApp.Dao.UserCartDao;
import com.foodApp.Dao.UserCartDaoImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteCartItemController
 */

@WebServlet(urlPatterns = "/user/cart/delete")
public class DeleteCartItemController extends jakarta.servlet.http.HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public DeleteCartItemController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cartId = request.getParameter("cartId")!=null ? Integer.parseInt(request.getParameter("cartId"))  : -1;
		if(cartId!=-1)
		{
			UserCartDao userCartDao = new UserCartDaoImpl();
			userCartDao.deleteCart(cartId);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/customer/UserCart.jsp");
			requestDispatcher.forward(request, response);	
		}
	}



}
