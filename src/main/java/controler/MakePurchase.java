package controler;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Basket;
import model.Catalog;
import model.User;

//@WebServlet("/MakePurchase")
public class MakePurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MakePurchase() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session=request.getSession(false);
		
		Basket basket = (Basket)session.getAttribute("Basket");
		ArrayList<String> missmatches= new ArrayList<>();
		
		if (basket==null || basket.basketProducts.size()==0) {
			response.sendRedirect("UserPage.jsp");
			System.out.println("Корзина пуста");
			return;
		}

		else {
			missmatches.addAll(basket.cmprPurchaseWStorage());
			if(missmatches.size()==0) {
				User user = (User)session.getAttribute("User");
				basket.makePurchase(user.getID());
				basket.basketProducts.clear();
				Catalog catalog = new Catalog();
				String message = "Заказ оформлен!";
				System.out.println(message);
				session.setAttribute("PurchaseInfo", message);
				session.setAttribute("Catalog", catalog);
				request.getRequestDispatcher("UserPage.jsp").forward(request, response);
			}
			else {
				String message = "На складе нет такого количества следующих товаров: \n";
				for(String missmatch: missmatches) {
					message+=missmatch+", ";
				}
				System.out.println(message);
				session.setAttribute("PurchaseInfo", message);
				request.getRequestDispatcher("UserPage.jsp").forward(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
