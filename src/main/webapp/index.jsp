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
</head>
<body>
    <%
        /*
        Web portal for music streaming

            1. Admin
                a. Admin can VIEW the list of all registered Users
                b. Admin can VIEW/ADD/UPDATE/DELETE music category
                c. Admin can VIEW/ADD/UPDATE/DELETE music tracks
                d. ? Admin can VIEW the payment history for downloaded songs
                e. ? Admin can VIEW feedback

            2. Customer
                a. Customers can VIEW all the music
                b. Customers can PLAY any music
                c. If the customer wants to download music, he/she needs to make a payment
                d. Customers can VIEW payment history
                e. ? Customers can ADD feedback
         */
    %>

    <%@include file="navigation.jsp"%>
    <div class="container-fluid mt-5">
        <h1>Vitajte na mojej webovej stránke!</h1>
        <p>Toto je domovská stránka môjho webu. Na preskúmanie stránky môžete použiť navigačný panel vyššie.</p>
    </div>

</body>
</html>