package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sk.kmikt.webovy_portal_na_streamovanie_hudby.user.User;
import sk.kmikt.webovy_portal_na_streamovanie_hudby.user.UserController;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "MusicUpdateServlet", value = "/music-update")
public class MusicUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try
        {
            int id = Integer.parseInt(request.getParameter("song_id"));
            String title = request.getParameter("title");
            String artist = request.getParameter("artist");
            String genre = request.getParameter("genre");
            Integer year = Integer.parseInt(request.getParameter("year"));
            boolean hidden = Boolean.parseBoolean(request.getParameter("is_hidden"));
            boolean downloadable = Boolean.parseBoolean(request.getParameter("is_downloadable"));

            Music music = new Music(id, title, artist, genre, year, hidden, downloadable);

            new MusicController().updateMusic(music);
        }
        catch (SQLException | NamingException e)
        {
            throw new RuntimeException(e);
        }
        finally
        {
            response.sendRedirect(request.getParameter("page"));
        }
    }
}
