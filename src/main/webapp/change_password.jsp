<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.user.UserController"%>
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
  <title>Change Password Page</title>
  <%@include file="header.jsp"%>
</head>
<body>

<%@include file="navigation.jsp"%>

<%
  User user = null;
  int id = Integer.parseInt(request.getParameter("user_id"));

  try
  {
    user = new UserController().getUserById(id);
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
        <h1>Zmena hesla</h1>
      </div>
    </div>
  </div>
</div>

<div class="container mt-3">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <form action="/user-change-password?user_id=<%=id%>" id="change-password-form" method="post">
        <div class="form-group mt-3">
          <label for="current_password" class="form-label">Aktuálne heslo</label>
          <input type="password" class="form-control" id="current_password" name="current_password" placeholder="Zadajte aktuálne heslo">
        </div>
        <div class="form-group mt-3">
          <label for="new_password" class="form-label">Nové heslo</label>
          <input type="password" class="form-control" id="new_password" name="new_password" placeholder="Zadajte nové heslo">
        </div>
        <div class="form-group mt-3">
          <label for="confirm_new_password" class="form-label">Potvrdenie nového hesla</label>
          <input type="password" class="form-control" id="confirm_new_password" name="confirm_new_password" placeholder="Potvrďte nové heslo">
        </div>
        <div class="mt-3">
          <button type="submit" class="btn btn-primary btn-lg m-1 mt-3">Zmeniť</button>
          <a class="btn btn-link btn-lg m-1 mt-3 float-lg-end" href="edit_user.jsp?user_id=<%=user.getUser_id()%>">Späť</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    $("#change-password-form").validate({
      rules: {
        current_password: {
          required: true,
          minlength: 8,
          maxlength: 30
        },
        new_password: {
          required: true,
          minlength: 8,
          maxlength: 30
        },
        confirm_new_password: {
          required: true,
          equalTo: "#new_password"
        }
      },
      messages: {
        current_password: {
          required: "Prosím, zadajte Vaše aktuálne heslo.",
          minlength: "Heslo musí mať minimálne 8 znakov.",
          maxlength: "Heslo môže mať maximálne 30 znakov."
        },
        new_password: {
          required: "Prosím, zadajte Vaše nové heslo.",
          minlength: "Heslo musí mať minimálne 8 znakov.",
          maxlength: "Heslo môže mať maximálne 30 znakov."
        },
        confirm_new_password: {
          required: "Prosím, zadajte potvrdenie nového hesla.",
          equalTo: "Potvrdenie hesla sa nezhoduje s novým heslom."
        },
      }
    });
  });
</script>

</body>
</html>
