<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css_styles/Basket.css" rel="stylesheet">
<title>Insert title here</title>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<div class="userdiv">
<%User user = (User)session.getAttribute("User");
 out.println("Пользователь: "+user.getLogin());%>
 <form method="post" action="Logout" >
    <button class="exitBtn">Выйти</button>
 </form>
   	<button onclick="window.location.href = 'UsersOrders.jsp'" class="exitBtn">Мои заказы</button>
 
 </div>
</body>
</html>