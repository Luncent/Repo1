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

//@WebServlet("/ActionsTape")
public class ActionsTape extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ActionsTape() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		
		String type = request.getParameter("productType");
		
		String providerName=request.getParameter("option");
		if(providerName.equals("empty")) {
			System.out.println("нет поставщика");
			response.sendRedirect("TapePage.jsp");
		}
		else {
		String providerCoststr=request.getParameter("providerCost");
		String coststr=request.getParameter("cost");
		String leftstr=request.getParameter("number");
		String widthstr=request.getParameter("width");
		String lengthstr=request.getParameter("length");
		
	//	PrintWriter out = response.getWriter();
		//out.println(type+" "+layers+" "+length+" "+area+" "+cost+" "+left);
		if(type==null || widthstr==null || lengthstr==null || coststr==null || leftstr==null
				||type.isEmpty() || widthstr.isEmpty() || lengthstr.isEmpty() || coststr.isEmpty() ||
				leftstr.isEmpty()|| widthstr.equals("0") || coststr.equals("0")|| lengthstr.equals("0")||
				providerCoststr.isEmpty()||providerCoststr.equals("0")) {
			
			System.out.println("Для добавления нет/не хватает данных"+widthstr);
			response.sendRedirect("TapePage.jsp");
		}
		else {
			//проверки на неккоректный ввод
			boolean b1 = widthstr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b2 = coststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b3 = lengthstr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b4 = leftstr.matches(".*[^0-9].*");
			boolean b6 = providerCoststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			
			if(b1||b2||b3||b4||b6) {
				System.out.println("Некоректные данные");
				response.sendRedirect("TapePage.jsp");
			}
			else {
				double length = Double.parseDouble(lengthstr);
				double width = Double.parseDouble(widthstr);
				double cost = Double.parseDouble(coststr);
				double providerCost = Double.parseDouble(providerCoststr);
				int left= Integer.parseInt(leftstr);
				System.out.println(providerName);
				String properties="длина:"+length+",ширина:"+width; 
				Product.insertProduct("лента",type,properties,cost,left,providerCost,providerName);
				Catalog catalog = new Catalog();
				session.setAttribute("Catalog", catalog);
	
				response.sendRedirect("TapePage.jsp");
			}
		}
	}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		
		int id = Integer.parseInt(request.getParameter("productID"));
		String type = request.getParameter("type");
		String coststr=request.getParameter("cost");
		String leftstr=request.getParameter("number");
		String widthstr=request.getParameter("width");
		String lengthstr=request.getParameter("length");
		
//		PrintWriter out = response.getWriter();
//		out.println(type+" "+layers+" "+length+" "+area+" "+cost+" "+left);
		
		if(type==null || widthstr==null || lengthstr==null || coststr==null || leftstr==null ||type.isEmpty()
				|| widthstr.isEmpty() || lengthstr.isEmpty() ||
				coststr.isEmpty() || leftstr.isEmpty()|| widthstr.equals("0") ||
				coststr.equals("0")|| lengthstr.equals("0")) {
			
			System.out.println("Для изменения указаны некорректные данные");
			response.sendRedirect("TapePage.jsp");
		}
		else {
			//проверки на неккоректный ввод
			boolean b1 = widthstr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b2 = coststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b3 = lengthstr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b4 = leftstr.matches(".*[^0-9].*");
			
			if(b1||b2||b3||b4) {
				System.out.println("Некоректные данные");
				response.sendRedirect("TapePage.jsp");
			}
			else {
				double length = Double.parseDouble(lengthstr);
				double width = Double.parseDouble(widthstr);
				double cost = Double.parseDouble(coststr);
				int left= Integer.parseInt(leftstr);
				String properties="длина:"+length+",ширина:"+width; 
				Product.editProduct(type, properties,cost,left,id,5);
				Catalog catalog = new Catalog();
				session.setAttribute("Catalog", catalog);
				
				response.sendRedirect("TapePage.jsp");
			}
		}
	}

}
