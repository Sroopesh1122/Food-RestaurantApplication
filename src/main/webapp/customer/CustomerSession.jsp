<%@page import="com.foodApp.Dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  User user = (User) session.getAttribute("user");
%>