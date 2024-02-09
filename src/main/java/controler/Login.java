package controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Catalog;
import model.Product;
import model.User;

//@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Login() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		String login=request.getParameter("login");
		String password=request.getParameter("password");
		ArrayList<String>productsTypes=new ArrayList<>();
		HttpSession session=null;
		
		boolean contains1 = Pattern.matches(".*[^a-zA-Z0-9].*", login);
		boolean contains2 = Pattern.matches(".*[^a-zA-Z0-9].*", password);
		
		if(contains1 || contains2) {
			System.out.println("неверный формат!");
			response.sendRedirect("LoginPage.html");
		}
		else {
		if(login.isEmpty() || login==null || password.isEmpty() || password==null) {
			request.getRequestDispatcher("LoginPage.html").forward(request, response);
		}
		
		session=request.getSession();
		System.out.println("Сессия 1-"+session.getId());
		System.out.println("          ");
		
		User possibleUser=new User(login,password);
		if(possibleUser.tryLogin()) {
			if(possibleUser.getUserRole().equals("user")) {
				System.out.println("Входит пользователь");
				User user = new User(login,password,true);
				session.setAttribute("User",user);
				Catalog catalog = new Catalog();
				session.setAttribute("Catalog", catalog);
				request.getRequestDispatcher("UserPage.jsp").forward(request, response);
			}
			if(possibleUser.getUserRole().equals("admin")) {
				System.out.println("Входит admin");
				User user = new User(login,password,true);
				session.setAttribute("User",user);
				Catalog catalog = new Catalog();
				session.setAttribute("Catalog", catalog);
				request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
			}
		}
		else {
			response.sendRedirect("LoginPage.html");
		}
		
		out.close(); 
		}
	}

}
