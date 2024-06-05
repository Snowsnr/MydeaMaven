<%-- 
    Document   : VIsitar_Cuenta_Usuario
    Created on : 20 nov 2023, 10:07:19
    Author     : altro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.Conexion"%>
<%@page import="Clases.Persona"%>
<%@page import="Clases.Usuario"%>
<%@page import="java.util.ArrayList" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1.getAttribute("usuario") != null)
    {

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Ref_Admin.jsp"/>
        <%             String id = request.getParameter("idu");
            Conexion con;
            Connection c;
            Statement stmt;
            ResultSet rs;

            int i = 0;

        %>
        <%            con = new Conexion();
            con.setCon();
            c = con.getCon();
            stmt = c.createStatement();
            String unom = "", pnom = "", desc = "", foto = "", telefono = "", correo = "", fb = "", tw = "", ig = "", web = "";
            rs = stmt.executeQuery("SELECT u.usu_nombre, p.* from Usuario u inner join Persona p on p.usu_id = u.usu_id where u.usu_id=" + id + ";");

            while (rs.next())
            {
                unom = rs.getString("usu_nombre");
                pnom = rs.getString("per_nombrecompleto");
                desc = rs.getString("per_descripcion");
                foto = rs.getString("per_foto");
                telefono = rs.getString("per_telefono");
                correo = rs.getString("per_correo");
                fb = rs.getString("per_facebook");
                tw = rs.getString("per_twitter");
                ig = rs.getString("per_instagram");
                web = rs.getString("per_web");
            }
        %>
        <title>Cuenta de <%=unom%></title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>
        <div class="main-container">


            <div class="elementos-izquierda">
                <div class="textos">
                    <p class="p1"><%=pnom%></p>
                    <p class="p2"><%=unom%></p>
                    <p class="p3"><%=desc%></p>
                </div>
                <div class="contactos">
                    <p class="p4">Contactos</p>
                    <div class="Iconos">
                        <i class="bi bi-telephone contactos_usu_perfil" data-bs-toggle="tooltip" data-bs-placement="bottom"
                           data-bs-title="<%=telefono%>" id="Telefono"></i>
                        <i class="bi bi-envelope-fill contactos_usu_perfil" data-bs-toggle="tooltip" data-bs-placement="bottom"
                           data-bs-title="<%=correo%>"></i>

                        <%
                            if (fb.equals("Sin configurar"))
                            {
                            } else
                            {

                        %>
                        <a href="<%=fb%>" class="contact_red_cu"><i class="bi bi-facebook" data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                                    data-bs-title="Facebook"></i></a>
                            <%
                                }
                                if (ig.equals("Sin configurar"))
                                {
                                } else
                                {

                            %>
                        <a href="<%=ig%>" class="contact_red_cu"><i class="bi bi-instagram" data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                                    data-bs-title="Instagram"></i></a>
                            <%}
                                if (tw.equals("Sin configurar"))
                                {
                                } else
                                {

                            %>
                        <a href="<%=tw%>" class="contact_red_cu"><i class="bi bi-twitter" data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                                    data-bs-title="Twitter"></i></a>
                            <%
                                }
                                if (web.equals("Sin configurar"))
                                {
                                } else
                                {

                            %>
                        <a href="<%=web%>" class="contact_red_cu"><i class="bi bi-globe2 " data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                                     data-bs-title="Web"></i></a>
                            <%
                                }
                                c.close();
                            %>


                    </div>
                </div>
                <div class="botones">
                    <a href="indexCC.jsp"><button class="btn btn_negro btn-outline-dark">Cancelar</button></a>
                    <form method="post" action="ComentariosCC.jsp">
                        <input type="hidden" name="idu" value="<%=request.getParameter("idu")%>"/>
                        <button class="btn btn_negro btn-outline-dark">Reseñas Hechas</button>
                    </form>
                    <form action="EliminarUsuario" class="form_elim">
                        <input type="hidden" name="idu" value="<%=id%>"/>
                        <input type="hidden" class="name_elim" value='AL USUARIO: <%=pnom%> "<%=unom%>"' />
                        <button type="submit" class="btn btn_elimnegscr_admin" id="btn_elimnegscr_admin">Eliminar Usuario</button>
                    </form>
                </div>
            </div>

            <div class="elementos-derecha">
                <div class="cont-img">
                    <img class="img" src="<%=foto%>" alt="">
                </div>
            </div>

        </div>
        <script>
            // Activar todos los tooltips
            var tooltips = new bootstrap.Tooltip(document.body, {
                selector: '[data-bs-toggle="tooltip"]',
            });

        </script>
        <%
            } else
            {
                System.out.println("Error: Sesión no existe");
                response.sendRedirect("index.jsp");
            }
        %>
        <script src="js/cu.js"></script>
        <script src="js/elim.js"></script>
    </body>
</html>
