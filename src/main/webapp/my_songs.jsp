<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.Music"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.MusicController"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.Comparator"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.MusicURLDecoder"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.user.UserController"%>
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
  <title>My Songs Page</title>
  <%@include file="header.jsp"%>
</head>
<body>

<%@include file="navigation.jsp"%>

<%
  if (session.getAttribute("name") != null &&
          session.getAttribute("login") != null)
  {
%>
<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="text-center">
      <a class="btn btn-primary btn-lg btn-block m-1 mt-3 float-lg-end" href="insert_song.jsp?page=2">Pridať skladbu</a>
    </div>
  </div>
</div>
<%
  }
%>

<style>
  table {
    font-size: 18px;
    margin-bottom: 50px;
  }
  th {
    background-color: #428bca;
    color: white;
    text-align: center;
    font-weight: bold;
    padding: 10px;
    vertical-align: middle;
  }
  td {
    font-size: 18px;
    text-align: center;
    vertical-align: middle;
    padding: 10px;
  }
  audio {
    display: block;
    margin: 0 auto;
  }
</style>

<%
  int currentUserId;
  ArrayList<Music> songs = new ArrayList<>();

  if (session.getAttribute("name") != null &&
          session.getAttribute("login") != null)
  {

  try
  {
    songs = new MusicController().getAllSongs();

    String currentUser = (String) session.getAttribute("login");
    currentUserId = new UserController().getUserByEmail(currentUser).getUser_id();

    songs.removeIf(song -> !song.getUploaded_by().equals(currentUser));

    Collections.sort(songs, Comparator.comparing(Music::getTitle));
  }
  catch (SQLException | NamingException e)
  {
    throw new RuntimeException(e);
  }
%>

<div class="container mt-4">
  <h1 class="text-center">Zoznam mojich skladieb</h1>
  <table class="table table-striped table-bordered table-hover mt-3">
    <thead>
    <tr>
      <td class="text-secondary fw-bold">Názov</td>
      <td class="text-secondary fw-bold">Umelec</td>
      <td class="text-secondary fw-bold">Žáner</td>
      <td class="text-secondary fw-bold">Rok</td>
      <td class="text-secondary fw-bold">Skladba</td>
      <td class="text-secondary fw-bold">Stiahnuť skladbu</td>
      <%
        if (session.getAttribute("name") != null &&
                session.getAttribute("login") != null)
        {
      %>
      <td class="text-secondary fw-bold">Upraviť/Vymazať</td>
      <%
        }
      %>
    </tr>
    </thead>
    <tbody>
    <%
      for (Music song: songs)
      {
    %>
    <tr>
      <td><%=song.getTitle()%></td>
      <td><%=song.getArtist()%></td>
      <td><%=song.getGenre()%></td>
      <td><%=song.getYear()%></td>
      <td>
        <audio controls controlsList="nodownload">
          <source src="<%=song.getUrl()%>" type="audio/mpeg">
          <source src="<%=song.getUrl()%>" type="audio/wav">
        </audio>
      </td>
      <td>
        <%
          if (song.isIs_downloadable())
          {
        %>
        <a class="btn btn-link m-1" onclick="runMusicDownloadServlet(<%=currentUserId%>, <%=song.getSong_id()%>)" href="<%=song.getUrl()%>" download="<%=song.getTitle() + "." + new MusicURLDecoder().decode(song.getUrl())%>">STIAHNUŤ</a>
        <%
        }
        else
        {
        %>
        Nie je dostupné
        <%
          }
        %>
      </td>
      <%
        if (session.getAttribute("name") != null &&
                session.getAttribute("login") != null)
        {
      %>
      <td>
        <a class="btn btn-warning m-1" href="edit_song.jsp?song_id=<%=song.getSong_id()%>&page=2" role="button">EDIT</a>
        <a class="btn btn-danger m-1" href="/music-delete?song_id=<%=song.getSong_id()%>&page=2" role="button">DELETE</a>
      </td>
      <%
        }
      %>
    </tr>
    <%
          }
    %>
    </tbody>
  </table>
</div>
<%
  }
%>
</body>

<script>
  function runMusicDownloadServlet(user_id, song_id) {
    var url = "/music-download?user_id=" + user_id + "&song_id=" + song_id;
    fetch(url)
            .then(function(response) {
              console.log("Servlet bol úspešne spustený.");
            })
            .catch(function(error) {
              console.log("Vyskytla sa chyba pri spúšťaní Servletu: " + error.message);
            });
  }
</script>

</body>
</html>
