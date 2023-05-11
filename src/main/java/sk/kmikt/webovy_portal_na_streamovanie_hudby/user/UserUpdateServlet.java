package sk.kmikt.webovy_portal_na_streamovanie_hudby.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "UserUpdateServlet", value = "/user-update")
public class UserUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try
        {
            int id = Integer.parseInt(request.getParameter("user_id"));
            String name = request.getParameter("name");
            String dateString = request.getParameter("dob");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = dateFormat.parse(dateString);
            String email = request.getParameter("email");

            User user = new User(id, name, date, email);

            new UserController().updateUser(user);

        }
        catch (SQLException | NamingException | ParseException e)
        {
            throw new RuntimeException(e);
        }
        finally
        {
            response.sendRedirect("/all_users.jsp");
        }
    }
}
