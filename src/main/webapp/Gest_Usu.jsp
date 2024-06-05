<%-- 
    Document   : Gest_usu
    Created on : 22 abr 2024, 17:22:50
    Author     : altro
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Clases.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession session1 = request.getSession(false);
    if (session1.getAttribute("usuario") != null) {

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Ref_Admin.jsp"/>
        <title>Gestionar Usuarios</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>
        <div class="gestion_tickets_container" id="gestion_usu_container">
            <div class="controlls_gest_tick" id="controlls_gest_usu">
                <div class="fltr_tickets" id="fltr_tickets">
                    <section class="busq_admin_acc">
                        <input class="form-control bus_admin_acc" id="bus_admin_acc" type="text"
                               placeholder="Buscar Usuario">
                        <i class="bi bi-search text-white"></i>
                    </section>
                    <section class="opt_admin">
                        <select class="select_adm" id="filtr_est">
                            <option selected disabled hidden>Filtrar por Estado</option>
                            <option value="true">Usuario Activo</option>
                            <option value="false">De Baja</option>
                            <option value="General">Cualquiera</option>
                        </select>
                    </section>
                </div>
            </div>
            <div class="tickets_container container_admin" id="tickets_container">

                <%                    Conexion con;
                    Connection c;
                    Statement stmt;
                    ResultSet rs;

                    con = new Conexion();
                    con.setCon();
                    c = con.getCon();
                    stmt = c.createStatement();
                    String sql = "SELECT p.per_foto, p.per_descripcion, u.usu_id, u.usu_nombre, u.usu_activo, u.tip_id FROM Persona p INNER JOIN Usuario u ON u.usu_id=p.usu_id";
                    rs = stmt.executeQuery(sql);
                    if (rs != null) {
                        while (rs.next()) {

                            String unom = rs.getString("usu_nombre");
                            String pfoto = rs.getString("per_foto");
                            String descripcion = rs.getString("per_descripcion");
                            int pid = rs.getInt("usu_id");
                            int tipo = rs.getInt("tip_id");
                            boolean activo = rs.getBoolean("usu_activo");

                            if (tipo == 1) {
                %>

                <!-- Usuario Normal -->
                <section class="busq_result busq_usu nr" id="busq_usu_adm">
                    <input type="hidden" name="name" value="<%=activo%>" id="inp_activo">
                    <img src="<%=pfoto%>" class="usunr_img" id="usu_img_busq">
                    <section class="info_usu_nusq usu_nr" id="usu_nr">
                        <span class="nb_busq nb busqueda_nombre"><%=unom%></span>
                        <span class="dir_bus w-100 desc_busq" id="desc_busq_usu"><%=descripcion%></span>
                        <section class="sect_btns_adminusu">
                            <%
                                if (activo == true) {
                            %>
                            <form action="EliminarUsuario">
                                <button id="baja_usu">Dar de baja al Usuario <i class="bi bi-person-x"></i></button>
                                <input type="hidden" id="idu" name="idu" value="<%=pid%>"/>
                            </form>
                            <%
                            } else {
                            %>
                            <form action="RecuperarUsuario">
                                <button id="baja_usu">Dar de alta al Usuario <i class="bi bi-person-fill-up"></i></button>
                                <input type="hidden" id="idu" name="idu" value="<%=pid%>"/>
                            </form>
                            <%
                                }
                            %>
                        </section>
                        <i class="bi bi-person-fill usernr_icon"></i>
                    </section>
                </section>

                <%
                } else if (tipo == 2) {
                %>

                <!-- Usuario Vendedor -->
                <section class="busq_result busq_usu" id="busq_usu_adm" >
                    <input type="hidden" name="name" value="<%=activo%>" id="inp_activo">
                    <img src="<%=pfoto%>" class="usuvd_img" id="usu_img_busq">
                    <section class="info_usu_nusq usu_vd" id="vend_nr">
                        <span class="nb_busq nb">Vendedor <span class="busqueda_nombre"><%=unom%></span></span>
                        <span class="dir_bus w-100 desc_busq" id="desc_busq_usu"><%=descripcion%></span>
                        <i class="bi bi-shop uservd_icon"></i>
                        <section class="sect_btns_adminusu">
                            <%
                                if (activo == true) {
                            %>
                            <form action="EliminarUsuario">
                                <button id="baja_usu">Dar de baja al Vendedor <i class="bi bi-person-x"></i></button>
                                <input type="hidden" id="idu" name="idu" value="<%=pid%>"/>
                            </form>
                            <%
                            } else {
                            %>
                            <form action="RecuperarUsuario">
                                <button id="baja_usu">Dar de alta al Usuario <i class="bi bi-person-fill-up"></i></button>
                                <input type="hidden" id="idu" name="idu" value="<%=pid%>"/>
                            </form>
                            <%
                                }
                            %>
                        </section>
                    </section>
                </section>

                <%
                            }
                        }
                    }

                    c.close();
                %>






            </div>
        </div>
        <%
            if (request.getAttribute("mensaje") != null) {
        %>          
        <script>
            window.onload = function () {
                Swal.fire({
                    icon: "success",
                    title: "<%=request.getAttribute("mensaje")%>",
                    showConfirmButton: false,
                    timer: 5000
                });
            };
        </script>      
        <%
            }
        %>
        <script src="js/edipro.js"></script>
        <%
            } else {
                System.out.println("Error: Sesión no existe");
                response.sendRedirect("index.jsp");
            }
        %>
        <script src="js/busqueda_nombre.js"></script>
    </body>
</html>
