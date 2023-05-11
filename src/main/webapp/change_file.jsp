<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.Music"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.MusicController"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!doctype html>
<html lang="sk">
<head>
  <meta charset="UTF-8">
  <meta
          name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
  >
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Change File Page</title>
  <%@include file="header.jsp"%>
</head>
<body>

<%@include file="navigation.jsp"%>

<%
  Music song = null;
  int id = Integer.parseInt(request.getParameter("song_id"));

  try
  {
    song = new MusicController().getMusicById(id);
  }
  catch (SQLException | NamingException e)
  {
    throw new RuntimeException(e);
  }
%>

<div class="container-fluid mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <div class="text-center">
        <h1>Zmena zvukového súboru</h1>
      </div>
    </div>
  </div>
</div>

<div class="container mt-3">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <form action="/music-change-file?song_id=<%=id%>" id="change-file-form" method="post" enctype="multipart/form-data">
        <div class="form-group mt-3">
          <label for="file" class="form-label">Vyberte zvukový súbor:</label>
          <input type="file" class="form-control-file" id="file" name="file" accept="audio/mpeg, audio/wav" required><br>
          <small id="emailHelp" class="form-text text-muted">Podporované formáty: mp3, wav.</small>
        </div>
        <div class="mt-3">
          <button type="submit" class="btn btn-primary btn-lg m-1 mt-3">Zmeniť</button>
          <a class="btn btn-link btn-lg m-1 mt-3 float-lg-end" href="edit_song.jsp?song_id=<%=song.getSong_id()%>">Späť</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    $("#change-file-form").validate({
      rules: {
        file: {
          required: true,
          extension: "mp3|wav",
          accept: "audio/mpeg, audio/wav"
        }
      },
      messages: {
        file: {
          required: "Prosím, vyberte audio súbor na nahranie.",
          extension: "Audio súbor musí byť vo formáte MP3 alebo WAV.",
          accept: "Audio súbor musí byť vo formáte MP3 alebo WAV."
        }
      }
    });
  });
</script>

</body>
</html>
