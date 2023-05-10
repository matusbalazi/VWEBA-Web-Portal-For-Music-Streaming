<%@ page import="java.util.ArrayList"%>
<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.user.UserController"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
  <title>All Users Page</title>
  <%@include file="header.jsp"%>
</head>
<body>

  <%@include file="navigation.jsp"%>

  <%
    String color = "";
    String dateFormat = "dd.MM.yyyy";
    DateFormat df = new SimpleDateFormat(dateFormat);
    ArrayList<User> users = null;

    try
    {
      users = new UserController().getAllUsers();
    }
    catch (SQLException | NamingException e)
    {
      throw new RuntimeException(e);
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

  <div class="container mt-4">
    <h1 class="text-center">Zoznam zaregistrovaných používateľov</h1>
    <table class="table table-striped table-bordered table-hover mt-3">
      <thead>
      <tr>
        <td class="text-secondary fw-bold">Meno a priezvisko</td>
        <td class="text-secondary fw-bold">Dátum narodenia</td>
        <td class="text-secondary fw-bold">E-mailová adresa</td>
        <td class="text-secondary fw-bold">Upraviť/Vymazať</td>
      </tr>
      </thead>

      <tbody>
      <%
        for (User user: users)
        {
          if (!user.isIs_admin())
          {
            color = "black";
          }
          else
          {
            color = "green";
          }
          %>
          <tr>
            <td style="color: <%=color%>;"><%=user.getName()%></td>
            <td style="color: <%=color%>;"><%=df.format(user.getDob())%></td>
            <td style="color: <%=color%>;"><%=user.getEmail()%></td>
            <td>
              <a class="btn btn-warning m-1" href="edit_user.jsp?user_id=<%=user.getUser_id()%>" role="button">EDIT</a>
              <a class="btn btn-danger m-1" href="/user-delete?user_id=<%=user.getUser_id()%>" role="button">DELETE</a>
            </td>
          </tr>
          <%
        }
      %>
      </tbody>
    </table>
  </div>

</body>
</html>
