<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User, model.Basket"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/Basket.css" rel="stylesheet">
<title>Insert title here</title>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
	<%Basket basket= (Basket)session.getAttribute("Basket");
	if(basket!=null){%>
	<%request.setAttribute("Basket", basket.basketProducts);
	 %>
	 <c:forEach var="basketProduct" items="${Basket}">
	 <div class="object">
	 	<div class="name">
	 	<c:out value="Товар: ${basketProduct.getProduct().getName()} "></c:out>
		</div>
		<div class="prodinfo">
		<c:out value="Тип: ${basketProduct.getProduct().getTypeName()}, "></c:out> 
		<c:out value="Кол-во на складе: ${basketProduct.getProduct().getNumbInStorage()}шт., "></c:out> 
		<c:out value="${basketProduct.getProduct().getProductParameters()} "></c:out><br>
		</div>
		<div class="number">
		<c:out value="Кол-во: ${basketProduct.getProductsNumber()}"></c:out>
		</div>
		<form method="get" action="AddToBasket" >
    			<input type="hidden" name="productID" value="${basketProduct.getProduct().getID()}" />
    			<input type="hidden" name="productType" value="${basketProduct.getProduct().getName()}" />
    			<button class="removeBtn">Убрать товар</button>
    	</form>
	 </div>
	 </c:forEach>
	 <%}%>
</body>
</html>