<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.Music"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.MusicController"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.Comparator"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.user.UserController"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.MusicURLDecoder"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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
    <title>Downloaded Songs Page</title>
    <%@include file="header.jsp"%>
</head>
<body>

<%@include file="navigation.jsp"%>

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
    String dateFormat = "dd.MM.yyyy";
    DateFormat df = new SimpleDateFormat(dateFormat);
    int currentUserId;
    ArrayList<Music> songs = new ArrayList<>();

    if (session.getAttribute("name") != null &&
            session.getAttribute("login") != null)
    {

    try
    {
        String currentUser = (String) session.getAttribute("login");
        currentUserId = new UserController().getUserByEmail(currentUser).getUser_id();

        songs = new MusicController().getAllDownloadedSongs(currentUserId);

        Collections.sort(songs, Comparator.comparing(Music::getTitle));
    }
    catch (SQLException | NamingException e)
    {
        throw new RuntimeException(e);
    }
%>

<div class="container mt-4">
    <h1 class="text-center">Zoznam stiahnutých skladieb</h1>
    <table class="table table-striped table-bordered table-hover mt-3">
        <thead>
        <tr>
            <td class="text-secondary fw-bold">Názov</td>
            <td class="text-secondary fw-bold">Umelec</td>
            <td class="text-secondary fw-bold">Žáner</td>
            <td class="text-secondary fw-bold">Rok</td>
            <td class="text-secondary fw-bold">Skladba</td>
            <td class="text-secondary fw-bold">Dátum stiahnutia</td>
        </tr>
        </thead>
        <tbody>
        <%
            for (Music song: songs)
            {
                Date dod = null;
                try {
                    dod = new MusicController().getDownloadedMusicDoD(currentUserId, song);
                } catch (SQLException | NamingException e) {
                    throw new RuntimeException(e);
                }
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
                <%=df.format(dod)%>
            </td>
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
</html>
