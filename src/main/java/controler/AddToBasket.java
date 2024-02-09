package controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Basket;
import model.BasketProduct;
import model.Catalog;
import model.Product;

//@WebServlet("/AddToBasket")
public class AddToBasket extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public AddToBasket() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		String productType = request.getParameter("productType");
		int productID =Integer.parseInt(request.getParameter("productID"));
		
		HttpSession session=request.getSession(false);
		
		System.out.println("Cессия 2-"+session.getId());
		System.out.println(session.toString());
		System.out.println("тип продукта "+productType+" ид продукта"+productID);
		
		Basket basket = (Basket)session.getAttribute("Basket"); 
		
		basket.removeProduct(productType, productID);
		
		session.setAttribute("Basket", basket);
		response.sendRedirect("UserPage.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		String productType = request.getParameter("productType");
		String numberstr = request.getParameter("Number");
		int productID =Integer.parseInt(request.getParameter("productID"));
		int number =Integer.parseInt(numberstr);
		
		HttpSession session=request.getSession(false);
		
		Basket basket = (Basket)session.getAttribute("Basket"); 
		if(basket==null) {
			basket=new Basket();
		}
		
		System.out.println("Cессия 2-"+session.getId());
		System.out.println(session.toString());
		System.out.println("тип продукта "+productType+" ид продукта"+productID);
		
		Catalog catalog=(Catalog)session.getAttribute("Catalog");
		
		if(catalog==null) {
			System.out.println("catalog pust");
		}
		
		for(Product product:catalog.products) {
			System.out.println(product.getID()+product.getName()+product.getProductParameters());
			if(product.getID()==productID && product.getName().equals(productType)) {
				basket.addProduct(product, number);
				System.out.println(product.getID()+product.getName()+product.getProductParameters());
			}
		}
		session.setAttribute("Basket", basket);
		response.sendRedirect("UserPage.jsp");
		
	}
}
