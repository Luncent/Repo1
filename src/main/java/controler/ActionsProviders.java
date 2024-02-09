package controler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Catalog;
import model.Product;
import model.Providers;

//@WebServlet("/ActionsProviders")
public class ActionsProviders extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ActionsProviders() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		
		
		int providerId = Integer.parseInt(request.getParameter("providerID"));
		String name=request.getParameter("name");
		Providers.editProviderName(providerId, name);
		
		response.sendRedirect("ProvidersPage.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		
		int productId = Integer.parseInt(request.getParameter("productID"));
		int productTypeId = Integer.parseInt(request.getParameter("productTypeID"));
		int providerId = Integer.parseInt(request.getParameter("providerID"));
		String coststr=request.getParameter("cost");
		
//		PrintWriter out = response.getWriter();
//		out.println(type+" "+layers+" "+length+" "+area+" "+cost+" "+left);
		
		if(coststr==null  || coststr.isEmpty() || coststr.equals("0")) {
			System.out.println("Для изменения указаны некорректные данные");
			response.sendRedirect("ProvidersPage.jsp");
		}
		else {
			//проверки на неккоректный ввод
			boolean b2 = coststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");

			
			if(b2) {
				System.out.println("Некоректные данные");
				response.sendRedirect("ProvidersPage.jsp");
			}
			else {
				double cost = Double.parseDouble(coststr);
				Providers.editProviderCost(providerId, productId, productTypeId, cost);
				
				response.sendRedirect("ProvidersPage.jsp");
			}
		}
	}

}
