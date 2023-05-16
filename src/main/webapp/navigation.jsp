<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.user.User"%>
<%@ page pageEncoding="UTF-8" language="java"%>
<!doctype html>
<html lang="sk">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta
            name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    >
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="index.jsp">Webový portál</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <%
                if (session.getAttribute("name") != null &&
                        session.getAttribute("login") != null &&
                        session.getAttribute("is_admin") != null &&
                        (boolean) session.getAttribute("is_admin"))
                {
              %>
              <a class="nav-link" href="/all_users.jsp">Správa používateľov</a>
              <%
                }
              %>
            </li>
            <%
              if (session.getAttribute("name") != null && session.getAttribute("login") != null)
              {
            %>
            <li class="nav-item">
              <a class="nav-link" href="my_songs.jsp">Moje skladby</a>
            </li>
            <%
              }
            %>
            <li class="nav-item">
              <a class="nav-link" href="music.jsp">Hudba</a>
            </li>
            <%
              if (session.getAttribute("name") != null && session.getAttribute("login") != null)
              {
            %>
            <li class="nav-item">
              <a class="nav-link" href="downloaded_songs.jsp">História sťahovania</a>
            </li>
            <%
              }
            %>
              <%
                if (session.getAttribute("name") == null && session.getAttribute("login") == null)
                {
                  %>
                    <li class="nav-item">
                      <a class="nav-link" href="register.jsp">Registrácia</a>
                    </li>
                  <%
                }
              %>
            <li class="nav-item">
              <%
                  if (session.getAttribute("name") != null && session.getAttribute("login") != null)
                  {
                    %>
                      <a class="nav-link" href="/user-logout">Odhlásenie</a>
                    <%
                  }
                  else
                  {
                    %>
                      <a class="nav-link" href="login.jsp">Prihlásenie</a>
                    <%
                  }
              %>
            </li>
            <li class="nav-item">
              <%
                  if (session.getAttribute("name") != null && session.getAttribute("login") != null)
                  {
                    %>
                      <div class="nav-link nav-item">Príhlásený používateľ: <%=session.getAttribute("name")%></div>
                    <%
                  }
              %>

            </li>
          </ul>
        </div>
      </div>
    </nav>
  </body>
</html>



