package sk.kmikt.webovy_portal_na_streamovanie_hudby.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UserLogoutServlet", value = "/user-logout")
public class UserLogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("name") != null && session.getAttribute("login") != null) {
            session.invalidate();
            response.sendRedirect("/login.jsp");
        }
    }
}
