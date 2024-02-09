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
import model.User;

//@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Register() {
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
		String password1=request.getParameter("password1");
		String password2=request.getParameter("password2");
		ArrayList<String>productsTypes=new ArrayList<>();
		HttpSession session=null;
		
		 boolean contains1 = Pattern.matches(".*[^a-zA-Z0-9].*", login);
		 boolean contains2 = Pattern.matches(".*[^a-zA-Z0-9].*", password1);
		
		if(login.isEmpty() || login==null || password1.isEmpty() || password1==null
				|| password2.isEmpty() || password2==null || contains1 || contains2) {
			System.out.println("Все поля должны быть заполнены!");
			response.sendRedirect("Registration.jsp");
			return;
		}
		
		if(!password1.equals(password2)) {
			out.println("Пароли не совпадают!");
			System.out.println("Пароли не совпадают!");
			response.sendRedirect("Registration.jsp");
			return;
		}
		
		User possibleUser=new User(login,password1);
		if(possibleUser.checkLogin(login)) {
			out.println("Пользователь с таким именем существует!");
			System.out.println("Пользователь с таким именем есть!");
			response.sendRedirect("Registration.jsp");
			return;
		}
		else {
			possibleUser.createUser(login, password1);//создание пользователя в бд
			
			session=request.getSession();
			System.out.println("Сессия 1-"+session.getId());
			System.out.println("          ");
			
			User user=new User(login,password1,true); // получаем созданного пользователя
			
			session.setAttribute("User",user);
			Catalog catalog = new Catalog();
			session.setAttribute("Catalog", catalog);
			request.getRequestDispatcher("UserPage.jsp").forward(request, response);
		}
	}

}
