package controler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Providers;

@WebServlet("/DeleteProvider")
public class DeleteProvider extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteProvider() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;");
		response.setCharacterEncoding("UTF-8");		
		
		int providerId = Integer.parseInt(request.getParameter("providerID"));
		Providers.deleteProvider(providerId);
		
		response.sendRedirect("ProvidersPage.jsp");
	}

}
