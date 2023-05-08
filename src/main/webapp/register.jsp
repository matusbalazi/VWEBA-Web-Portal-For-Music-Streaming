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
    <title>Register Page</title>
    <%@include file="header.jsp"%>
</head>
<body>

<%@include file="navigation.jsp"%>

<div class="container-fluid mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="text-center">
                <h1>Registračný formulár</h1>
            </div>
        </div>
    </div>
</div>

<div class="container mt-3">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <form action="/user-register" id="register-form" method="post">
                <div class="form-group mt-1">
                    <label for="name" class="form-label">Meno a priezvisko</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Zadajte meno a priezvisko">
                </div>
                <div class="form-group mt-3">
                    <label for="dob" class="form-label">Dátum narodenia</label>
                    <input type="date" class="form-control" id="dob" name="dob">
                </div>
                <div class="form-group mt-3">
                    <label for="email" class="form-label">E-mailová adresa</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Zadajte email">
                    <small id="emailHelp" class="form-text text-muted">Nikdy nebudeme zdieľať Váš e-mail s nikým iným.</small>
                </div>
                <div class="form-group mt-3">
                    <label for="password" class="form-label">Heslo</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Zadajte heslo">
                </div>
                <div class="form-group mt-3">
                    <label for="confirm_password" class="form-label">Potvrdenie hesla</label>
                    <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Potvrďte heslo">
                </div>
                <div class="form-group form-check mt-3">
                    <input type="checkbox" class="form-check-input" id="agree" name="agree">
                    <label class="form-check-label" for="agree">Súhlasím so spracovaním osobných údajov.</label>
                </div>
                <div class="text-center mt-3">
                    <button type="submit" class="btn btn-primary btn-block mt-3">Zaregistrujte sa!</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
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
        $("#register-form").validate({
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
                },
                password: {
                    required: true,
                    minlength: 8,
                    maxlength: 30
                },
                confirm_password: {
                    required: true,
                    equalTo: "#password"
                },
                agree: {
                    required: true
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
                },
                password: {
                    required: "Prosím, zadajte Vaše heslo.",
                    minlength: "Heslo musí mať minimálne 8 znakov.",
                    maxlength: "Heslo môže mať maximálne 30 znakov."
                },
                confirm_password: {
                    required: "Prosím, zadajte potvrdenie hesla.",
                    equalTo: "Potvrdenie hesla sa nezhoduje s heslom."
                },
                agree: {
                    required: "Musíte súhlasiť so spracovaním osobných údajov."
                }
            }
        });
    });
</script>
</body>
</html>
