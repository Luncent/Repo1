package controler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Catalog;

//@WebServlet("/SortCatalog")
public class SortCatalog extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SortCatalog() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		HttpSession session=request.getSession(false);
		String cheap = request.getParameter("checkboxCheap");
		String expensive = request.getParameter("checkboxExpensive");
		Catalog catalog = (Catalog)session.getAttribute("Catalog");
		String[] checkBoxes = {cheap, expensive};
		
		session.setAttribute("CheckBoxes", checkBoxes);
		
		if(cheap!=null && expensive!=null) {
			System.out.println("1 не ноль и 2 не ноль");
			request.getRequestDispatcher("UserPage.jsp").forward(request, response);
		}
		if(cheap==null && expensive==null) {
			System.out.println("1 и 2 ноль");
			request.getRequestDispatcher("UserPage.jsp").forward(request, response);
		}
		if(cheap!=null && expensive==null) {
			catalog.ascendingSort();
			System.out.println("1 не ноль");
			request.getRequestDispatcher("UserPage.jsp").forward(request, response);
		}
		if(expensive!=null && cheap==null) {
			catalog.decreasingSort();
			System.out.println("2 не ноль");
			request.getRequestDispatcher("UserPage.jsp").forward(request, response);
		}
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
