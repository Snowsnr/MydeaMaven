<%-- 
    Document   : Gest_Com
    Created on : 22 abr 2024, 17:23:51
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
        <title>Gestionar Comentarios</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>
        <div class="gestion_tickets_container" id="gestion_usu_container">
            <div class="controlls_gest_tick" id="controlls_gest_usu">
                <div class="fltr_tickets" id="fltr_tickets">
                    <section class="busq_admin_acc">
                        <input class="form-control bus_admin_acc" id="bus_admin_acc" type="text"
                               placeholder="Buscar Usuario que Comentó">
                        <i class="bi bi-search text-white"></i>
                    </section>
                    <section class="opt_admin">
                        <select class="select_adm" id="filtr_est">
                            <option selected disabled hidden>Filtrar por Estado</option>
                            <option value="true">Comentario Activo</option>
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
                    String sql = "select u.usu_nombre, f.fed_comentario, f.fed_like, f.fed_activo, f.fed_id, u.usu_id, p.per_foto from Usuario u inner join Persona p "
                            + "on p.usu_id = u.usu_id inner join Feedback f on f.per_id = p.per_id where u.usu_activo=true;";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int idc = rs.getInt("fed_id");
                        int idu = rs.getInt("usu_id");
                        Boolean activo = rs.getBoolean("fed_activo");
                        String nomu = rs.getString("usu_nombre");
                        String ft = rs.getString("per_foto");
                        String comentario = rs.getString("fed_comentario");
                        Boolean like = rs.getBoolean("fed_like");

                %>
                <!-- Comentarios -->
                <section class="busq_result" id="busq_result_com">
                    <input type="hidden" name="name" value="<%=activo%>" id="inp_activo">
                    <input class="d-none" id="fecha_inp_busq" type="date" disabled value="2007-04-20">
                    <input class="d-none" type="text" id="nom_neg_com" disabled value="Nombre del negocio que ah comentado">
                    <img src="src" class="d-none" alt="Logo del negocio que comento" id="log_neg_com"/>
                    <section class="resena_usua_esp d-flex flex-column" id="resena_usua_admin">
                        <section class="comentario_n">
                            <span class="busqueda_nombre" id="nom_usu_com"><%=nomu%></span>
                            <img src="<%=ft%>" alt="Img de perfil del usuario" id="img_perf_com">
                        </section>
                        <span class="texto_res_usu" id="coment_desc"><%=comentario%></span>
                        <%
                            if (like == true) {
                        %>
                        <span class="liornli"><i class="bi bi-heart-fill"></i> Le gustó este Negocio</span>
                        <%
                            }
                        %>
                        <i class="bi bi-quote comment_icon_neg"></i>

                        <section class="sect_btns_admincom">
                            <%
                                if (activo == true) {
                            %>
                            <form action="EliminarComentarioA">
                                <button id="baja_usu">Dar de baja el comentario <i class="bi bi-chat-left-quote-fill"></i></button>
                                <input type="hidden" id="idu" name="idc" value="<%=idc%>"/>
                            </form>
                            <%
                            } else {
                            %>
                            <form action="RecuperarComentario">
                                <button id="baja_usu">Dar de alta el comentario <i class="bi bi-person-fill-up"></i></button>
                                <input type="hidden" id="idu" name="idc" value="<%=idc%>"/>
                            </form>
                            <%
                                }
                            %>
                            <form action="EliminarUsuario">
                                <button id="baja_usu">Dar de baja al Usuario que comentó <i class="bi bi-person-x"></i></button>
                                <input type="hidden" id="idu" name="idu" value="<%=idu%>"/> 
                                <input type="hidden" name="comentario" value="1"/> 
                            </form>

                        </section>
                    </section>
                </section>

                <%

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
