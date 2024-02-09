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

//@WebServlet("/AddGlue")
public class AddGlue extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddGlue() {
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
		String providerName=request.getParameter("option");
		if(providerName.equals("empty")) {
			System.out.println("нет поставщика");
			response.sendRedirect("CardboardPage.jsp");
		}
	  else {
		String providerCoststr=request.getParameter("providerCost");
		String type = request.getParameter("productType");
		String volumestr=request.getParameter("volume");
		String coststr=request.getParameter("cost");
		String leftstr=request.getParameter("number");
		
	//	PrintWriter out = response.getWriter();
		//out.println(type+" "+layers+" "+length+" "+area+" "+cost+" "+left);
		if(type==null || volumestr==null || coststr==null || leftstr==null ||type.isEmpty() || volumestr.isEmpty() || coststr.isEmpty() || leftstr.isEmpty()|| volumestr.equals("0") || coststr.equals("0")||providerCoststr.isEmpty()||providerCoststr.equals("0")) {
			System.out.println("Для добавления нет/не хватает данных");
			response.sendRedirect("GluePage.jsp");
		}
		else {
			//проверки на неккоректный ввод
			boolean b1 = volumestr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b2 = coststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b3 = leftstr.matches(".*[^0-9].*");
			boolean b4 = providerCoststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			
			if(b1||b2||b3||b4) {
				System.out.println("Некоректные данные");
				response.sendRedirect("GluePage.jsp");
			}
			else {
				double volume = Double.parseDouble(volumestr);
				double cost = Double.parseDouble(coststr);
				int left= Integer.parseInt(leftstr);
				double providerCost = Double.parseDouble(providerCoststr);
				String properties = "объем:"+volume;
				Product.insertProduct("клей",type,properties,cost,left,providerCost,providerName);
				Catalog catalog = new Catalog();
				session.setAttribute("Catalog", catalog);
				response.sendRedirect("GluePage.jsp");
			}
		}
	}
 }

}
