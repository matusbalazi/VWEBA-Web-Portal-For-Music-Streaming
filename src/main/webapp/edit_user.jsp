<%@ page import="sk.kmikt.webovy_portal_na_streamovanie_hudby.user.UserController"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!doctype html>
<html lang=sk>
<head>
  <meta charset="UTF-8">
  <meta
          name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
  >
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Edit User Page</title>
  <%@include file="header.jsp"%>
</head>
<body>

<%@include file="navigation.jsp"%>

<%
  String dateFormat = "yyyy-MM-dd";
  DateFormat df = new SimpleDateFormat(dateFormat);
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

<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <div class="text-center">
        <a class="btn btn-light btn-lg btn-block mt-3 float-lg-end" href="change_password.jsp?user_id=<%=user.getUser_id()%>">Zmeniť heslo</a>
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
      <form action="/user-update?user_id=<%=id%>" id="edit-user-form" method="post">
        <div class="form-group mt-1">
          <label for="name" class="form-label">Meno a priezvisko</label>
          <input type="text" class="form-control" id="name" name="name" placeholder="Zadajte meno a priezvisko" value="<%=user.getName()%>">
        </div>
        <div class="form-group mt-3">
          <label for="dob" class="form-label">Dátum narodenia</label>
          <input type="date" class="form-control" id="dob" name="dob" value="<%=df.format(user.getDob())%>">
        </div>
        <div class="form-group mt-3">
          <label for="email" class="form-label">E-mailová adresa</label>
          <input type="email" class="form-control" id="email" name="email" placeholder="Zadajte email" value="<%=user.getEmail()%>">
        </div>
        <div class="form-group form-check mt-3">
          <input type="checkbox" class="form-check-input" id="is_admin" name="is_admin" <%if (user.isIs_admin()) {%>checked<%}%>>
          <label class="form-check-label" for="is_admin">Je admin</label>
        </div>
        <div class="mt-3">
          <button type="submit" class="btn btn-primary btn-lg m-1 mt-3">Zmeniť</button>
          <a class="btn btn-link btn-lg m-1 mt-3 float-lg-end" href="all_users.jsp">Späť</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    // Get the initial value of the "is_hidden" checkbox
    var initialValue = $('#is_admin').is(':checked');

    // Set the value of the "is_hidden" input field based on the initial value
    $('input[name="is_admin"]').val(initialValue ? 'true' : 'false');
  });

  $(document).ready(function () {
    $('#is_admin').on('change', function () {
      $('input[name="is_admin"]').val($(this).is(':checked') ? 'true' : 'false');
    });
  });

  $.validator.addMethod("minAge", function(value, element, min) {
    var today = new Date();
    var birthDate = new Date(value);
    var age = today.getFullYear() - birthDate.getFullYear();
    if (age < min) {
      return false;
    }
    var month = today.getMonth() - birthDate.getMonth();
    if (month < 0 || (month === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }

    return age >= min;
  }, "Musíte mať aspoň {0} rokov.");

  $(document).ready(function() {
    $("#edit-user-form").validate({
      rules: {
        name: {
          required: true,
          maxlength: 30
        },
        dob: {
          required: true,
          date: true,
          minAge: 15
        },
        email: {
          required: true,
          email: true,
          maxlength: 40
        }
      },
      messages: {
        name: {
          required: "Prosím, zadajte Vaše meno a priezvisko.",
          maxlength: "Meno a priezvisko môže mať maximálne 30 znakov."
        },
        dob: {
          required: "Prosím, zadajte Váš dátum narodenia.",
          date: "Prosím, zadajte platný dátum.",
          minAge: "Musíte mať minimálne 15 rokov."
        },
        email: {
          required: "Prosím, zadajte Váš email.",
          email: "Prosím, zadajte platný email.",
          maxlength: "Email môže mať maximálne 40 znakov."
        }
      }
    });
  });
</script>

</body>
</html>
