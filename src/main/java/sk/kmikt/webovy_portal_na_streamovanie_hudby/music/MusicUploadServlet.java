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

@WebServlet(name = "MusicUploadServlet", value = "/music-upload")
public class MusicUploadServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "public";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String songTitle = request.getParameter("title");
            String songArtist = request.getParameter("artist");
            String songGenre = request.getParameter("genre");
            Integer songYear = Integer.parseInt(request.getParameter("year"));
            boolean songIsDownloadable = Boolean.parseBoolean(request.getParameter("is_downloadable"));
            String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIR;
            String url = "";

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

                    url = "/" + UPLOAD_DIR + "/" + newFileName;
                }
            }

            String uploadedBy = request.getParameter("login");

            if (new MusicController().insertMusic(new Music(songTitle, songArtist, songGenre, songYear, songIsDownloadable, url, uploadedBy)))
            {
                response.sendRedirect("/music.jsp");
            }
        }
        catch (NumberFormatException e)
        {
            e.printStackTrace();
        }
        catch (Exception e)
        {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
