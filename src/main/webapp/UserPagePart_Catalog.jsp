<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/product.css" rel="stylesheet">
<title>Insert title here</title>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<%
  Catalog catalog = (Catalog)session.getAttribute("Catalog"); 
  ArrayList<Product> products= catalog.products;
  request.setAttribute("products", products);
  String[] checkBoxes = {"",""};
  checkBoxes=(String[])session.getAttribute("CheckBoxes");
  request.setAttribute("CheckBoxesValues", checkBoxes);
%>

	<form action="SearchProducts" method="get">
	<div class="search">
  		<input type="text" name="query" placeholder="Введите запрос">
 		<button type="submit">Поиск</button>
 	</div>
 	</form>
 	
 	
	<form action="SortCatalog" method="get">
		<div class="sort1">
  		<label>
  		  <c:choose>
  		  	<c:when test="${CheckBoxesValues[0]!=null}">
  		  		<input type="checkbox" name="checkboxCheap" value="checked" checked> Сначала дешевые
  		  	</c:when>
  		  	<c:otherwise>
  		  		<input type="checkbox" name="checkboxCheap" value="null"> Сначала дешевые
  		  	</c:otherwise>
  		  </c:choose>
 		 </label>
 		 
 		 <label>
 		  <c:choose>
  		  	<c:when test="${CheckBoxesValues[1]!=null}">
  		  		 <input type="checkbox" name="checkboxExpensive" value="checked" checked> Сначала дорогие
  		  	</c:when>
  		  	<c:otherwise>
  		  		 <input type="checkbox" name="checkboxExpensive" value="null"> Сначала дорогие
  		  	</c:otherwise>
  		   </c:choose>	
 		 </label>
 		 
  		 <button type="submit">Применить</button>
  		 </div>
  		 </form>

<section class="section">
  <div class="container container_cards">
 <c:forEach var="product" items="${products}">
 	 <div class="card">
  		<!-- Верхняя часть -->
  			<div class="card__top">
    		<!-- Изображение-ссылка товара -->
    			<a href="#" class="card__image">
    				<c:choose>
    				<c:when test="${product.getName()=='клей'}">
    					<img src="./image/glue.png" alt="Glue"/>
    				</c:when>
    				<c:when test="${product.getName()=='пленка'}">
    					<img src="./image/пленка.jpg" alt="Glue"/>
    				</c:when>
    				<c:when test="${product.getName()=='гипсокартон'}">
    					<img src="./image/гипсокартон.png" alt="Glue"/>
    				</c:when>
    				<c:when test="${product.getName()=='лента'}">
    					<img src="./image/лента.png" alt="Glue"/>
    				</c:when>
    				<c:when test="${product.getName()=='картон'}">
    					<img src="./image/carboard.jpg" alt="Glue"/>
    				</c:when>
    				</c:choose>
			    </a>
		  </div>
  		<!-- Нижняя часть -->
  		<div class="card__bottom">
    		<div class="card__prices">
      			<div class="card__price card__price--common">
      				<c:out value="Цена: ${product.getCost()}"></c:out> 
      			</div>
    		</div>
    	<!--название товара -->
    		<div class="card__title"> 
				<c:out value="Товар: ${product.getName()} "></c:out>
				<br> 
				<c:out value="Тип: ${product.getTypeName()}, "></c:out> 
				<c:out value="Кол-во на складе: ${product.getNumbInStorage()}шт., "></c:out> 
				<c:out value="${product.getProductParameters()}"></c:out>
    		</div>
    		<div class="btm">
    	<!-- Кнопка добавить в корзину -->
    		<form method="post" action="AddToBasket" >
    			<input type="hidden" name="productID" value="${product.getID()}" />
    			<input type="hidden" name="productType" value="${product.getName()}" />
    			<input type="number" name="Number" value="1" />
    			<button class="card__add">В корзину</button>
    		</form>
    		</div>
  		</div>
	   </div>
		    
 </c:forEach>
 
 </div>
 </section>
</body>
</html>