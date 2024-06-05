<%-- 
    Document   : Guardados
    Created on : 21 nov 2023, 3:07:12
    Author     : altro
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Clases.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession session1 = request.getSession(false);
    if (session1.getAttribute("usuario") != null)
    {

%>

<%@page session="true"%>

<%@page import="Clases.Usuario" %>
<%@page import="Clases.Persona" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Ref_Admin.jsp"/>
        <title>Productos y Negocios Guardados</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>
        <%            HttpSession misession = (HttpSession) request.getSession();
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
        %>

        <div class="rv_contprin w-100">
            <div class="rv_cont_usu h-100 d-flex justify-content-center align-items-center">
                <section class="h-50 prop_neg_cont">
                    <span class="prop_neg d-flex justify-content-center align-items-center">
                        <section class="card_neg h-100 d-flex flex-column align-items-center justify-content-evenly">
                            <section class="bord_color">
                                <div></div>
                            </section>
                            <img src="<%=foto%>" alt="">
                            <span class="nu_span_n"><%=nombre%></span>

                        </section>

                    </span>
                </section>
            </div>
            <div class="d-flex flex-column res_otr_usu_cont">
                <span class="Inria tt_ch">Negocios Guardados</span>
                <div class="cont_res_var d- flex-column">


                    <%

                        Conexion con;
                        Connection c;
                        Statement stmt;
                        ResultSet rs, rs2;
                        con = new Conexion();
                        con.setCon();
                        c = con.getCon();
                        stmt = c.createStatement();
                        int pid = con.Pid(correo);

                        String p = null;

                        rs2 = stmt.executeQuery("select * from Guardado where per_id=" + pid + ";");

                        while (rs2.next())
                        {
                            p = "1";

                            System.out.println("pid " + pid);
                        }
                        if (p != null)
                        {

                            rs = stmt.executeQuery("select n.* from Guardado g inner join Negocio n on "
                                    + "g.neg_id = n.neg_id where g.per_id=" + pid + ";");

                            while (rs.next())
                            {

                                String nombreg = rs.getString("neg_nombre");
                                String descg = rs.getString("neg_descripcion");
                                String fotog = rs.getString("neg_logo");
                                int idn = rs.getInt("neg_id");

                    %>

                    <section class="coment_pro_ch d-flex" method="post">
                        <section class="h-100 w-25 img_sect_ch">
                            <section class="h-100 w-100 img_res_ch">
                                <img src="<%=fotog%>" alt="">
                            </section>
                            <section class="bar_img_ch" id="bar_img_ch_pro"></section>
                        </section>
                        <section class="w-75 h-100 d-flex flex-column justify-content-around">
                            <section class="d-flex flex-column">
                                <span class="Nom_neg_ch"><%=nombreg%></span>
                                <span class="cuerp_res_ch"><%=descg%></span>
                            </section>
                            <section class="d-flex justify-content-between">
                                <section class="btns_ch">
                                    <form method="post" action="Negocio.jsp" >
                                        <button type="submit" class="btn btn_visitar_busq">Visitar</button>
                                        <input type="hidden" name="idn" value="<%=idn%>"/>
                                    </form>
                                    <form action="action" class="form_elim">
                                        <input type="hidden" name="" value=""/>
                                        <input type="hidden" class="name_elim" value="<%=nombreg%>"/>
                                        <button type="submit" class="btn btn_elimnegscr_admin">Eliminar Negocio</button>
                                    </form>
                                </section>
                            </section>
                        </section>
                    </section>
                    <%
                        /*
                    <form method="post" action="EliminarGuardadoCC" >
                                <button type="submit" class="btn btn_elim_busq">Eliminar de Guardados</button>
                                <input type="hidden" name="idn" value="<%=idn"/>
                            </form>
                         */
                    %>
                    <%
                        }

                    } else
                    {


                    %>
                    <span class="Nom_neg_ch">No tienes negocios guardados</span>
                    <%    }

                    %>
                    <%       c.close();
                    %>
                    <%
                        } else
                        {
                            System.out.println("Error: Sesión no existe");
                            response.sendRedirect("index.jsp");
                        }
                    %>
                </div>
            </div>
        </div>
        <script src="js/elim.js"></script>
    </body>
</html>