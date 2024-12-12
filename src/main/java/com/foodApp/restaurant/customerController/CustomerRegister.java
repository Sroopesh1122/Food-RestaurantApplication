package com.foodApp.restaurant.customerController;

import java.io.IOException;


import com.foodApp.Dao.UserDao;
import com.foodApp.Dao.UserDaopImpl;
import com.foodApp.Dto.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(urlPatterns = "/customer/register")
public class CustomerRegister extends HttpServlet  {
	private static final long serialVersionUID = 1L;
       
   
    public CustomerRegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("mobile");
		String password = request.getParameter("password");
		RequestDispatcher requestDispatcher =  null;
		if(name != null && email!=null  &&  phone !=null && password!=null)
		{
			
		
			UserDao userDao =   new UserDaopImpl();
			if(userDao.getOne(email)!= null)
			{
				request.setAttribute("errorMessage", "Email Already exists");
				requestDispatcher = request.getRequestDispatcher("/customer/SignUp.jsp");
				requestDispatcher.forward(request, response);
				return;
			}
		    User user = new User();
		    user.setName(name);
		    user.setEmail(email);
		    user.setPassword(password);
		    user.setPhoneNumer(phone);
		    user =  userDao.add(user);
		    if(user !=null)
		    {
		    	HttpSession session = request.getSession();
		    	session.setAttribute("user", user);
		    	request.setAttribute("errorMessage", "Email Already exists");
				requestDispatcher = request.getRequestDispatcher("/customer/Home.jsp");
				requestDispatcher.forward(request, response);
				return;
		    	
		    }else {
		    	request.setAttribute("errorMsg", "Something Went Wrong");
				requestDispatcher = request.getRequestDispatcher("/customer/SignUp.jsp");
				requestDispatcher.forward(request, response);
				return;
		    }
		    
		}
		
	}

}
