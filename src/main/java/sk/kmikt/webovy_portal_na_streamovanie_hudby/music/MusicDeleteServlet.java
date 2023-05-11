package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sk.kmikt.webovy_portal_na_streamovanie_hudby.user.UserController;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "MusicDeleteServlet", value = "/music-delete")
public class MusicDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("song_id"));

        try
        {
            new MusicController().deleteMusic(id);
        }
        catch (SQLException | NamingException e)
        {
            throw new RuntimeException(e);
        }
        finally {
            response.sendRedirect("/music.jsp");
        }
    }
}
