<%-- 
    Document   : Navegador_SC
    Created on : 2 nov 2023, 16:16:38
    Author     : altro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../Referencias/Loader.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<nav class="bg-body-tertiary container-fluid bg-white">
    <div class="d-flex align-items-center p-1 h-100 contenedor_nav">
        <div class="col-xl-2 col-lg-2 d-flex">
            <a href="index.jsp"><img src="assets/logo_mydea_comida.png" alt="logotipo" class="logo"></a>
        </div>
        <div class="col-xl-6 col-lg-6 div_buscador" id="div_buscador">
            <form class="d-flex buscador" method="post" action="Buscador.jsp" >
                <input class="form-control input_search" placeholder="Buscar... (Cafeterias, Abarrotes, Snacks)"
                       aria-label="Search" name="txt" >
                <button class="btn button_search" type="submit"><i class="bi bi-search text-white"></i></button>
            </form>
            <button class="navbar-toggler close_search" type="button">
                <i class="fa-solid fa-x"></i>
            </button>
        </div>
        <div class="d-flex col-xl-4 col-lg-4 div_botones">
            <div class="col-xl-2 col-lg-2 logo_mobile">
                <a href="index.jsp"><img src="assets/Logo_Icon.png" alt="logotipo" ></a>
                <a href="index.jsp"><img src="assets/logo_mydea_comida.png" alt="logotipo" ></a>
            </div>
            <div class="col-xl-10 col-lg-10 d-flex justify-content-evenly">
                <button type="button" class="btn btn-outline-dark btn_negro btn_negro_responsive" id="btn_acceder">Acceder</button>
                <button type="button" class="btn btn_rosa text-white btn_rosa_responsive" id="btn_registro">Registrarse</button>
            </div>
            <div class="col-xl-2 col-lg-2 boton">
                <button class="btn button_search search_responsive" id="search_responsive"><i class="bi bi_reponsive bi-search text-white"></i></button>
                <button class="navbar-toggler icon" type="button" data-bs-toggle="offcanvas"
                        data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
                    <i class="bi bi-list"></i>
                </button>
            </div>
        </div>
    </div>
    <jsp:include page="../Menus/Hamburguer_SC.jsp"/>
</nav>
<div class="cursor"></div>
<div class="cursor2"></div>
<audio id="myAudio">
    <source src="assets/click.mp3" type="audio/mpeg">
    Tu navegador no soporta el elemento de audio.
</audio>
<script src="js/click.js"></script>
<script src="js/Nav_SC.js"></script>
<script src="js/Nav.js"></script>
<jsp:include page="../Asistente.jsp"/>