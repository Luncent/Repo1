package controler;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Order;
import model.Orders;

//@WebServlet("/ActionsPurchases")
public class ActionsPurchases extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ActionsPurchases() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("orderID")==null || request.getParameter("orderID").equals("")) {
			response.sendRedirect("AdminPage.jsp");
			System.out.println("заказ не найден");
		}
		else {
			HttpSession session = request.getSession(false);
			
			String purchaseIdstr=request.getParameter("orderID"); 
			int purchaseID=Integer.parseInt(purchaseIdstr);
		
			List<Order> orders = Orders.getOrderByID(purchaseID);
			session.setAttribute("Orders", orders);
			response.sendRedirect("FindPurchase.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String purchaseIdstr=request.getParameter("orderID"); 
		int purchaseID=Integer.parseInt(purchaseIdstr);
		Orders.deletePurchaseInfo(purchaseID);
		response.sendRedirect("UsersOrders.jsp");
	}

}
