<%-- 
    Document   : Vendedor_Perfil
    Created on : 20 nov 2023, 23:06:00
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
            ResultSet rs, rs2, rs3;

            int i = 0;

        %>
        <%            con = new Conexion();
            con.setCon();
            c = con.getCon();
            stmt = c.createStatement();
            String unom = "", pnom = "", desc = "", foto = "", telefono = "", correo = "", fb = "", tw = "", ig = "", web = "";
            rs = stmt.executeQuery("SELECT u.usu_nombre, p.* from Usuario u inner join Persona p on p.usu_id = u.usu_id where p.per_id=" + id + ";");

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
            rs2 = stmt.executeQuery("Select * from Negocio where per_id=" + id + " and neg_activo=true;");
            int num = 0;
            while (rs2.next())
            {
                num = num + 1;
            }

        %>
        <title>Cuenta de <%=unom%></title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>
        <div class="rv_contprin w-100">
            <div class="rv_cont_usu h-100 d-flex flex-column justify-content-center align-items-center" id="rv_cont_usu">
                <section class="h-50 prop_neg_cont">
                    <span class="prop_neg d-flex justify-content-center align-items-center">
                        <section class="card_neg h-100 d-flex flex-column align-items-center justify-content-evenly">
                            <section class="bord_color">
                                <div></div>
                            </section>
                            <img src="<%=foto%>" alt="">
                            <span class="nu_span_n"><%=unom%></span>
                            <section class="d-flex w-100 justify-content-around numcont_section_n">
                                <section class="d-flex flex-column justify-content-center align-items-center">
                                    <span class="num_span_n"><%=num%></span>
                                    <span class="txt_span_n">Número de Negocios</span>
                                </section>

                            </section>
                        </section>

                    </span>
                </section>

                <section class="Contactos_section_n h-25">
                    <span class="hu_tt" id="hu_tt">Contactos<i class="bi bi-question-circle"
                                                               data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                    <section class="d-flex justify-content-between w-100 icnsc_section_n">
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

                            %>
                    </section>
                </section>
            </div>
            <div class="d-flex flex-column res_otr_usu_cont">
                <span class="Inria tt_ch">Sus Negocios</span>
                <div class="cont_res_var d- flex-column">

                    <%                       rs3 = stmt.executeQuery("Select * from Negocio where per_id=" + id + " and neg_activo=true;");

                        while (rs3.next())
                        {

                            String nnom = rs3.getString("neg_nombre");
                            String descr = rs3.getString("neg_descripcion");
                            String nfoto = rs3.getString("neg_logo");
                            int idn = rs3.getInt("neg_id");
                    %>
                    <section class="coment_pro_ch d-flex" id="coment_pro_ch" method="post">
                        <section class="h-100 w-25 img_sect_ch">
                            <section class="h-100 w-100 img_res_ch">
                                <img src="<%=nfoto%>" alt="">
                            </section>
                            <section class="bar_img_ch" id="bar_img_ch"></section>
                        </section>
                        <section class="w-75 h-100 d-flex flex-column justify-content-between">
                            <section class="d-flex flex-column">
                                <span class="Nom_neg_ch"><%=nnom%></span>
                                <span class="cuerp_res_ch"><%=descr%></span>
                            </section>
                            <section class="d-flex justify-content-between w-100">
                                <section class="btns_ch w-100 justify-content-between">
                                    <form method="post" class="btn_mn" action="NegociosCA.jsp">
                                        <input type="hidden" name="idn" value="<%=idn%>">
                                        <button type="submit" class="btn btn_visitar_busq">Visitar</button>
                                    </form>
                                    <form action="EliminarNegocioA" class="form_elim">
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                        <input type="hidden" class="name_elim" value="<%=nnom%>"/>
                                        <button type="submit" class="btn btn_elimnegscr_admin">Eliminar Negocio</button>
                                    </form>
                                </section>
                            </section>
                        </section>
                    </section>

                    <%
                        }

                        c.close();
                    %>

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

        <script src="js/elim.js"></script>
    </body>
</html>
