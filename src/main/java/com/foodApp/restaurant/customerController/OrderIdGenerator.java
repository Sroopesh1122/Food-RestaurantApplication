package com.foodApp.restaurant.customerController;

import java.util.Random;

public class OrderIdGenerator 
{

	    public static String generateString() {
	    	int length = 20;

	        Random random = new Random();
	        StringBuilder result = new StringBuilder();

	        for (int i = 0; i < length - 10; i++) { 
	            char alphabet = (char) (random.nextBoolean() 
	                ? 'A' + random.nextInt(26) 
	                : 'a' + random.nextInt(26)); 
	            result.append(alphabet);
	        }

	        for (int i = 0; i < 10; i++) { 
	            int number = random.nextInt(10); 
	            result.append(number);
	        }

	        return result.toString();
	     }


}
