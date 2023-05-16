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
  <title>Edit Song Page</title>
  <%@include file="header.jsp"%>
</head>
<body>

<%@include file="navigation.jsp"%>

<%
  Music song = null;
  int id = Integer.parseInt(request.getParameter("song_id"));
  int pageID = Integer.parseInt(request.getParameter("page"));
  String returnPage;

  if (pageID == 1)
  {
    returnPage = "music.jsp";
  }
  else
  {
    returnPage = "my_songs.jsp";
  }

  try
  {
    song = new MusicController().getMusicById(id);
  }
  catch (SQLException | NamingException e)
  {
    throw new RuntimeException(e);
  }
%>

<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <div class="text-center">
        <a class="btn btn-light btn-lg btn-block mt-3 float-lg-end" href="change_file.jsp?song_id=<%=song.getSong_id()%>&page=<%=pageID%>">Zmeniť zvukový súbor</a>
      </div>
    </div>
  </div>
</div>

<div class="container-fluid mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <div class="text-center">
        <h1>Editačný formulár</h1>
      </div>
    </div>
  </div>
</div>
<div class="container mt-3">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <form action="/music-update?song_id=<%=id%>&page=<%=returnPage%>" id="edit-song-form" method="post">
        <div class="form-group mt-1">
          <label for="title" class="form-label">Názov:</label>
          <input type="text" class="form-control" id="title" name="title" value="<%=song.getTitle()%>" required>
        </div>
        <div class="form-group mt-3">
          <label for="artist" class="form-label">Interpret:</label>
          <input type="text" class="form-control" id="artist" name="artist" value="<%=song.getArtist()%>" required>
        </div>
        <div class="form-group mt-3">
          <label for="genre" class="form-label">Žáner:</label>
          <select class="form-control" id="genre" name="genre" required>
            <option value="">-- Vyberte žáner --</option>
            <%
              if (song.getGenre().equals("country"))
              {
                %>
                  <option value="country" selected>Country</option>
                <%
              }
              else
              {
                %>
                  <option value="country">Country</option>
                <%
              }
              if (song.getGenre().equals("heavy metal"))
              {
            %>
            <option value="heavy metal" selected>Heavy metal</option>
            <%
            }
            else
            {
            %>
            <option value="heavy metal">Heavy metal</option>
            <%
              }
            if (song.getGenre().equals("jazz"))
            {
            %>
            <option value="jazz" selected>Jazz</option>
            <%
              }
              else
              {
            %>
            <option value="jazz">Jazz</option>
            <%
              }
            if (song.getGenre().equals("pop"))
            {
            %>
            <option value="pop" selected>Pop</option>
            <%
              }
              else
              {
            %>
            <option value="pop">Pop</option>
            <%
              }
            if (song.getGenre().equals("punk"))
            {
            %>
            <option value="punk" selected>Punk</option>
            <%
              }
              else
              {
            %>
            <option value="punk">Punk</option>
            <%
              }
            if (song.getGenre().equals("rock"))
            {
            %>
            <option value="rock" selected>Rock</option>
            <%
              }
              else
              {
            %>
            <option value="rock">Rock</option>
            <%
              }
            if (song.getGenre().equals("other"))
            {
            %>
            <option value="other" selected>Iné</option>
            <%
              }
              else
              {
            %>
            <option value="other">Iné</option>
            <%
              }
            %>
          </select>
        </div>
        <div class="form-group mt-3">
          <label for="year" class="form-label">Rok vydania:</label>
          <input type="number" class="form-control" id="year" name="year" min="1950" max="2023" value="<%=song.getYear()%>" required>
        </div>
        <div class="form-group form-check mt-3">
          <input type="checkbox" class="form-check-input" id="is_hidden" name="is_hidden" <%if (song.isIs_hidden()) {%>checked<%}%>>
          <label class="form-check-label" for="is_hidden">Skryť skladbu pred ostatnými používateľmi</label>
        </div>
        <div class="form-group form-check mt-3">
          <input type="checkbox" class="form-check-input" id="is_downloadable" name="is_downloadable" <%if (song.isIs_downloadable()) {%>checked<%}%>>
          <label class="form-check-label" for="is_downloadable">Povoliť stiahnutie skladby ostatnými používateľmi</label>
        </div>
        <div class="mt-3">
          <button type="submit" class="btn btn-primary btn-lg m-1 mt-3">Zmeniť</button>
          <a class="btn btn-link btn-lg m-1 mt-3 float-lg-end" href=<%=returnPage%>>Späť</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    // Get the initial value of the "is_hidden" checkbox
    var initialValue = $('#is_hidden').is(':checked');

    // Set the value of the "is_hidden" input field based on the initial value
    $('input[name="is_hidden"]').val(initialValue ? 'true' : 'false');
  });

  $(document).ready(function() {
    // Get the initial value of the "is_hidden" checkbox
    var initialValue = $('#is_downloadable').is(':checked');

    // Set the value of the "is_hidden" input field based on the initial value
    $('input[name="is_downloadable"]').val(initialValue ? 'true' : 'false');
  });

  $(document).ready(function () {
    $('#is_hidden').on('change', function () {
      $('input[name="is_hidden"]').val($(this).is(':checked') ? 'true' : 'false');
    });
  });

  $(document).ready(function () {
    $('#is_downloadable').on('change', function () {
      $('input[name="is_downloadable"]').val($(this).is(':checked') ? 'true' : 'false');
    });
  });

  $(document).ready(function() {
    $("#edit-song-form").validate({
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
        }
      }
    });
  });

</script>

</body>
</html>
