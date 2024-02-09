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

//@WebServlet("/EditGlue")
public class EditGlue extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EditGlue() {
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
		String volumestr=request.getParameter("volume");
		String coststr=request.getParameter("cost");
		String leftstr=request.getParameter("number");
		
	//	PrintWriter out = response.getWriter();
		//out.println(type+" "+layers+" "+length+" "+area+" "+cost+" "+left);
		if(type==null || volumestr==null || coststr==null || leftstr==null ||type.isEmpty() || volumestr.isEmpty() || coststr.isEmpty() || leftstr.isEmpty()|| volumestr.equals("0") || coststr.equals("0")) {
			System.out.println("Для изменения нет/не хватает данных");
			response.sendRedirect("GluePage.jsp");
		}
		else {
			//проверки на неккоректный ввод
			boolean b1 = volumestr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b2 = coststr.matches(".*[^0-9.].*|.*\\..*[^0-9].*");
			boolean b3 = leftstr.matches(".*[^0-9].*");
			
			if(b1||b2||b3) {
				System.out.println("Некоректные данные при изменении");
				response.sendRedirect("GluePage.jsp");
			}
			else {
				double volume = Double.parseDouble(volumestr);
				double cost = Double.parseDouble(coststr);
				int left= Integer.parseInt(leftstr);
				String properties = "объем:"+volume;
				Product.editProduct(type, properties,cost,left,id,2);
				Catalog catalog = new Catalog();
				session.setAttribute("Catalog", catalog);
				
				response.sendRedirect("GluePage.jsp");
			}
		}
		
//		PrintWriter out = response.getWriter();
//		out.println(type+" "+layers+" "+length+" "+area+" "+cost+" "+left);
		
		
		
	}

}
