<%-- 
    Document   : Vendedor_Perfil
    Created on : 20 nov 2023, 23:06:00
    Author     : altro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession session1 = request.getSession(false);
    if (session1.getAttribute("usuario") != null) {

    %>

<%@page session="true"%>
<%@page import="Clases.Usuario" %>
<%@page import="Clases.Persona" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Todas_Ref.jsp"/>
        <title>Mis Negocios</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CV.jsp"/>
        <%
            HttpSession misession = (HttpSession) request.getSession();
            Usuario usuario = (Usuario) misession.getAttribute("usuario");
            String nombre = usuario.getUsu_nom();
            String pass = usuario.getUsu_pass();
            Persona per = (Persona) misession.getAttribute("persona");
            String correo = per.getPer_correo();
            String foto = per.getPer_foto();
            String telefono = per.getPer_telefono();
            String nombrereal = per.getPer_nombrereal();
            String fb = per.getPer_fb();
            String ig = per.getPer_ig();
            String tw = per.getPer_twitter();
            String web = per.getPer_web();
            int pid = 0;
            Conexion con;
            Connection c;
            Statement stmt;
            ResultSet rs, rs2, rs3;
            con = new Conexion();
            con.setCon();
            c = con.getCon();
            stmt = c.createStatement();
            rs2 = stmt.executeQuery("Select n.neg_id, p.per_id from Negocio n inner Join Persona p on p.per_id=n.per_id where p.per_correo='" + correo + "' and n.neg_activo=true;");
            int num = 0;
            while (rs2.next())
            {
                num = num + 1;
                pid = rs2.getInt("per_id");
            }

        %>
        <div class="rv_contprin w-100">
            <div class="rv_cont_usu h-100 d-flex flex-column justify-content-center align-items-center" id="rv_cont_usu">
                <section class="h-50 prop_neg_cont">
                    <span class="prop_neg d-flex justify-content-center align-items-center">
                        <section class="card_neg h-100 d-flex flex-column align-items-center justify-content-evenly">
                            <section class="bord_color">
                                <div></div>
                            </section>
                            <img src="<%=foto%>" alt="">
                            <span class="nu_span_n"><%=nombre%></span>
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
                    <span class="hu_tt" id="hu_tt">Contactos del Negocio <i class="bi bi-question-circle"
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
                                                                    data-bs-title="Facebok"></i></a>
                            <%
                                }

                                if (ig.equals("Sin configurar"))
                                {

                                } else
                                {
                            %>
                        <a href="<%=ig%>" class="contact_red_cu"><i class="bi bi-instagram" data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                                    data-bs-title="Instagram"></i></a>
                            <%
                                }

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
                <span class="Inria tt_ch">Mis Negocios</span>
                <div class="cont_res_var d- flex-column">

                    <%                       rs3 = stmt.executeQuery("Select * from Negocio where neg_activo=true and per_id=" + pid + ";");
                        int contador = 0;
                        int contador2 = 1;
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

                                    <form action="Editar_Negocio.jsp" method="post" class="btn_mn">
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                        <button type="submit" class="btn btn_visitar_busq">Editar</button>
                                    </form>
                                        
                                    <form action="CrearNegocio_Formulario.jsp" method="post" class="btn_mn">
                                        <input type="hidden" name="neid" value="<%=idn%>"/>
                                        <button type="submit" class="btn btn_visitar_busq">Agregar Productos</button>
                                    </form>

                                    <form action="Subir_Novedad.jsp" method="post" class="btn_mn">
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                        <button type="submit" class="btn btn_visitar_busq">Novedades</button>
                                    </form>

                                    <form action="Feedback.jsp" method="post" class="btn_mn">
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                        <button type="submit" class="btn btn_visitar_busq">Feedback</button>
                                    </form>

                                    <form action="NegocioCV.jsp" method="post" class="btn_mn">
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                        <button type="submit" class="btn btn_visitar_busq">Visitar</button>
                                    </form>
                                        
                                    <form action="Editar_Producto.jsp" method="post" class="btn_mn">
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                        <button type="submit" class="btn btn_visitar_busq">Editar Productos</button>
                                    </form>  
                                           
                                        <form action="EliminarNegocio" method="post" id="forme<%=contador%>">
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                        <button type="submit" class="btn btn_elim_busq" id="btnsubmit<%=contador%>">Eliminar</button>
                                    </form>
                                      
                                    
                                </section>
                            </section>
                        </section>
                    </section>
                    <%
                        contador = contador +1;
                        }
                        c.close();
                    %>
                    <input type="hidden" id="contador" value="<%=contador%>"/>
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
            if (request.getAttribute("mensaje") != null)
            {
        %>          
        <script>
            window.onload = function () {
                alert("  <%=request.getAttribute("mensaje")%>");
            };
        </script>      
        <%
            }
        %>
                                                                    <%
            }else{
    System.out.println("Error: Sesión no existe");
    response.sendRedirect("index.jsp");
}
            %>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script src="js/vp.js"></script>
    </body>
</html>
