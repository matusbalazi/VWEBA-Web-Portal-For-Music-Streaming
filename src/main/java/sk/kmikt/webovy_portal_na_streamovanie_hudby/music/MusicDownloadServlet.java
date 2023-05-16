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

@WebServlet(name = "MusicDownloadServlet", value = "/music-download")
public class MusicDownloadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       try
       {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            int songId = Integer.parseInt(request.getParameter("song_id"));

            User user = new User(userId);
            Music music = new Music(songId);

            if (new MusicController().getDownloadedMusicById(user, music) == null)
            {
                if ((new MusicController().insertDownloadedMusic(user, music)))
                {
                    return;
                }
            }
            else
            {
                if ((new MusicController().updateDownloadedMusic(user, music)))
                {
                    return;
                }
            }
       }
       catch (NumberFormatException e)
       {
           e.printStackTrace();
       }
       catch (SQLException | NamingException e) {
           throw new RuntimeException(e);
       }
    }
}
