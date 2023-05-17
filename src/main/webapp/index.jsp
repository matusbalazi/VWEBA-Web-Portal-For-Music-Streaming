<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <meta
            name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    >
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@include file="header.jsp"%>
    <title>Home Page</title>
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
    <div class="container-fluid m-5 mt-5">
        <h1>Vitajte na webovom portáli na streamovanie hudby!</h1>
        <p>Toto je domovská stránka nášho webového portálu na streamovanie hudby.
            Na preskúmanie stránky môžete použiť navigačný panel vyššie.</p>
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

</body>
</html>