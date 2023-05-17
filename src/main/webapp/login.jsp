<%@ page contentType="text/html; charset=UTF-8"  language="java"%>
<!doctype html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <meta
            name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    >
    <meta
            http-equiv="X-UA-Compatible"
            content="ie=edge"
    >
    <title>Login Page</title>
    <%@include file="header.jsp"%>
    <style>
        .toast {
            background: rgba(236, 236, 236, 1);
            padding: 16px;
            border-radius: 20px;
            text-align: center;
            font-size: 20px;
            color: rgba(33, 37, 41, 1);
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 9999;
            max-width: 300px;
        }
    </style>
</head>
<body>

<%@include file="navigation.jsp"%>

<div class="container-fluid mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="text-center">
                <h1>Prihlasovací formulár</h1>
            </div>
        </div>
    </div>
</div>

<div class="container mt-3">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <form action="/user-login" id="login-form" method="post">
                <div class="form-group mt-1">
                    <label for="email" class="form-label">Login/E-mailová adresa</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Zadajte login/email">
                </div>
                <div class="form-group mt-3">
                    <label for="password" class="form-label">Heslo</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Zadajte heslo">
                </div>
                <div class="text-center mt-3">
                    <button type="submit" class="btn btn-primary btn-lg m-1 mt-3">Prihlásiť</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%
    String successLogin = request.getParameter("success_login");
    if (successLogin != null && !successLogin.isEmpty()) {
        boolean isSuccess = Boolean.parseBoolean(successLogin);
        String message = isSuccess ? "Prihlásenie bolo úspešné!" : "Prihlásenie bolo neúspešné!";
%>
<div class="toast" id="toast">
    <div class="toast-body">
        <%= message %>
    </div>
</div>
<script>
    showToast("<%= message %>", <%= isSuccess %>);
</script>
<%
    }
%>

<%
    String successRegister = request.getParameter("success_register");
    if (successRegister != null && !successRegister.isEmpty()) {
        boolean isSuccess = Boolean.parseBoolean(successRegister);
        String message = isSuccess ? "Registrácia bola úspešná!" : "Registrácia bola neúspešná!";
%>
<div class="toast" id="toast">
    <div class="toast-body">
        <%= message %>
    </div>
</div>
<script>
    showToast("<%= message %>", <%= isSuccess %>);
</script>
<%
    }
%>

<script>

    $(document).ready(function() {
        $("#login-form").validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                password: {
                    required: true,
                }
            },
            messages: {
                email: {
                    required: "Prosím, zadajte Váš login/email.",
                    email: "Prosím, zadajte platný login/email.",
                },
                password: {
                    required: "Prosím, zadajte Vaše heslo.",
                }
            }
        });
    });

</script>
</body>
</html>
