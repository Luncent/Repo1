<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/AdminPage.css" rel="stylesheet">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<title>Admin</title>
</head>
<body>

 <div class="str">
 	
 	<label class="lb1">Администратор</label>
 	
 	<div class="find">
 	    <form method="get" action="ActionsPurchases">
			<input type="number" name="orderID" placeholder="Номер заказа">
			<button type="submit" class="btn btn-primary">Найти</button>
		</form>
	</div>
	<p></p>
 	
	<div class="dropdown">
        <button class="dropdown-button">Товары</button>
        <div class="dropdown-content">
            <a href="CardboardPage.jsp">Картон</a>
            <a href="GluePage.jsp">Клей</a>
            <a href="DrywallPage.jsp">Гипсокартон</a>
            <a href="TapePage.jsp">Ленты</a>
            <a href="MembranaPage.jsp">Пленки</a>
        </div>
	</div>
	
	<button onclick="window.location.href = 'ProvidersPage.jsp'">Поставщики</button>
	<button onclick="window.location.href='download.jsp'">Отчет для поставок товаров</button>
	<button onclick="window.location.href='LoginPage.html'">Выйти</button>
	
 </div>

</body>
</html>