<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User,
 model.Supplies"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/CardboardPage.css" rel="stylesheet">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<title>Admin</title>
</head>
<body>
<% 
   try{
   Supplies sups = new Supplies();
   request.setAttribute("Providers",sups.getAllProviders());
   Catalog catalog = (Catalog)session.getAttribute("Catalog");
   ArrayList<Product> cardboardProducts=catalog.getCardboardProducts();
   request.setAttribute("CardboardProducts",cardboardProducts);
%>

<div class="Cardboard">
	
<div class="stroka">
	<label for="product">Продукт</label>
	<label for="type">Тип</label>
	<label for="layers">Кол-во слоев</label>
	<label for="length">Длина</label>
	<label for="area">Площадь</label>
	<label for="price">Цена</label>
	<label for="stock">Остаток</label>
</div>
	
	  <c:if test="${CardboardProducts.size()!=0}">
	
	  <c:forEach var="product" items="${CardboardProducts}">
		  <div class="row">
		  <form method="post" action="EditCardboard" class="form-inline">
		  
			<label >${product.getName()}</label>
			<input type="text" name="type" value="${product.getTypeName()}">
			<input type="number" name="layers" value="${product.getOtherParameters()[0]}">
			<input type="number" step="any" name="length" value="${product.getOtherParameters()[1]}">
			<input type="number" step="any" name="area" value="${product.getOtherParameters()[2]}">
			<input type="number" step="any" name="cost" value="${product.getCost()}">
			<input type="number" name="number" value="${product.getNumbInStorage()}">
	
				<input type="hidden" name="productID" value="${product.getID()}" />
				<button type="submit" class="btn btn-primary">Изменить</button>
			
		  </form>
		
		  <form method="post" action="DeleteProduct" class="form-inline">
		    <input type="hidden" name="productTypeID" value="1" />
		  	<input type="hidden" name="productID" value="${product.getID()}" />
			<button type="submit" class="btn btn-primary">Удалить</button>
		  </form>
		  </div>
		
	  </c:forEach>
	  
	  </c:if>			
	
	
	<form method="post" action="AddCardboard">		 
	  <div class="str2">
	  	<input type="text" class="form-control" name="productType" placeholder="Тип">
	  	<input type="number" class="form-control" name="layersNumber" placeholder="Кол-во слоев">
	  	<input type="number" step="any" class="form-control" name="length" placeholder="Длина">
	  	<input type="number" step="any" class="form-control" name="area" placeholder="Площадь"> 
	  	<input type="number" step="any" class="form-control" name="cost" placeholder="Цена">
	  	<input type="number" class="form-control" name="number" placeholder="Остаток">
	  	<input type="number" step="any" class="form-control" name="providerCost" placeholder="Цена Поставки">
	  	<select name="option">
		  <c:choose>
		   <c:when test="${Providers!=null && Providers.size()!=0}"> <!-- проверено сравнение с all -->
  			  <c:forEach var="name" items="${Providers}">
  		    	<option value="${name}">${name}</option>
		  	  </c:forEach>
		  	</c:when>
		  	  
		  	 <c:otherwise>
		  	   <option value="empty" selected>0 поставщиков</option>
		  	 </c:otherwise>
		  </c:choose>
		</select>
	  	<button type="submit" class="btn btn-primary">Добавить</button>
	  </div>
	 </form>
	 
	 </div>
	 
	 <div class="back">
	 	<a href="AdminPage.jsp" class="button">Назад</a>
	 </div>
  
<%}
  catch(Exception e){
	  e.printStackTrace();
%>	  
	<p>Видимо вы не вошли в сессию</p>	
	<a class="link" href="LoginPage.html">Страница входа</a>  
  <% }%>

</body>
</html>