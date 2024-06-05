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
<%@page import="org.owasp.encoder.Encode" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Ref_Admin.jsp"/>
        <title>Busqueda - <%=Encode.forHtml(request.getParameter("txt"))%></title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>
        <div class="busq_cont_prin">
            <div class="w-100 h-100 cont_busq_res_txt d-flex flex-column Inria">
                <section>
                    <span class="busqueda">"<%=Encode.forHtml(request.getParameter("txt"))%>"</span>
                    <section class="botones_busq">
                        <button class="btn_busq" id="General_btn_busq">General</button>
                        <button class="btn_busq" id="Productos_btn_busq">Productos</button>
                        <button class="btn_busq" id="Negocios_btn_busq">Negocios</button>
                        <button class="btn_busq" id="Usuarios_btn_busq">Usuarios</button>
                        <button class="btn_busq" id="Vendedores_btn_busq">Vendedores</button>
                        <button class="btn_busq" id="Comentarios_btn_busq">Comentarios</button>
                        <button class="btn_busq" id="Novedades_btn_busq">Novedades</button>
                        <select class="opt_busq_ad" id="Creado_AntDes">
                            <option selected disabled hidden>Seleccione Fecha</option>
                            <option value="AntesDe">Creado Antes De:</option>
                            <option value="DespuesDe">Creado Despues De:</option>
                        </select>
                        <input class="opt_busq" type="date" id="FechaAntDes" disabled>
                    </section>
                </section>
                <div class="cont_busq_res">

                    <%
                        String enctxt = Encode.forHtml(request.getParameter("txt"));
                        String bs = enctxt;
                        Conexion con;
                        Connection c;
                        Statement stmt;
                        ResultSet rs, rs2, rs3, rs4, rs5, rs6, rs7;

                        int id;
                        int i = 0;

                    %>
                    <%            con = new Conexion();
                        con.setCon();
                        c = con.getCon();
                        stmt = c.createStatement();

                        int contador = 0;

                        PreparedStatement ps4 = c.prepareStatement("SELECT n.*,d.*,p.per_foto,u.usu_nombre FROM Direccion d INNER JOIN "
                                + "Negocio n ON n.dir_id=d.dir_id INNER JOIN Persona p ON n.per_id = p.per_id INNER JOIN Usuario u ON"
                                + " p.usu_id = u.usu_id WHERE n.neg_activo = true AND neg_nombre LIKE ?");
                        ps4.setString(1, "%" + bs + "%");
                        rs4 = ps4.executeQuery();
                        if (rs4 != null)
                        {
                            while (rs4.next())
                            {
                                contador = contador + 1;

                            }
                        }

                        int[] ids = new int[contador];
                        int cont = 0;
                        PreparedStatement ps5 = c.prepareStatement("SELECT n.*,d.*,p.per_foto,u.usu_nombre FROM Direccion d INNER JOIN "
                                + "Negocio n ON n.dir_id=d.dir_id INNER JOIN Persona p ON n.per_id = p.per_id INNER JOIN Usuario u ON"
                                + " p.usu_id = u.usu_id WHERE n.neg_activo = true AND neg_nombre LIKE ?");
                        ps5.setString(1, "%" + bs + "%");
                        rs5 = ps5.executeQuery();
                        if (rs5 != null)
                        {
                            while (rs5.next())
                            {

                                ids[cont] = rs5.getInt("neg_id");
                                cont = cont + 1;
                            }
                        }

                        int cont2 = 0;
                        int[] nlike = new int[contador];
                        int[] ncomentario = new int[contador];
                        int cont3 = 0;
                        int cont4 = 0;
                        int cont5 = 0;

                        for (int f = 0; f < contador; f++)
                        {
                            rs6 = stmt.executeQuery("Select * from Feedback where neg_id=" + ids[cont2] + " and fed_like=true;");

                            while (rs6.next())
                            {
                                cont3 = cont3 + 1;
                            }
                            nlike[cont2] = cont3;
                            cont3 = 0;
                            cont2 = cont2 + 1;
                        }

                        for (int f = 0; f < contador; f++)
                        {
                            rs7 = stmt.executeQuery("Select * from Feedback where neg_id=" + ids[cont4] + ";");

                            while (rs7.next())
                            {
                                cont5 = cont5 + 1;
                            }
                            ncomentario[cont4] = cont5;
                            cont5 = 0;
                            cont4 = cont4 + 1;
                        }

                        int cont6 = 0;
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
                                String fecha =rs.getString("neg_fecha");

                    %>

                    <!-- Negocio -->
                    <section class="busq_result busq_neg" id="negbusq">
                        <input class="d-none" id="fecha_inp_busq" type="date" disabled value="<%=fecha%>">
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
                                    <i class="bi bi-heart-fill"></i> <span id="calf_neg_busq"><%=nlike[cont6]%></span>
                                </section>
                                <section class="inf_neg_busq">
                                    <i class="bi bi-chat-square-dots-fill"></i> <span id="com_neg_busq"><%=ncomentario[cont6]%></span>
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

                    <%
                                cont6 = cont6 + 1;
                            }
                        }
                    %>

                    <%
                        PreparedStatement ps2 = c.prepareStatement("SELECT p.per_foto, p.per_fecha, p.per_descripcion, per_id, u.usu_nombre, u.tip_id FROM Persona p INNER JOIN Usuario u ON u.usu_id=p.usu_id WHERE u.usu_activo=true and u.usu_nombre ILIKE ?");
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
                                String fecha = rs2.getString("per_fecha");

                                if (tipo == 1)
                                {
                    %>

                    <!-- Usuario Normal -->
                    <form class="busq_result busq_usu nr" id="usubusq" method="post" action="Visitar_Cuenta_UsuarioCA.jsp" >
                        <input class="d-none" id="Nombre_comp_usu" type="text" disabled value="Nombre Completo Usuario">
                        <input class="d-none" id="nlu_usu" type="text" disabled value="Numero de Likes Dados">
                        <input class="d-none" id="ncu_usu" type="text" disabled value="Numero de Reseñas Hechas">
                        <input class="d-none" id="Nombre_comp_usu" type="text" disabled value="Nombre Comleto Usuario">
                        <input class="d-none" id="fecha_inp_busq" type="date" disabled value="<%=fecha%>">
                        <button class="d-none" type="submit" id="btn_smt_usu"></button>
                        <img src="<%=pfoto%>" class="usunr_img" id="usu_img_busq">
                        <section class="info_usu_nusq usu_nr">
                            <span class="nb_busq nb"><%=unom%></span>
                            <input class="d-none" type="text" id="nom_usu_ck" value="<%=unom%>" disabled>
                            <span class="dir_bus w-100 desc_busq" id="desc_busq_usu"><%=descripcion%></span>
                            <i class="bi bi-person-fill usernr_icon"></i>
                        </section>
                        <input type="hidden" id="idu" name="idu" value="<%=pid%>"/>
                    </form>

                    <%
                    } else if (tipo == 2)
                    {
                    %>

                    <!-- Usuario Vendedor -->
                    <form class="busq_result busq_usu" id="vendbusq" method="post" action="Visitar_Vendedor_PerfilCA.jsp" >
                        <input class="d-none" id="Nombre_comp_usuv" type="text" disabled value="Nombre Completo Vendedor">
                        <input class="d-none" id="nnuv_usu" type="text" disabled value="Numero de negocios a su nombre">
                        <input class="d-none" id="nluv_usu" type="text" disabled value="Numero de Likes Dados">
                        <input class="d-none" id="ncuv_usu" type="text" disabled value="Numero de Reseñas Hechas">
                        <input class="d-none" id="fecha_inp_busq" type="date" disabled value="<%=fecha%>">
                        <button class="d-none" type="submit" id="btn_smt_usu"></button>
                        <img src="<%=pfoto%>" class="usuvd_img" id="usu_img_busq">
                        <section class="info_usu_nusq usu_vd">
                            <span class="nb_busq nb">Vendedor <%=unom%></span>
                            <input class="d-none" type="text" id="nom_usu_ck" value="<%=unom%>" disabled>
                            <span class="dir_bus w-100 desc_busq" id="desc_busq_usu"><%=descripcion%></span>
                            <i class="bi bi-shop uservd_icon"></i>
                        </section>
                        <input type="hidden" name="idu" id="idu" value="<%=pid%>"/>
                    </form>

<%

                            }
                        }
}
                    %>

                    <%
                        PreparedStatement ps3 = c.prepareStatement("SELECT * FROM Producto p inner join Negocio n on p.neg_id=n.neg_id"
                                + " WHERE p.pro_nombre LIKE ?");
                        ps3.setString(1, "%" + bs + "%");
                        rs3 = ps3.executeQuery();
                        if (rs3 != null)
                        {
                            while (rs3.next())
                            {

                                String pnom = rs3.getString("pro_nombre");
                                String pimg = rs3.getString("pro_imagen");
                                int precio = rs3.getInt("pro_precio");
                                String desc = rs3.getString("pro_descripcion");
                                int nid = rs3.getInt("neg_id");
                                String nimg = rs3.getString("neg_logo");
                                String fecha = rs3.getString("pro_fecha");
                    %>

                    <!-- Producto -->
                    <form class="busq_result busq_pr" id="probusq" method="post" action="NegociosCA.jsp" >
                        <input class="d-none" type="text" id="nom_neg_ofr" disabled value="Nombre del negocio que lo ofrefe">
                        <input class="d-none" id="fecha_inp_busq" type="date" disabled value="<%=fecha%>">
                        <button class="d-none" type="submit" id="btn_smt_pro"></button>
                        <img class="img_pro_busq ipb1" id="img_pro_busq" src="<%=pimg%>">
                        <section class="ivbs" id="ivsy">
                            <span id="ivsy">De:</span>
                            <img class="img_vd_busq ivb1" id="img_vd_busq" src="<%=nimg%>"/>
                        </section>
                        <img class="img_pro_busq ipb2" src="<%=nimg%>"/>
                        <section class="ivbs ivbsn">
                            <span>Ofrece:</span>
                            <img class="img_vd_busq ivb2" src="<%=pimg%>"/>
                        </section>
                        <section
                            class="num_pro_busq">
                            <span class="nb_busq nb" id="nb_busq"><%=pnom%></span>
                            <span id="desc_pro"><%=desc%></span>
                            <hr id="lnngbs">
                            <section class="lkpr">
                                <span id="pre_pro">$<%=precio%></span>
                            </section>
                        </section>
                        <input type="hidden" id="idn_pro" name="idn" value="<%=nid%>"/>
                    </form>

                    <%
                            }
                        }
                    %>

                    <%
                    String sql = "select u.usu_nombre, f.fed_fecha, n.neg_nombre, n.neg_id, f.fed_comentario, f.fed_like, f.fed_activo, f.fed_id, u.usu_id, p.per_foto from Usuario u inner join Persona p "
                            + "on p.usu_id = u.usu_id inner join Feedback f on f.per_id = p.per_id inner join Negocio n on f.neg_id=n.neg_id where u.usu_activo=true and f.fed_activo=true;";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int idc = rs.getInt("fed_id");
                        int idn = rs.getInt("neg_id");
                        String fecha = rs.getString("fed_fecha");
                        String nomu = rs.getString("usu_nombre");
                        String nomn = rs.getString("neg_nombre");
                        String ft = rs.getString("per_foto");
                        String comentario = rs.getString("fed_comentario");
                        Boolean like = rs.getBoolean("fed_like");

                    %>
                    <section class="busq_result" id="combusq">
                        <input class="d-none" id="fecha_inp_busq" type="date" disabled value="<%=fecha%>">
                        <input class="d-none" type="text" id="nom_neg_com" disabled value="<%=nomn%>">
                        <img src="<%=ft%>" class="d-none" alt="Logo del negocio que comento" id="log_neg_com"/>
                        <section class="resena_usua_esp d-flex flex-column" id="resena_usua_esp_busq">
                            <section class="comentario_n">
                                <span id="nom_usu_com"><%=nomu%></span>
                                <img src="assets/Logo_Icon.png" alt="Img de perfil del usuario" id="img_perf_com">
                            </section>
                            <span class="texto_res_usu" id="coment_desc"><%=comentario%></span>
                            <%
                            if(like==true){
                            %>
                            <span class="liornli"><i class="bi bi-heart-fill"></i> Le gustó este Negocio</span>
                            <%
                                }
                            %>
                            <i class="bi bi-quote comment_icon_neg"></i>
                        </section>
                        <input type="hidden" id="idn_com" name="idn" value="<%=idn%>"/>
                    </section>
<%
    }
%>
                    
                    <%
                        ResultSet pr2;

                        String sl2 = "select n.neg_nombre, n.neg_id, v.* from Negocio n inner join Novedad v on n.neg_id=v.neg_id where n.neg_activo=true;";

                        String pi2 = "";

                        pr2 = stmt.executeQuery(sl2);

                        while (pr2.next())
                        {

                            String np = pr2.getString("nov_nombre");
                            int pre = pr2.getInt("neg_id");
                            pi2 = pr2.getString("nov_foto");
                            String dis = pr2.getString("neg_nombre");
                            String pd = pr2.getString("nov_descripcion");
                            String fecha = pr2.getString("nov_fecha");
                    %>
                    <!-- Novedades -->
                    <div class="busq_result nov_busq" id="novbusq">
                        <input class="d-none" id="fecha_inp_busq" type="date" disabled value="<%=fecha%>">
                        <section class="nov_desc_esp">
                            <section class="cont_anuncio">
                                <span class="tt_nov_bus"><span><%=dis%> </span> Anuncia: <br> <span class="tt_nov_esp" id="tt_nov_esp"><%=np%></span></span>
                                <span class="desc_nov_busq" id="desc_nov_busq"><%=pd%> </span>
                            </section>
                            <img class="img_nov" id="img_nov" src="<%=pi2%>" alt="alt"/>
                            <img class="img_nov_neg" id="img_nov_neg" src="<%=pi2%>" alt="alt"/>
                        </section>
                        <section class="present_nov">
                            <span class="tt_nov_pres"><%=np%></span>
                            <section>
                                <span>Una Novedad de:</span>
                                <span id="tt_nov_bus"><%=dis%></span>
                            </section>
                        </section>
                        <input type="hidden" id="idn_nov" name="idn" value="<%=pre%>"/>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                c.close();
            %>
            
            <section class="w-50 h-100 cont_busq_most Inria">
                <img src="assets/neg2.jpg" alt="" class="neg_img_vp" id="neg_img_vp">
                <!-- Vista previa Negocios -->
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
                    <section class="num_vp">
                        <section class="d-flex"><i class="bi bi-heart-fill"></i><span id="calf_neg_vp"></span><i class="bi bi-chat-square-dots-fill"></i><span id="com_neg_vp"></span></section>
                        <section class="d-flex fech_cre"> 
                            <span>Fecha de Creación: </span>
                            <input class="d-flex" type="date" id="Fech_Creacion_busq" disabled>
                        </section>
                    </section>
                    <form  method="post" action="NegociosCA.jsp">
                        <input type="text" class="d-none" id="id_neg_vp" name="idn" >
                        <button type="submit" class="btn_busq">Explorar Negocio</button>
                    </form>
                    <form action="EliminarNegocioA" class="form_elim">
                        <input type="hidden" name="idn" value=""/>
                        <input type="hidden" class="name_elim" value="ESTE NEGOCIO"/>
                        <button type="submit" class="btn btn_elimnegscr_admin" id="btn_elimnegscr_admin">Eliminar Negocio</button>
                    </form>
                </section>

                <!-- Vista previa Vendedores -->
                <section class=" flex-column secc_neg_vp" id="secc_usuv_vp">
                    <span class="Nomb_pro_vp" id="Nom_usuv_vp">Nombre</span>
                    <section class="d-flex flex-column w-100 justify-content-center">
                        <section class="d-flex align-items-center nd_vp justify-content-center">
                            <img src="" alt="" class="fp_neg_vp" id="fp_usuv_vp">
                            <span class="de" id="Nombcom_usuv_vp">Nombre del dueño</span>
                        </section>
                    </section>
                    <span class="Desc_neg_vp" id="Desc_usuv_vp">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dolorem expedita
                        odio minus ipsa consequuntur, vel architecto rem sed commodi enim error numquam doloremque quae
                        eaque aliquid totam corrupti voluptate itaque. Lorem ipsum dolor sit, amet consectetur adipisicing
                        elit. Ratione quam numquam excepturi quo sit non quaerat totam nam minus amet obcaecati voluptate
                        facere quia architecto dolores aperiam, beatae quidem vero.</span>
                    <section class="d-flex w-100 cont_dts_neg_vp">
                        <section class="d-flex align-items-center"><i class="bi bi-shop"></i>Negocios a su nombre: <span id="nnuv_vp"> 0 </span></section></section>
                    <section class="num_vp">
                        <section class="d-flex"><i class="bi bi-heart-fill"></i><span id="calf_usuv_vp"> </span><i class="bi bi-chat-square-dots-fill"></i><span id="com_usuv_vp"></span></section>
                        <section class="d-flex fech_cre"> 
                            <span>Se unió el: </span>
                            <input class="d-flex" type="date" id="Fech_Creacion_busq_usuv" disabled>
                        </section>
                    </section>
                    <form method="post" action="Visitar_Vendedor_PerfilCA.jsp">
                        <input type="text" class="d-none" id="id_usuv_vp" name="idu" >
                        <button type="submit" class="btn_busq">Visitar Cuenta</button>
                    </form>
                    <form action="EliminarUsuario" class="form_elim">
                        <input type="hidden" name="idu" value=""/>
                        <input type="hidden" class="name_elim" value="ESTE VENDEDOR"/>
                        <button type="submit" class="btn btn_elimnegscr_admin" id="btn_elimnegscr_admin">Eliminar Vendedor</button>
                    </form>
                </section>

                <!-- Vista previa Usuarios -->
                <section class=" flex-column secc_neg_vp" id="secc_usu_vp">
                    <span class="Nomb_pro_vp" id="Nom_usu_vp">Nombre</span>
                    <section class="d-flex flex-column w-100 justify-content-center">
                        <section class="d-flex align-items-center nd_vp justify-content-center">
                            <img src="" alt="" class="fp_neg_vp" id="fp_usu_vp">
                            <span class="de" id="Nombcom_usu_vp">Nombre del dueño</span>
                        </section>
                    </section>
                    <span class="Desc_neg_vp" id="Desc_usu_vp">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dolorem expedita
                        odio minus ipsa consequuntur, vel architecto rem sed commodi enim error numquam doloremque quae
                        eaque aliquid totam corrupti voluptate itaque. Lorem ipsum dolor sit, amet consectetur adipisicing
                        elit. Ratione quam numquam excepturi quo sit non quaerat totam nam minus amet obcaecati voluptate
                        facere quia architecto dolores aperiam, beatae quidem vero.</span>
                    <section class="d-flex"><i class="bi bi-heart-fill"></i><span id="calf_usu_vp"> 000000</span><i class="bi bi-chat-square-dots-fill"></i><span id="com_usu_vp">000000</span></section>
                    <section class="d-flex fech_cre"> 
                        <span>Fecha de Creación: </span>
                        <input class="d-flex" type="date" id="Fech_Creacion_busq_usu" disabled>
                    </section>
                    <form  method="post" action="Visitar_Cuenta_UsuarioCA.jsp">
                        <input type="text" class="d-none" id="id_usu_vp" name="idu" >
                        <button type="submit" class="btn_busq">Visitar Cuenta</button>
                    </form>
                    <form action="EliminarUsuario" class="form_elim">
                        <input type="hidden" name="idu" value=""/>
                        <input type="hidden" class="name_elim" value="ESTE USUARIO"/>
                        <button type="submit" class="btn btn_elimnegscr_admin" id="btn_elimnegscr_admin">Eliminar Usuario</button>
                    </form>
                </section>

                <!-- Vista previa Productos -->
                <section class=" flex-column secc_neg_vp" id="secc_pro_vp">
                    <span class="Nomb_pro_vp" id="Nom_pro_vp">Nombre del Producto</span>
                    <section class="d-flex flex-column w-100 justify-content-center">
                        <section class="d-flex align-items-center nd_vp justify-content-center">
                            <img src="" alt="" class="fp_neg_vp" id="fp_pro_vp">
                            <span class="de" id="Nombcom_pro_vp">Nombre del Negocio</span>
                        </section>
                    </section>
                    <span class="Desc_neg_vp" id="Desc_pro_vp">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dolorem expedita
                        odio minus ipsa consequuntur, vel architecto rem sed commodi enim error numquam doloremque quae
                        eaque aliquid totam corrupti voluptate itaque. Lorem ipsum dolor sit, amet consectetur adipisicing
                        elit. Ratione quam numquam excepturi quo sit non quaerat totam nam minus amet obcaecati voluptate
                        facere quia architecto dolores aperiam, beatae quidem vero.</span>
                    <span id="prec_pro_vp"></span>
                    <section class="d-flex fech_cre"> 
                        <span>Fecha de Publicación; </span>
                        <input class="d-flex" type="date" id="Fech_Creacion_busq_pro" disabled>
                    </section>
                    <form method="post" action="NegociosCA.jsp">
                        <input type="text" class="d-none" id="id_pro_vp" name="idn" >
                        <button type="submit" class="btn_busq">Visitar Negocio que lo ofrece</button>
                    </form>
                    <form action="EliminarProductoA" class="form_elim">
                        <input type="hidden" name="idp" value=""/>
                        <input type="hidden" class="name_elim" value="ESTE PRODUCTO"/>
                        <button type="submit" class="btn btn_elimnegscr_admin" id="btn_elimnegscr_admin">Eliminar Producto</button>
                    </form>
                </section>

                <!-- Vista previa Comentarios -->
                <section class=" flex-column secc_neg_vp" id="secc_com_vp">
                    <span id="Nom_com_vp_txt">Comentó a: <span class="Nomb_pro_vp" id="Nom_com_vp">Nombre del Negocio Comentado</span></span>
                    <section class="d-flex flex-column w-100 justify-content-center align-items-center">
                        <section class="d-flex nd_vp">
                            <img src="" alt="" class="fp_neg_vp" id="fp_com_vp">
                            <span class="de" id="Nombcom_com_vp">Nombre del Usuario</span>
                        </section>
                    </section>
                    <span class="Desc_neg_vp" id="Desc_com_vp"></span>
                    <span class="d-flex justify-content-center align-items-center"><i class="bi bi-heart-fill"></i> Le gustó este negocio</span>
                    <section class="d-flex fech_cre"> 
                        <span>Hecho el: </span>
                        <input class="d-flex" type="date" id="Fech_Creacion_busq_com" disabled>
                    </section>
                    <form method="post" action="NegociosCA.jsp">
                        <input type="text" class="d-none" id="id_com_vp" name="idn" >
                        <button type="submit" class="btn_busq">Visitar Negocio que Comentó</button>
                    </form>
                    <form action="EliminarComentarioA" class="form_elim">
                        <input type="hidden" name="idc" value=""/>
                        <input type="hidden" class="name_elim" value="ESTE COMENTARIO"/>
                        <button type="submit" class="btn btn_elimnegscr_admin" id="btn_elimnegscr_admin">Eliminar Comentario</button>
                    </form>
                </section>
                
                <!-- Vista previa Novedades -->
                <section class=" flex-column secc_neg_vp" id="secc_nov_vp">
                    <span class="Nomb_pro_vp" id="Nom_nov_vp">Nombre de la novedad</span>
                    <section class="d-flex flex-column w-100 justify-content-center align-items-center">
                        <section class="d-flex nd_vp">
                            <img src="" alt="" class="fp_neg_vp" id="fp_nov_vp">
                            <span class="de" id="Nombcom_nov_vp">Nombre Negocio</span>
                        </section>
                    </section>
                    <span class="Desc_neg_vp" id="Desc_com_vp"></span>
                    <span id="cont_nov_vp">Novedad</span>
                    <section class="d-flex fech_cre"> 
                        <span>Publicada el: </span>
                        <input class="d-flex" type="date" id="Fech_Creacion_busq_nov" disabled>
                    </section>
                    <form method="post" action="NegociosCA.jsp">
                        <input type="text" class="d-none" id="id_nov_vp" name="idn" >
                        <button type="submit" class="btn_busq">Visitar negocio de la Novedad</button>
                    </form>
                    <form action="EliminarNovedadA" class="form_elim">
                        <input type="hidden" name="idn" value=""/>
                        <input type="hidden" class="name_elim" value="ESTA NOVEDAD"/>
                        <button type="submit" class="btn btn_elimnegscr_admin" id="btn_elimnegscr_admin">Eliminar Novedad</button>
                    </form>
                </section>
        </div>
        <script>
            // Activar todos los tooltips
            var tooltips = new bootstrap.Tooltip(document.body, {
                selector: '[data-bs-toggle="tooltip"]',
            });
        </script>

        <script src="js/Nav.js"></script>
        <script src="js/busq_admin.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/elim.js"></script>
    </body>
</html>