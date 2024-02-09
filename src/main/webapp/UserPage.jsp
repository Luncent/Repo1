<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, javax.servlet.http.HttpServletRequest, model.Product,
 model.Catalog, javax.servlet.http.HttpSession, model.User, model.Basket"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/UserPage.css" rel="stylesheet">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<title>Insert title here</title>
</head>
<body>

<% String message = (String)session.getAttribute("PurchaseInfo");
	request.setAttribute("PurchaseInfo", message);
	session.removeAttribute("PurchaseInfo");
	Basket basket = (Basket)session.getAttribute("Basket");
	request.setAttribute("Basket", basket);
	%>

<c:url value="UserPagePart_Catalog.jsp" var="catalogUrl">
</c:url>
<c:url value="UserPagePart_Basket.jsp" var="basketUrl">
</c:url>
<c:url value="UserPagePart_UserData.jsp" var="userDataUrl">
</c:url>
<c:url value="UserPagePart_SortCatalog.jsp" var="sortCatalogUrl">
</c:url>

   	<div class="section1">  	
   		<div class="section11">
   			<a href="UserPage.jsp">BuildWise</a>
   		</div>	
   		<div class="section111">
   			<c:import url="${userDataUrl}"/>
		</div>
	</div>
	
	<div class="cls">
	<div class="section2">
		<div class="section21">
   			<c:import url="${sortCatalogUrl}"/>
   		</div>
   		<div class="section22">
   			<c:import url="${catalogUrl}"/>
   		</div>
   		<div class="section23">
   			<div class="txt22">Корзина</div>
   			<div class="purch">
   			<form method="get" action="MakePurchase" >
   				<button class="btn2">Заказать</button>
   			</form>	
   			</div>
   			
   			<div class="txt">
   			<c:choose>
   				<c:when test="${Basket!=null}">
   				<p>Цена:${Basket.getPurchaseCost()}</p>
   				</c:when>
   				<c:otherwise>
   					<p>Цена:0<p>
   				</c:otherwise>
    		</c:choose>
   			</div>
   				
   			<c:choose>
   				<c:when test="${PurchaseInfo!=null}">
   				<p>"${PurchaseInfo}"</p>
   				</c:when>
   				<c:otherwise>
   					
   				</c:otherwise>
   			</c:choose>
    	
   			<c:import url="${basketUrl}"/>
   		</div>
   	</div>
   	</div>
</body>
</html>