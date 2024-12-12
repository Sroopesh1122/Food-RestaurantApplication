package com.foodApp.restaurant.customerController;

import java.io.IOException;



import com.foodApp.Dao.UserDao;
import com.foodApp.Dao.UserDaopImpl;
import com.foodApp.Dto.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/customer/login")
public class CustomerLogin extends jakarta.servlet.http.HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public CustomerLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		UserDao userDao =  new UserDaopImpl();
		RequestDispatcher requestDispatcher =null;
		
		if(email !=null && password!=null)
		{
          User user =  userDao.getOne(email); 
          if(user!=null)
          {
        	  if(!user.getPassword().equals(password))
        	  {
        		  requestDispatcher =  request.getRequestDispatcher("/customer/Login.jsp");
            	  request.setAttribute("errorMessage","Incorrect Password");
            	  requestDispatcher.forward(request, response); 
            	  return;
        	  }
        	  
        	  HttpSession session = request.getSession();
        	  session.setAttribute("user", user);
        	  requestDispatcher =  request.getRequestDispatcher("/customer/Home.jsp");
        	  requestDispatcher.forward(request, response);         	  
          }else {
        	  requestDispatcher =  request.getRequestDispatcher("/customer/Login.jsp");
        	  request.setAttribute("errorMessage","Email not found");
        	  requestDispatcher.forward(request, response);
          }
			
		}
	
	}

}
