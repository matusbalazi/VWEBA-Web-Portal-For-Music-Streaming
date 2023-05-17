package sk.kmikt.webovy_portal_na_streamovanie_hudby.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserLoginServlet", value = "/user-login")
public class UserLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("email");
        String password = request.getParameter("password");
        boolean isAdmin = Boolean.parseBoolean(request.getParameter("is_admin"));
        HttpSession session = request.getSession();

        try {
            User user = (new UserController()).verifyLogin(login, password);
            if (user != null) {
                session.setAttribute("name", user.getName());
                session.setAttribute("login", user.getEmail());
                session.setAttribute("is_admin", user.isIs_admin());
                response.sendRedirect("/index.jsp?success_login=true");
            }
            else {
                response.sendRedirect("/login.jsp?success_login=false");
            }
        } catch (NamingException | SQLException var7) {
            response.sendRedirect("/login.jsp");
            var7.printStackTrace();
        }
    }
}
