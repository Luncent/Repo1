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

@WebServlet("/DeleteProduct")
public class DeleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteProduct() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");		
		
		HttpSession session = request.getSession(false);

		
		int productId = Integer.parseInt(request.getParameter("productID"));
		int productTypeId = Integer.parseInt(request.getParameter("productTypeID"));
		Product.deleteProduct(productId);
		Catalog catalog = new Catalog();
		session.setAttribute("Catalog", catalog);
		
		switch(productTypeId) {
			case 1:
				response.sendRedirect("CardboardPage.jsp");
				break;
			case 2:
				response.sendRedirect("GluePage.jsp");
				break;
			case 3:
				response.sendRedirect("MembranaPage.jsp");
				break;
			case 4:
				response.sendRedirect("DrywallPage.jsp");
				break;
			case 5:
				response.sendRedirect("TapePage.jsp");
				break;
			default:
	                System.out.println("Некорректный выбор");
	                break;
		}
	}

}
