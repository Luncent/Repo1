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

//@WebServlet("/Filters")
public class Filters extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Filters() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		String type = request.getParameter("option");
		String costLeftLimit=request.getParameter("CostFrom");
		String costRightLimit=request.getParameter("CostTo");
		Double minCost = costLeftLimit.isEmpty()?0:Double.valueOf(costLeftLimit);
		Double maxCost = costRightLimit.isEmpty()?1000:Double.valueOf(costRightLimit);
		System.out.println(type+" "+minCost+"  "+maxCost);
		
		HttpSession session=request.getSession(false);
		
		Catalog catalog = (Catalog)session.getAttribute("Catalog");
		
		session.setAttribute("SelectedType", type);
		
		Double[] limits= {minCost,maxCost};
		session.setAttribute("CostLimits", limits);
		
        catalog.filterProductsByTypeAndCost(type, minCost, maxCost);
		
		request.getRequestDispatcher("UserPage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
