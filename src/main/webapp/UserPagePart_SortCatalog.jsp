<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User, model.Basket"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css_styles/SortCatalog.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<title>Insert title here</title>
</head>
<body>
<%Catalog catalog = (Catalog)session.getAttribute("Catalog");
  ArrayList<String> types = catalog.getProductsTypes();
  request.setAttribute("ProductTypes", types);
  String selectedType=(String)session.getAttribute("SelectedType");
  session.removeAttribute("SelsectedType");
  request.setAttribute("SelectedType", selectedType);
  Double[] limits = null;
  if((Double[])session.getAttribute("CostLimits")==null){
  	limits  = new Double[]{0.0,1000.0};
  }
  else{
	limits=(Double[])session.getAttribute("CostLimits");
  }
  request.setAttribute("CostLimits", limits);
%>
<div class="sort">
<form method="get" action="Filters">
  <div class="Borders">
	Цена:<br>
   <div class="Cost">
		От<input class="holder" name="CostFrom" type="number" step="any" value="${CostLimits[0]}"><br>
		До<input class="holder" name="CostTo" type="number" step="any" value="${CostLimits[1]}">
   </div>
  </div>
  
  <div class="Borders">
  		Тип товара
		<select name="option">
		  <c:choose>
		   <c:when test="${SelectedType==null || SelectedType.equals('all')}"> <!-- проверено сравнение с all -->
  		   		<option value="all" selected>Все</option>
  			  <c:forEach var="type" items="${ProductTypes}">
  		    	<option value="${type}">${type}</option>
		  	  </c:forEach>
  		   </c:when>
  		   <c:otherwise>
  		    			<option value="all">Все</option>
  		      <c:forEach var="type" items="${ProductTypes}">
  		   		<c:choose>
		   			<c:when test="${SelectedType.equals(type)}">
  						<option value="${type}" selected>${type}</option>
  		   			</c:when>
  		   			<c:otherwise>
  		    			<option value="${type}">${type}</option>
  		  			</c:otherwise>
  		   		 </c:choose>
		  	   </c:forEach>
  		  </c:otherwise>
  		  </c:choose>	
		</select>
		<br><br>
		<button type="submit">Применить</button>
  </div>
</form>  

</div>

</body>
</html>