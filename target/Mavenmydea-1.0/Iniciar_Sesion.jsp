<%-- 
    Document   : Iniciar_Sesion
    Created on : 13 nov 2023, 17:01:34
    Author     : ibarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" http-equiv="Content-Type" content="width=device-width, initial-scale=1, charset=UTF-8">
        <jsp:include page="templates/Referencias/Todas_Ref.jsp"/>
        <title>Bienvenido de Vuelta!</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_SC.jsp"/>
        <div class="content_iniciars d-flex flex-column justify-content-between">
            <section class="color1_is deslizard"></section>
            <section class="color2_is deslizard"></section>
            <form class="w-100 container_is align-items-center justify-content-center flex-column subir" method="post" action="IniciarSesion" >
                <div class="is_form_container justify-content-between align-items-center">
                    <svg class="user_is" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M399 384.2C376.9 345.8 335.4 320 288 320H224c-47.4 0-88.9 25.8-111 64.2c35.2 39.2 86.2 63.8 143 63.8s107.8-24.7 143-63.8zM0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256zm256 16a72 72 0 1 0 0-144 72 72 0 1 0 0 144z"/></svg>
                    <section class="Txt_IS d-flex flex-column justify-content-center align-items-center">
                        <span>INICIAR SESIÓN</span>
                        <span>Bienvenido de vuelta.<br> Por favor complete los campos solicitados para iniciar sesión.</span>
                    </section>
                    <ul class="d-flex list_inp_is justify-content-around">
                        <li><label for="Nom_usu_is">Nombre de Usuario</label><input value="${valorNom}" type="text" id="Nom_usu_is" name="Nom_usu_is" class="form-control" placeholder=" Nombre de Usuario">
                            <span class="error">${error_nombreUsuario_Vacio}</span>
                            <span class="error">${error_nombreUsuario_Largo}</span>
                        </li>
                        <li><label for="Email_is">Correo Electrónico</label><input value="${valorCorreo}" type="email" id="Email_is" name="Email_is" class="form-control" placeholder=" Correo Electronico">
                            <span class="error">${error_correo_Vacio}</span>
                            <span class="error">${error_correo_Invalido}</span>
                        </li>
                        <li><label for="Con_is">Contraseña</label>
                            <section class="contr_sect">
                                <input value="${valorPass}" type="password" id="Con_is" name="Con_is" class="form-control" placeholder=" Ingresar"><i class="bi bi-eye eye_r" id="eyescs"></i><i class="bi bi-eye-slash eye_r" id="eyencs"></i>
                            </section>
                            <span class="error">${error_contraseña_Vacio}</span>
                        </li></ul>
                        <span class="texto_registro">¿Aún no tienes una cuenta? <a href="Registro.jsp" class="txt_os">Registrarse</a> </span>
                </div>
                <button class="btn btns_is" type="submit" id="Boton_is">
                    Iniciar Sesión
                </button>
            </form>
        </div>
    </body>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <%
        if (request.getAttribute("mensaje") != null) {
    %>          
    <script>
         window.onload=function() {
       Swal.fire({
  icon: "error",
  title: "<%=request.getAttribute("mensaje")%>",
  showConfirmButton: false,
  timer: 5000
});
    };
    </script>      
    <%
        }
    %>
    <script src="js/Nav.js"></script>
    <script src="js/is.js"></script>
</html>
