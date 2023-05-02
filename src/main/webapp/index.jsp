<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta
            name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    >
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@include file="header.jsp"%>
    <style>
        .navbar-brand {
            font-size: 28px;
            margin-right: 30px;
        }
        .navbar-nav {
            margin: 0 auto;
        }
        .nav-item {
            margin-left: 30px;
        }
    </style>
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
                d. Admin can VIEW the payment history for downloaded songs
                e. Admin can VIEW feedback

            2. Customer
                a. Customers can VIEW all the music
                b. Customers can PLAY any music
                c. If the customer wants to download music, he/she needs to make a payment
                d. Customers can VIEW payment history
                e. Customers can ADD feedback
         */
    %>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">My Website</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Music</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container-fluid mt-5">
        <h1>Welcome to My Website!</h1>
        <p>This is the home page of my website. You can use the navigation bar above to explore the site.</p>
    </div>
</body>
</html>