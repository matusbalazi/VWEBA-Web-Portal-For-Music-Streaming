package sk.kmikt.webovy_portal_na_streamovanie_hudby.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;

@WebServlet(name = "UserChangePasswordServlet", value = "/user-change-password")
public class UserChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("user_id"));

        try {
            String current_password = request.getParameter("current_password");
            String new_password = request.getParameter("new_password");

            System.out.println("Current password: " + current_password);
            System.out.println("New password " + new_password);
            System.out.println("Hashed password: " + new UserController().getUserById(id).getPassword());

            if (BCrypt.checkpw(current_password, new UserController().getUserById(id).getPassword()))
            {
                User user = new User(id, new_password);

                String encodedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
                user.setPassword(encodedPassword);

                new UserController().changePassword(user);
            }
        }
        catch (Exception e)
        {
            throw new RuntimeException(e);
        }
        finally
        {
            response.sendRedirect("/all_users.jsp");
        }

    }
}
