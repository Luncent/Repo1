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
import model.Product;

//@WebServlet("/EditCardboard")
public class EditCardboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EditCardboard() {
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
		
		int id = Integer.parseInt(request.getParameter("productID"));
		String type = request.getParameter("type");
		String layersstr=request.getParameter("layers");
		String coststr=request.getParameter("cost");
		String leftstr=request.getParameter("number");
		String areastr=request.getParameter("area");
		String lengthstr=request.getParameter("length");
		
//		PrintWriter out = response.getWriter();
//		out.println(type+" "+layers+" "+length+" "+area+" "+cost+" "+left);
		
		if(type==null || layersstr==null || areastr==null || lengthstr==null || coststr==null || leftstr==null ||type.isEmpty() || areastr.isEmpty() || lengthstr.isEmpty() || layersstr.isEmpty() || coststr.isEmpty() || leftstr.isEmpty()|| areastr.equals("0") || coststr.equals("0")|| lengthstr.equals("0")||layersstr.equals("0")) {
			System.out.println("Для изменения указаны некорректные данные");
			response.sendRedirect("CardboardPage.jsp");
		}
		else {
			//проверки на неккоректный ввод
			boolean b1 = areastr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b2 = coststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b3 = lengthstr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b4 = leftstr.matches(".*[^0-9].*");
			boolean b5 = layersstr.matches(".*[^0-9].*");
			
			if(b1||b2||b3||b4||b5) {
				System.out.println("Некоректные данные");
				response.sendRedirect("CardboardPage.jsp");
			}
			else {
				int layers = Integer.parseInt(layersstr);
				double length = Double.parseDouble(lengthstr);
				double area = Double.parseDouble(areastr);
				double cost = Double.parseDouble(coststr);
				int left= Integer.parseInt(leftstr);
				String properties="кол-во слоев:"+layers+",длина:"+length+",площадь:"+area; 
				Product.editProduct(type, properties,cost,left,id,1);
				Catalog catalog = new Catalog();
				session.setAttribute("Catalog", catalog);
				
				response.sendRedirect("CardboardPage.jsp");
			}
		}
		
	}

}
