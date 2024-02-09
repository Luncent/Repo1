<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User,
 model.Basket,
 model.Order,
 model.Orders,
 model.Product,
 dao.DataSql,
 java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/UsersOrdersPage.css" rel="stylesheet">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<title>Insert title here</title>
</head>
<body>
<% User user = (User)session.getAttribute("User");
   DataSql sql = new DataSql();
   Orders orders = new Orders(sql.getOrders());
   List<Order> myOrders = orders.getMyOrders(user.getLogin());
   request.setAttribute("myOrders", myOrders);
%>

<c:url value="UserPagePart_UserData.jsp" var="userDataUrl">
</c:url>

 	<div class="section1">  	
   		<div class="section11">
   			 <a href="UserPage.jsp">BuildWise</a>
   		</div>	
   		<div class="section111">
   			<c:import url="${userDataUrl}"/>
		</div>
	</div>
	
	 <c:if test="${myOrders.size()!=0}"> 
	 
	  <c:forEach var="order" items="${myOrders}">
	  <div class="order">
		 <div class="row">
		  <form method="post" action="ActionsPurchases">
		  
		  	<label >Номер заказа: ${order.getOrderID()}</label>
			<label >Общее число товаров в заказе: ${order.getProductsNumber()}</label>
			<label >Цена заказа: ${order.getCost()}</label>
			<label >Дата: ${order.getDate()}</label>
			
			<input type="hidden" name="orderID" value="${order.getOrderID()}" />
			<button type="submit" class="btn btn-primary">Удалить данные заказа</button>
			
		  </form>
		  
		 </div>
		 
		 
		 

		 <c:forEach var="product" items="${order.getProducts()}">
		 <div class="products">
		 		<label >Товар: </label><label>${product.getName()}</label>
		 		<label >Тип: </label><label>${product.getTypeName()}</label>
		 		<label >Свойства: </label><label>${product.getProductParameters()}</label>
		 		<label >Цена: </label><label>${product.getCost()}</label>
		 		<label >Число в заказе: </label><label>${product.getNumber()}</label>
		 		<label >Общая цена: </label><label>${product.getAllCost()}</label>
		 </div>
		 </c:forEach>
		 
	
	  </div>
	  </c:forEach>
	 
	  </c:if>		
	
</body>
</html>