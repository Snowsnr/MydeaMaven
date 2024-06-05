<%-- 
    Document   : Comentarios_Hechos
    Created on : 20 nov 2023, 21:37:40
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
        <title>Tus Comentarios</title>
    </head>
    <jsp:include page="templates/Navegadores/Navegador_CC.jsp"/>
    <%        Conexion con;
        Connection c;
        Statement stmt;
        ResultSet rs, rs2 = null, rs3;
        con = new Conexion();
        con.setCon();
        c = con.getCon();
        stmt = c.createStatement();
        rs3 = stmt.executeQuery("Select u.usu_nombre, p.per_foto, p.per_correo from Usuario u inner join Persona p on p.usu_id="
                + "u.usu_id where p.per_id=" + request.getParameter("idu") + ";");

        String foto = "", nombre = "", correo = "";
        while (rs3.next())
        {

            nombre = rs3.getString("usu_nombre");
            foto = rs3.getString("per_foto");
            correo = rs3.getString("per_correo");

        }

    %>

    <div class="rv_contprin w-100">
        <div class="rv_cont_usu h-100 d-flex justify-content-center align-items-center">
            <section class="prop_neg_cont">
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
            <span class="Inria tt_ch">Reseñas Hechas</span>
            <div class="cont_res_var d- flex-column">

                <%

                    rs = stmt.executeQuery("select n.*, f.* from Feedback f inner join Negocio n on f.neg_id=n.neg_id where f.per_id=" + request.getParameter("idu") + ";");

                    while (rs.next())
                    {

                        if (rs != null)
                        {

                            String nombreg = rs.getString("neg_nombre");
                            String descg = rs.getString("neg_descripcion");
                            String fotog = rs.getString("neg_logo");
                            String comentario = rs.getString("fed_comentario");
                            Boolean like = rs.getBoolean("fed_like");
                            int idc = rs.getInt("fed_id");
                            int idn = rs.getInt("neg_id");

                %>
                <section class="coment_pro_ch d-flex" method="post">
                    <section class="h-100 w-25 img_sect_ch">
                        <section class="h-100 w-100 img_res_ch">
                            <img src="<%=fotog%>" alt="">
                        </section>
                        <section class="bar_img_ch"></section>
                    </section>
                    <section class="w-75 h-100 d-flex flex-column justify-content-between">
                        <i class="bi bi-quote quote_ch"><%=comentario%></i>
                        <section class="d-flex flex-column">
                            <span class="Nom_neg_ch"><%=nombreg%></span>
                            <span class="cuerp_res_ch"><%=descg%></span>
                        </section>
                        <section class="d-flex justify-content-between">
                            <%
                                if (like == true)
                                {
                            %>
                            <section class="d-flex justify-content-center align-items-center">
                                <span><i class="bi bi-heart-fill"></i> Le gustó</span>
                            </section>
                            <%
                                }
                            %>
                            <section class="btns_ch">
                                <form action="action" class="form_elim">
                                    <input type="hidden" name="" value=""/>
                                    <input type="hidden" class="name_elim" value="ESTE COMENTARIO"/>
                                    <button type="submit" class="btn btn_elimnegscr_admin">Eliminar Comentario</button>
                                </form>

                            </section>
                        </section>
                    </section>
                </section>

                <%
                } else

                {


                %>
                <span class="Nom_neg_ch">No ha hecho ninguna reseña</span>
                <%    }
                    }
                    c.close();
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
