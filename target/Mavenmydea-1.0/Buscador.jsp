<%-- 
    Document   : Buscador
    Created on : 20 nov 2023, 19:10:31
    Author     : altro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Clases.Conexion"%>
<%@page import="Clases.Persona"%>
<%@page import="Clases.Usuario"%>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Todas_Ref.jsp"/>
        <title>Busqueda - <%=request.getParameter("txt")%></title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_SC.jsp"/>
        <div class="busq_cont_prin">
            <div class="w-100 h-100 cont_busq_res_txt d-flex flex-column Inria">
                <section>
                    <span class="busqueda">"<%=request.getParameter("txt")%>"</span>
                    <section class="botones_busq">
                        <button class="btn_busq" id="General_btn_busq">General</button>
                        <button class="btn_busq" id="Productos_btn_busq">Productos</button>
                        <button class="btn_busq" id="Negocios_btn_busq">Negocios</button>
                        <button class="btn_busq" id="Usuarios_btn_busq">Usuarios</button>
                    </section>
                </section>
                <div class="cont_busq_res">

                    <%
                        String bs = request.getParameter("txt");
                        Conexion con;
                        Connection c;
                        Statement stmt;
                        ResultSet rs, rs2, rs3;

                        int id;
                        int i = 0;

                    %>
                    <%            con = new Conexion();
                        con.setCon();
                        c = con.getCon();
                        stmt = c.createStatement();
                        PreparedStatement ps = c.prepareStatement("SELECT n.*,d.*,p.per_foto,u.usu_nombre FROM Direccion d INNER JOIN "
                                + "Negocio n ON n.dir_id=d.dir_id INNER JOIN Persona p ON n.per_id = p.per_id INNER JOIN Usuario u ON"
                                + " p.usu_id = u.usu_id WHERE n.neg_activo = true AND neg_nombre LIKE ?");
                        ps.setString(1, "%" + bs + "%");
                        rs = ps.executeQuery();
                        if (rs != null)
                        {
                            while (rs.next())
                            {
                                String nombre = rs.getString("neg_nombre");
                                String nombreu = rs.getString("usu_nombre");
                                String img = rs.getString("neg_logo");
                                String imgn = rs.getString("neg_imagen1");
                                String foto = rs.getString("per_foto");
                                String colonia = rs.getString("dir_colonia");
                                String calle = rs.getString("dir_calle");
                                String desc = rs.getString("neg_descripcion");
                                int numero = rs.getInt("dir_numero");
                                int idn = rs.getInt("neg_id");
                                String direccion = colonia + ", " + calle + ", " + numero;


                    %>

                    <!-- Negocio -->
                    <section class="busq_result busq_neg" id="negbusq">
                        <section class="neg_bus_pre">
                            <img class="img_neg_busq" src="<%=img%>" alt="" id="img_loc_busq">
                            <span class="nb_busq nb" id="nb_busq"><%=nombre%></span>
                        </section>
                        <div class="line_neg_busq"></div>
                        <section class="d-flex desc_bus">
                            <section class="num_busq">
                                <span class="desc_neg_busq"><%=desc%></span>
                                <section class="d-flex dir_bus">
                                    <i class="bi bi-geo-alt-fill"></i>
                                    <span id="dir_neg_busq"><%=direccion%></span>
                                </section>
                                <section class="inf_neg_busq">
                                    <i class="bi bi-heart-fill"></i> <span id="calf_neg_busq">0</span>
                                </section>
                                <section class="inf_neg_busq">
                                    <i class="bi bi-chat-square-dots-fill"></i> <span id="com_neg_busq">0</span>
                                </section>
                            </section>
                        </section>
                        <section class="d-none" id="otros_dts">
                            <input type="text" value="<%=desc%>" id="desc_busq">
                            <img src="<%=foto%>" alt="Foto Perfil Dueño" id="FP_Neg_busq">
                            <img src="<%=imgn%>" alt="Foto Del Negocio" id="FN_Neg_busq">
                            <input type="text" value="<%=nombreu%>" id="Nom_per_neg_busq">
                            <input type="text" class="d-none" value="<%=idn%>" id="id_neg_bus">
                        </section>
                    </section>

                    <%}
                        }
                    %>

                    <%
                        PreparedStatement ps2 = c.prepareStatement("SELECT p.per_foto, p.per_descripcion, per_id, u.usu_nombre, u.tip_id FROM Persona p INNER JOIN Usuario u ON u.usu_id=p.usu_id WHERE usu_nombre LIKE ?");
                        ps2.setString(1, "%" + bs + "%");
                        rs2 = ps2.executeQuery();
                        if (rs2 != null)
                        {
                            while (rs2.next())
                            {

                                String unom = rs2.getString("usu_nombre");
                                String pfoto = rs2.getString("per_foto");
                                String descripcion = rs2.getString("per_descripcion");
                                int pid = rs2.getInt("per_id");
                                int tipo = rs2.getInt("tip_id");

                                if (tipo == 1)
                                {
                    %>

                    <!-- Usuario Normal -->
                    <form class="busq_result busq_usu nr" id="usubusq" method="post" action="VIsitar_Cuenta_Usuario.jsp" >
                        <input class="d-none" type="text" disabled>
                        <button class="d-none" type="submit" id="btn_smt_usu"></button>
                        <img src="<%=pfoto%>" class="usunr_img" id="usu_img_busq">
                        <section class="info_usu_nusq usu_nr">
                            <span class="nb_busq nb"><%=unom%></span>
                            <span class="dir_bus w-100 desc_busq"><%=descripcion%></span>
                            <i class="bi bi-person-fill usernr_icon"></i>
                        </section>
                        <input type="hidden" name="idu" value="<%=pid%>"/>
                    </form>

                    <%
                    } else if (tipo == 2)
                    {
                    %>

                    <!-- Usuario Vendedor -->
                    <form class="busq_result busq_usu" id="usubusq" method="post" action="Visitar_Vendedor_Perfil.jsp" >
                        <input class="d-none" type="text" disabled>
                        <button class="d-none" type="submit" id="btn_smt_usu"></button>
                        <img src="<%=pfoto%>" class="usuvd_img" id="usu_img_busq">
                        <section class="info_usu_nusq usu_vd">
                            <span class="nb_busq nb">Vendedor <%=unom%></span>
                            <span class="dir_bus w-100 desc_busq"><%=descripcion%></span>
                            <i class="bi bi-shop uservd_icon"></i>
                        </section>
                        <input type="hidden" name="idu" value="<%=pid%>"/>
                    </form>

                    <%
                                }
                            }
                        }
                    %>

                    <%
                        PreparedStatement ps3 = c.prepareStatement("SELECT * FROM Producto WHERE pro_nombre LIKE ?");
                        ps3.setString(1, "%" + bs + "%");
                        rs3 = ps3.executeQuery();
                        if (rs3 != null)
                        {
                            while (rs3.next())
                            {

                                String pnom = rs3.getString("pro_nombre");
                                String pimg = rs3.getString("pro_imagen");
                                int precio = rs3.getInt("pro_precio");
                                int nid = rs3.getInt("neg_id");
                    %>

                    <!-- Producto -->
                    <form class="busq_result busq_pr" id="probusq" method="post" action="NegocioSC.jsp" >
                        <input class="d-none" type="text" disabled>
                        <button class="d-none" type="submit" id="btn_smt_pro"></button>
                        <img class="img_pro_busq ipb1" src="<%=pimg%>">
                        <section class="ivbs" id="ivsy">
                            <span id="ivsy">De:</span>
                            <img class="img_vd_busq ivb1" src="src"/>
                        </section>
                        <img class="img_pro_busq ipb2" src="src"/>
                        <section class="ivbs ivbsn">
                            <span>Ofece:</span>
                            <img class="img_vd_busq ivb2" src="<%=pimg%>"/>
                        </section>
                        <section
                            class="num_pro_busq">
                            <span class="nb_busq nb"><%=pnom%></span>
                            <span>Descripción</span>
                            <hr id="lnngbs">
                            <section class="lkpr">
                                <span>$<%=precio%></span>
                                <span><i class="bi bi-heart-fill"></i> 0 Me Gusta</span>
                            </section>
                        </section>
                        <input type="hidden" name="idn" value="<%=nid%>"/>
                    </form>

                    <%
                            }
                        }
                        c.close();
                    %>

                </div>
            </div>
            <form class="w-50 h-100 cont_busq_most Inria" method="post" action="NegocioSC.jsp" >
                <input type="text" class="d-none" id="id_neg_vp" name="idn" >
                <img src="assets/neg2.jpg" alt="" class="neg_img_vp" id="neg_img_vp">
                <section class=" flex-column secc_neg_vp" id="secc_neg_vp">
                    <img src="assets/Logo_Icon.png" alt="Imgagen Negocio" class="Logo_Negocio_vp" id="Logo_Negocio_vp">
                    <span class="Nomb_pro_vp" id="Nomb_pro_vp">Nombre</span>
                    <section class="d-flex flex-column w-100 justify-content-center">
                        <section class="d-flex align-items-center nd_vp justify-content-center">
                            <img src="assets/Logo_Icon.png" alt="" class="fp_neg_vp" id="fp_neg_vp">
                            <span class="de" id="nd_vp">Nombre del dueño</span>
                        </section>
                    </section>
                    <span class="Desc_neg_vp" id="Desc_neg_vp">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dolorem expedita
                        odio minus ipsa consequuntur, vel architecto rem sed commodi enim error numquam doloremque quae
                        eaque aliquid totam corrupti voluptate itaque. Lorem ipsum dolor sit, amet consectetur adipisicing
                        elit. Ratione quam numquam excepturi quo sit non quaerat totam nam minus amet obcaecati voluptate
                        facere quia architecto dolores aperiam, beatae quidem vero.</span>
                    <section class="d-flex w-100 cont_dts_neg_vp">
                        <section class="d-flex align-items-center"><i class="bi bi-geo-alt-fill"></i> <span
                                class="dir_vp" id="dir_vp">Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum
                                quos quasi a
                                quod suscipit maiores architecto praesentium culpa nulla obcaecati dicta cumque deserunt
                                similique odio, blanditiis consequuntur. Eum, ipsam obcaecati!</span></section></section>
                    <section class="d-flex flex-column num_vp justify-content-around">
                        <section class="d-flex"><i class="bi bi-heart-fill"></i><span id="calf_neg_vp"> 000000</span></section>
                        <section class="d-flex"><i class="bi bi-chat-square-dots-fill"></i><span id="com_neg_vp">000000</span></section>
                    </section>
                    <button type="submit" class="btn_busq">Explorar Negocio</button>
                </section>


            </form>
        </div>
        <script>
            // Activar todos los tooltips
            var tooltips = new bootstrap.Tooltip(document.body, {
                selector: '[data-bs-toggle="tooltip"]',
            });
        </script>

        <script src="js/Nav.js"></script>
        <script src="js/busq.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
