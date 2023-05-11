<%@ page import="java.util.ArrayList"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.Music"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.music.MusicController"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!doctype html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <meta
            name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    >
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Music Page</title>
    <%@include file="header.jsp"%>
</head>
<body>

    <%@include file="navigation.jsp"%>

    <%
        if (session.getAttribute("name") != null &&
                session.getAttribute("login") != null &&
                session.getAttribute("is_admin") != null &&
                (boolean) session.getAttribute("is_admin"))
        {
            %>
                <div class="container mt-4">
                    <div class="row justify-content-center">
                        <div class="text-center">
                            <a class="btn btn-primary btn-lg btn-block m-1 mt-3 float-lg-end" href="insert_song.jsp">Pridať skladbu</a>
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
        ArrayList<Music> songs = new ArrayList<>();
        try
        {
            songs = new MusicController().getAllSongs();
        }
        catch (SQLException e)
        {
            throw new RuntimeException(e);
        }
        catch (NamingException e)
        {
            throw new RuntimeException(e);
        }
    %>

    <div class="container mt-4">
        <h1 class="text-center">Zoznam skladieb</h1>
        <table class="table table-striped table-bordered table-hover mt-3">
            <thead>
            <tr>
                <td class="text-secondary fw-bold">Názov</td>
                <td class="text-secondary fw-bold">Umelec</td>
                <td class="text-secondary fw-bold">Žáner</td>
                <td class="text-secondary fw-bold">Rok</td>
                <td class="text-secondary fw-bold">Skladba</td>
                <%
                    if (session.getAttribute("name") != null &&
                            session.getAttribute("login") != null &&
                            session.getAttribute("is_admin") != null &&
                            (boolean) session.getAttribute("is_admin"))
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
                                <%
                                    if (session.getAttribute("name") != null &&
                                            session.getAttribute("login") != null &&
                                            session.getAttribute("is_admin") != null &&
                                            (boolean) session.getAttribute("is_admin"))
                                    {
                                %>
                                    <td>
                                        <a class="btn btn-warning m-1" href="edit_song.jsp?song_id=<%=song.getSong_id()%>" role="button">EDIT</a>
                                        <a class="btn btn-danger m-1" href="/music-delete?song_id=<%=song.getSong_id()%>" role="button">DELETE</a>
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
</body>
</html>
