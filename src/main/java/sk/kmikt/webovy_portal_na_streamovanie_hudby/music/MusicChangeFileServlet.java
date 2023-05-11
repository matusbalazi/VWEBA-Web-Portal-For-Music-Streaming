package sk.kmikt.webovy_portal_na_streamovanie_hudby.music;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.naming.NamingException;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.UUID;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,    // 1MB
        maxFileSize = 1024 * 1024 * 10,         // 10MB
        maxRequestSize = 1024 * 1024 * 100      // 100MB
)

@WebServlet(name = "MusicChangeFileServlet", value = "/music-change-file")
public class MusicChangeFileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "public";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try
        {
            int id = Integer.parseInt(request.getParameter("song_id"));
            String url = request.getParameter("url");

            String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIR;
            String newUrl = "";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
            {
                uploadDir.mkdir();
            }

            Collection<Part> parts = request.getParts();

            for (Part part : parts)
            {
                if (part.getName().equals("file"))
                {
                    String fileName = part.getSubmittedFileName();
                    String[] split = fileName.split("\\.");
                    String ext = split[split.length - 1];
                    String newFileName = UUID.randomUUID().toString() + "." + ext;
                    part.write(uploadPath + File.separator + newFileName);

                    newUrl = "/" + UPLOAD_DIR + "/" + newFileName;
                }
            }

            Music music = new Music(id, url);
            music.setUrl(newUrl);

            new MusicController().changeFile(music);

        }
        catch (SQLException | NamingException e)
        {
            throw new RuntimeException(e);
        }
        finally
        {
            response.sendRedirect("/music.jsp");
        }
    }
}
