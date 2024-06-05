<%-- 
    Document   : Gest_Nov
    Created on : 22 abr 2024, 17:24:03
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
        <title>Gestionar Novedades</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>

        <div class="gestion_tickets_container" id="gestion_usu_container">
            <div class="controlls_gest_tick" id="controlls_gest_usu">
                <div class="fltr_tickets" id="fltr_tickets">
                    <section class="busq_admin_acc">
                        <input class="form-control bus_admin_acc" id="bus_admin_acc" type="text"
                               placeholder="Buscar Novedades">
                        <i class="bi bi-search text-white"></i>
                    </section>
                    <section class="opt_admin">
                        <select class="select_adm" id="filtr_est">
                            <option selected disabled hidden>Filtrar por Estado</option>
                            <option value="true">Novedad Activa</option>
                            <option value="false">De Baja</option>
                            <option value="General">Cualquiera</option>
                        </select>
                    </section>
                </div>
            </div>
            <div class="tickets_container container_admin" id="nov_container_admin">
                <%                     Conexion con;
                    Connection c;
                    Statement stmt;
                    ResultSet rs;

                    con = new Conexion();
                    con.setCon();
                    c = con.getCon();
                    stmt = c.createStatement();
                    rs = stmt.executeQuery("Select * from Novedad;");
                    if (rs != null) {
                        while (rs.next()) {

                            String nombre = rs.getString("nov_nombre");
                            String descripcion = rs.getString("nov_descripcion");
                            String foto = rs.getString("nov_foto");
                            Boolean activo = rs.getBoolean("nov_activo");
                            int idn = rs.getInt("nov_id");
                %>
                <!-- Novedad -->
                <section class="busq_result prod d-flex" id="prod1">
                    <input type="hidden" name="name" value="<%=nombre%>">
                    <input type="hidden" name="name" value="<%=activo%>" id="inp_activo">
                    <span class="d-none busqueda_nombre"><%=nombre%></span>
                    <img src="<%=foto%>" alt="prod" class="img_prod_cnf">
                    <section class="d-flex flex-column Prod_Lis w-75 h-100">
                        <span class="N_ProVP"><%=nombre%></span>
                        <textarea type="text" class="D_ProVP h-75" id="D_ProVP" disabled><%=descripcion%></textarea>
                        <section>
                            <%
                                if (activo == true) {
                            %>
                            <form action="EliminarNovedadA" method="post">
                                <button class="btn_nov_list" type="submit">Dar de Baja</button>
                                <input type="hidden" name="idn" value="<%=idn%>">
                                <input type="hidden" name="coso" value="1">
                            </form>

                            <%
                            } else {
                            %>
                            <form action="RecuperarNovedad" method="post">
                                <button class="btn_edit_nov_list" type="submit">Restaurar Novedad</button>
                                <input type="hidden" name="idn" value="<%=idn%>">
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
        <%            } else {
                System.out.println("Error: Sesión no existe");
                response.sendRedirect("index.jsp");
            }
        %>
        <script src="js/busqueda_nombre.js"></script>
    </body>
</html>
