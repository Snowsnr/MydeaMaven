<%-- 
    Document   : ConfirmarCodigo_I
    Created on : 30 nov 2023, 0:45:11
    Author     : ibarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
        }

        .cont {
            text-align: center;
            margin-top: 50px; /* Ajusta este valor según tus necesidades */
        }

        form {
            background-color: #f6f8fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 300px; /* Ajusta este valor según tus necesidades */
            margin: 0 auto; /* Centra el formulario horizontalmente */
            padding: 16px;
            font-size: 14px;
            border: 1px solid rgb(201, 201, 201);
            border-radius: 6px;
            width: 15%;
            
        }

        h1 {
            color: #000;
            font-size: 24px;            
            margin-bottom: 50px;
            margin-top: 20px;
            margin-left: 40%;
            font-family: -apple-system,BlinkMacSystemFont,"Segoe UI","Noto Sans",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji";
            letter-spacing: -0.5px;
            font-weight: 300;      
            width: 20%;
        }
        
        

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        textarea:focus, input:focus, input[type]:focus {
    border-color: lightblue;
    
}

        span {
            color: red;
            display: block;
            margin-bottom: 16px;
        }

        input[type="submit"] {
           position: relative;
            display: inline-block;
            padding: 5px 16px;
            font-size: 14px;
            font-weight: var(--base-text-weight-medium, 500);
            line-height: 20px;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            -webkit-user-select: none;
            user-select: none;
            border: 1px solid;
            border-radius: 6px;
            -webkit-appearance: none;
            appearance: none;
            background-color: #1f883d;
            color: white;
        }

        input[type="submit"]:hover {
            background-color: #1a7f37;
        }
        
        img{
            height: 60px;
            width: 60px;
        }
    </style>
    <body>
        <div class="cont">
            <img src="assets/Logo_Icon.png" alt="alt"/>
        <h1>Se ha enviado un codigo a su correo electrónico</h1>
        <form action="IniciarSesion" method="POST">
            <label for="code">Código de confirmación:</label><br>
            <input class="form-control" type="text" id="code" name="codigo"><br>
            <span>${error_codigo}</span>
            <%-- Recuperar los datos de la sesión --%>
            <input type="hidden" name="Nom_usu_is" value="<%= session.getAttribute("nom") %>">
            <input type="hidden" name="Email_is" value="<%= session.getAttribute("correo") %>">
            <input type="hidden" name="Con_is" value="<%= session.getAttribute("pass") %>">
            <input type="submit" value="Confirmar">
        </form>
        </div>
    </body>
</html>
