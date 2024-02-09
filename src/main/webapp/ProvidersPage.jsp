<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User,
 model.Supplies,
 model.Providers,
 model.Provider,
 dao.DataSql,
 model.ProviderInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/Providers.css" rel="stylesheet">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<title>Admin</title>
</head>
<body>
<% 
   try{
  	Providers providers = new Providers();
  	request.setAttribute("ProvidersInfo", providers.getProviders());
  	DataSql sql = new DataSql();
  	request.setAttribute("Providers", sql.getAllProvidersInfo());
%>

<div class="Cardboard">
	
<div class="stroka">
	<label for="product">Поставщик</label>
	<label for="type">Продукт</label>
	<label for="price">Цена за штуку</label>
</div>
	
	<c:if test="${ProvidersInfo!=null && ProvidersInfo.size()!=0}">
	  
	  <c:forEach var="providerInfo" items="${ProvidersInfo}">
		<div class="row">
		  <form method="post" action="ActionsProviders">
		  
			<label>${providerInfo.getName()}</label>
			
			<label class="lb2" >${providerInfo.getProduct()}</label>
			
			<input type="number" step="any" name="cost" value="${providerInfo.getCost()}">
	
			<input type="hidden" name="productID" value="${providerInfo.getProductID()}" />
			<input type="hidden" name="productTypeID" value="${providerInfo.getProductTypeID()}" />
			<input type="hidden" name="providerID" value="${providerInfo.getProviderID()}" />
			<button type="submit" class="btn btn-primary">Изменить</button>
			
		  </form>
		</div>
	  </c:forEach>
	  		
	</c:if>
	<div class="providers">
	
	<div class="stroka">
		<label for="type">Поставщики</label>
	</div>
	
	<c:if test="${Providers!=null && Providers.size()!=0}">

	  <c:forEach var="provider" items="${Providers}">
		
		  
		  <div class="prov">
		    <form method="get" action="ActionsProviders">
				<input type="text" name="name" value="${provider.getName()}">
			
				<input type="hidden" name="providerID" value="${provider.getID()}" />
				<button type="submit" class="btn btn-primary">Изменить</button>
			
			</form>	
			
			<form method="post" action="DeleteProvider">
				<input type="hidden" name="providerID" value="${provider.getID()}" />
				<button type="submit" class="btn btn-primary">Удалить</button>
			
			</form>	
		  </div>
		  
		
	  </c:forEach>
	  	<form method="post" action="AddProvider">
			<input type="text" name="name" placeholder="Название поставщика">
			<button type="submit" class="btn btn-primary">Добавить</button>
		</form>
	 </c:if>
	 
	 </div>
	 
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