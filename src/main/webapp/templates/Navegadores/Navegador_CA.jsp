<%-- 
    Document   : Navegador_CC
    Created on : 2 nov 2023, 23:34:41
    Author     : altro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../Referencias/Loader.jsp"/>
<nav class="bg-body-tertiary container-fluid nav_admin">
    <div class="row d-flex align-items-center p-1 h-100">
        <div class="col-3 d-flex">
            <a href="indexCA.jsp"><img src="assets/logo_mydea_comida.png" alt="logotipo" class="img-fluid logo"></a>
        </div>
        <form class="col-6 d-flex w-10" method="post" action="Buscador_admin.jsp">
            <input class="form-control input_search input_search_admin"
                   placeholder="Buscar... (Cafeterias, Abarrotes, Snacks)" aria-label="Search" name="txt"
                   id="input_search_admin">
            <button class="btn btn_submit_admin" type="submit"><i class="bi bi-search"
                                                                  id="btn_submit_admin_icon"></i></button>
        </form>

        <div class="col-3 d-flex justify-content-evenly">
            <div class="btn-group Cuenta_des w-50" id="Cuenta_des">
                <button type="button" class="btn btn-sm btn-secondary btn_count" id="btn_count_nav"><i
                        class="bi bi-person-circle"></i>Admin</button>
                <button type="button"
                        class="btn btn-sm btn-secondary dropdown-toggle dropdown-toggle-split btn_des w-0"
                        data-bs-toggle="dropdown" aria-expanded="false">
                </button>
                <ul class="dropdown-menu">
                    <li class="dropdown-item" id="btn_admin">Acciones de Administrador</li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <form action="CerrarSesion" id="formcerrar">
                        <li class="dropdown-item cerr_sesnav" id="cerr_sesnav">
                            <button class="cerr_sesnav_btn" type="submit" id="btn_lgout_nav">Cerrar Sesión</button>
                        </li>
                    </form>
                </ul>
            </div>
            <button class="navbar-toggler btnp btn_hamb" type="button" data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
                <i class="bi bi-list btn_hamb_icon"></i>
            </button>
            <div class="offcanvas offcanvas-end hamburger_admin" tabindex="-1" id="offcanvasNavbar"
                 aria-labelledby="offcanvasNavbarLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Administrador: </h5>
                    <button type="button" class="btn btn_close_admin" data-bs-dismiss="offcanvas"
                            aria-label="Close"><i class="bi bi-x-lg"></i></button>
                </div>
                <div class="offcanvas-body">
                    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
<div class="cursor"></div>
<div class="cursor2"></div>
<audio id="myAudio">
    <source src="assets/click.mp3" type="audio/mpeg">
    Tu navegador no soporta el elemento de audio.
</audio>
<script src="js/click.js"></script>
<script src="js/Nav_CA.js"></script>

<jsp:include page="../Asistente.jsp"/>