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

    <div class="container-fluid mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="text-center">
                    <h1>Nahrávanie hudby</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-3">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <form action="/music-upload" id="music-form" method="post" enctype="multipart/form-data">
                    <div class="form-group mt-1">
                        <label for="title" class="form-label">Názov:</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="form-group mt-3">
                        <label for="artist" class="form-label">Interpret:</label>
                        <input type="text" class="form-control" id="artist" name="artist" required>
                    </div>
                    <div class="form-group mt-3">
                        <label for="genre" class="form-label">Žáner:</label>
                        <select class="form-control" id="genre" name="genre" required>
                            <option value="">-- Vyberte žáner --</option>
                            <option value="country">Country</option>
                            <option value="heavy_metal">Heavy metal</option>
                            <option value="jazz">Jazz</option>
                            <option value="pop">Pop</option>
                            <option value="punk">Punk</option>
                            <option value="rock">Rock</option>
                            <option value="other">Iné</option>
                        </select>
                    </div>
                    <div class="form-group mt-3">
                        <label for="year" class="form-label">Rok vydania:</label>
                        <input type="number" class="form-control" id="year" name="year" min="1950" max="2023" required>
                    </div>
                    <div class="form-group mt-3">
                        <label for="file" class="form-label">Vyberte zvukový súbor:</label>
                        <input type="file" class="form-control-file" id="file" name="file" accept="audio/mpeg, audio/wav" required><br>
                        <small id="emailHelp" class="form-text text-muted">Podporované formáty: mp3, wav.</small>
                    </div>
                    <div class="text-center mt-3">
                        <button type="submit" class="btn btn-primary">Nahrať</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <style>
        table {
            font-size: 16px;
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
                <td>Názov</td>
                <td>Umelec</td>
                <td>Žáner</td>
                <td>Rok</td>
                <td>Skladba</td>
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
                            </tr>
                        <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <script>

        $(document).ready(function() {
            $("#music-form").validate({
                rules: {
                    title: {
                        required: true,
                        maxlength: 30
                    },
                    artist: {
                        required: true,
                        maxlength: 30
                    },
                    genre: {
                        required: true
                    },
                    year: {
                        required: true,
                        min: 1950,
                        max: 2023
                    },
                    file: {
                        required: true,
                        extension: "mp3|wav",
                        accept: "audio/mpeg, audio/wav"
                    }
                },
                messages: {
                    title: {
                        required: "Prosím, zadajte názov skladby.",
                        maxlength: "Názov skladby musí byť kratší alebo rovný 30 znakom."
                    },
                    artist: {
                        required: "Prosím, zadajte meno autora.",
                        maxlength: "Meno autora musí byť kratšie alebo rovné 30 znakom."
                    },
                    genre: {
                        required: "Prosím, vyberte žáner skladby."
                    },
                    year: {
                        required: "Prosím, zadajte rok vydania skladby.",
                        min: "Rok vydania skladby musí byť po roku 1950.",
                        max: "Rok vydania skladby nemôže byť v budúcnosti."
                    },
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
