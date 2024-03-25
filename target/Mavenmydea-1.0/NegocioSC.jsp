<%-- 
    Document   : Negocio
    Created on : 17 nov 2023, 10:00:43
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
<!DOCTYPE html>
<html class="scroll_none">
    <head>
        <meta name="viewport" http-equiv="Content-Type" content="width=device-width, initial-scale=1, charset=UTF-8">
        <%
            /*
    HttpSession misession = (HttpSession) request.getSession();
        Usuario usuario = (Usuario) misession.getAttribute("usuario");
        String nombreu = usuario.getUsu_nom();
        
        Persona per = (Persona) misession.getAttribute("persona");
        
        String foto = per.getPer_foto();
             */
            String id = request.getParameter("idn");

            Conexion con;
            Connection c;
            Statement stmt;
            ResultSet rs;
            String nombre = "", desc = "", dir = "", imagen1 = "", imagen2 = "", imagen3 = "", tw = "", fb = "", ig = "", web = "", tel = "", usu = "", fp = "", correo = "", logo = "", correop = "";
            int neid = 0;
            int i = 0;

        %>
        <%            con = new Conexion();
            con.setCon();
            c = con.getCon();
            stmt = c.createStatement();

            if (request.getAttribute("neid") != null)
            {

                rs = stmt.executeQuery("select n.*, u.usu_nombre, p.per_foto, p.per_correo from Negocio n inner join Persona p on p.per_id=n.per_id"
                        + " inner join Usuario u on p.usu_id=u.usu_id where n.neg_id=" + request.getAttribute("neid") + ";");
            } else
            {
                rs = stmt.executeQuery("select n.*, u.usu_nombre, p.per_foto, p.per_correo from Negocio n inner join Persona p on p.per_id=n.per_id"
                        + " inner join Usuario u on p.usu_id=u.usu_id where n.neg_id=" + id + ";");
            }
            while (rs.next())
            {
                logo = rs.getString("neg_logo");
                nombre = rs.getString("neg_nombre");
                desc = rs.getString("neg_descripcion");
                correo = rs.getString("neg_correo");
                imagen1 = rs.getString("neg_imagen1");
                imagen2 = rs.getString("neg_imagen2");
                imagen3 = rs.getString("neg_imagen3");
                tw = rs.getString("neg_twitter");
                fb = rs.getString("neg_facebook");
                fp = rs.getString("per_foto");
                correop = rs.getString("per_correo");
                web = rs.getString("neg_web");
                tel = rs.getString("neg_telefono");
                usu = rs.getString("usu_nombre");
                ig = rs.getString("neg_instagram");
                neid = rs.getInt("neg_id");
            }
            nombre = nombre.toUpperCase();

            ResultSet rs2 = stmt.executeQuery("select nh.*, h.* from Negocio_Horario nh inner join Horario h on nh.hor_id=h.hor_id where nh.neg_id =" + id + ";");
            String[] Dia = new String[7];
            String[] Abierto = new String[7];
            String[] Cerrado = new String[7];
            String[] Especial = new String[7];

            int a = 0;
            while (rs2.next())
            {

                Abierto[a] = rs2.getString("hor_abierto");
                Cerrado[a] = rs2.getString("hor_cerrado");
                Dia[a] = rs2.getString("hor_dia");
                Especial[a] = rs2.getString("hor_especial");
                a = a + 1;
            }
            int pid = 0;

            ResultSet rs4 = stmt.executeQuery("Select n.neg_id, p.per_id from Negocio n inner Join Persona p on p.per_id=n.per_id where p.per_correo='" + correop + "';");
            int num = 0;
            while (rs4.next())
            {
                num = num + 1;
                pid = rs4.getInt("per_id");
            }

            ResultSet rs5 = stmt.executeQuery("Select * from Feedback where neg_id=" + neid + ";");
            int num2 = 0;
            while (rs5.next())
            {
                num2 = num2 + 1;

            }

            String direccion = "";

            ResultSet rs8 = stmt.executeQuery("select d.*, n.*, p.usu_id, u.usu_nombre from Direccion d inner join Negocio n on d.dir_id=n.dir_id"
                    + " inner join Persona p on n.per_id = p.per_id inner join Usuario u on p.usu_id = u.usu_id where n.neg_id=" + neid + ";");

            while (rs8.next())
            {
                String colonia = rs8.getString("dir_colonia");
                String calle = rs8.getString("dir_calle");
                int numero = rs8.getInt("dir_numero");

                direccion = colonia + ", " + calle + ", " + numero;

            }

            ResultSet rm = stmt.executeQuery("Select * from Feedback where fed_like=true and neg_id=" + neid + ";");

            int lk = 0;

            while (rm.next())
            {
                lk = lk + 1;
            }

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Todas_Ref.jsp"/>
        <title><%=nombre%> - MYDEA</title>
    </head>
    <body class="nego_neg">

        <jsp:include page="templates/Navegadores/Navegador_SC.jsp"/>
        <div class="cont_neg w-100 d-flex flex-column" id="neg_bdy">

            <!---->
            <section>
                <section class="subir_neg_icon_section" id="btn_sub"><i
                        class="bi bi-arrow-up-circle-fill subir_neg_icon"></i></section>
                <div class="prestn_neg w-100">
                    <img src="<%=logo%>" alt="" class="img_fnd_neg">
                    <div class="cont_prestn_neg d-flex flex-column align-items-center justify-content-around">
                        <img src="<%=logo%>" alt="" class="img_iconn">
                        <span class="nomneg_neg"><%=nombre%></span>
                        <span class="descneg_neg"><%=desc%></span>
                        <button class="btn btn_Sen" id="btn_Sen">SEGUIR EXPLORANDO ESTE NEGOCIO</button>
                        <a href="index.jsp" class="link_salir">Salir de este Negocio</a>
                        <span class="heart_neg"><i class="bi bi-heart-fill"></i> <%=lk%></span>

                    </div>
                </div>
                <div class="neg_bdy d-flex flex-column">
                    <div class="d-flex" id="Dts_Neg">
                        <div class="d-flex flex-column p1_navn justify-content-between">
                            <!--Nav-->
                            <section class="d-flex flex-column nav_neg w-100 h-25">
                                <span><%=nombre%></span>
                                <section class="d-flex justify-content-between" id="nav_sc">
                                    <a href="#Productos_Neg">
                                        <button class="btn btn_bl">Productos</button>
                                    </a>
                                    <a href="#Imagenes_Neg">
                                        <button class="btn btn_bl">Fotos</button>
                                    </a>

                                    <a href="#resenas_otros_usuarios">
                                        <button class="btn btn_bl">Reseñas</button>
                                    </a>
                                </section>
                            </section>
                            <!--Horarios y mapa-->
                            <section class="w-100 h-75 hormap_n d-flex flex-column">
                                <span class="hu_tt">Horarios y Ubicación</span>
                                <section class="d-flex w-100 h-100 hormap_ncon">
                                    <section class="ancho">
                                        <div class="d-flex flex-column horarios_cnf" id="horarios_cnf">
                                            <span class="fw-bold">Horarios
                                                <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                   data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                            <section class="d-flex h_cnf justify-content-between h-100">
                                                <div class="line_cnf" id="line_hn"></div>
                                                <ul class="h-100 d-flex flex-column justify-content-between ds_cnf">
                                                    <li class="form-check">
                                                        <input class="form-check-input" type="radio" name="flexRadioDefault"
                                                               id="lunes" checked />
                                                        <label class="form-check-label" for="lunes">
                                                            Lunes
                                                        </label>
                                                    </li>
                                                    <li class="form-check">
                                                        <input class="form-check-input" type="radio" name="flexRadioDefault"
                                                               id="martes" />
                                                        <label class="form-check-label" for="martes">
                                                            Martes
                                                        </label>
                                                    </li>
                                                    <li class="form-check">
                                                        <input class="form-check-input" type="radio" name="flexRadioDefault"
                                                               id="miercoles" />
                                                        <label class="form-check-label" for="miercoles">
                                                            Miércoles
                                                        </label>
                                                    </li>
                                                    <li class="form-check">
                                                        <input class="form-check-input" type="radio" name="flexRadioDefault"
                                                               id="jueves" />
                                                        <label class="form-check-label" for="jueves">
                                                            Jueves
                                                        </label>
                                                    </li>
                                                    <li class="form-check">
                                                        <input class="form-check-input" type="radio" name="flexRadioDefault"
                                                               id="viernes" />
                                                        <label class="form-check-label" for="viernes">
                                                            Viernes
                                                        </label>
                                                    </li>
                                                    <li class="form-check">
                                                        <input class="form-check-input" type="radio" name="flexRadioDefault"
                                                               id="sabado" />
                                                        <label class="form-check-label" for="sabado">
                                                            Sábado
                                                        </label>
                                                    </li>
                                                    <li class="form-check">
                                                        <input class="form-check-input" type="radio" name="flexRadioDefault"
                                                               id="domingo" />
                                                        <label class="form-check-label" for="domingo">
                                                            Domingo
                                                        </label>
                                                    </li>
                                                </ul>
                                                <div
                                                    class="inph_cnf d-flex flex-column justify-content-center align-items-center">
                                                    <!--Horas Lunes-->
                                                    <section
                                                        class="inpb_cnf flex-column justify-content-evenly align-items-center"
                                                        id="hlunes_cnf">
                                                        <section class="d-flex flex-column">
                                                            <span>Lunes:</span>
                                                            <%
                                                                if (Abierto[0].equals("No"))
                                                                {
                                                            %>
                                                            <span><%=Especial[0]%></span>
                                                            <%
                                                            } else
                                                            {
                                                            %>
                                                            <span><%=Abierto[0]%> - <%=Cerrado[0]%></span>

                                                            <%
                                                                }
                                                            %> 
                                                        </section>
                                                    </section>
                                                    <!--Horas Martes-->
                                                    <section
                                                        class="inpb_cnf flex-column justify-content-evenly align-items-center"
                                                        id="hmartes_cnf">
                                                        <section class="d-flex flex-column">
                                                            <span>Martes:</span>
                                                            <%
                                                                if (Abierto[1].equals("No"))
                                                                {
                                                            %>
                                                            <span><%=Especial[1]%></span>
                                                            <%
                                                            } else
                                                            {
                                                            %>
                                                            <span><%=Abierto[1]%> - <%=Cerrado[1]%></span>

                                                            <%
                                                                }
                                                            %>
                                                        </section>
                                                    </section>
                                                    <!--Horas Miercoles-->
                                                    <section
                                                        class="inpb_cnf flex-column justify-content-evenly align-items-center"
                                                        id="hmiercoles_cnf">
                                                        <section class="d-flex flex-column">
                                                            <span>Miércoles:</span>
                                                            <%
                                                                if (Abierto[2].equals("No"))
                                                                {
                                                            %>
                                                            <span><%=Especial[2]%></span>
                                                            <%
                                                            } else
                                                            {
                                                            %>
                                                            <span><%=Abierto[2]%> - <%=Cerrado[2]%></span>

                                                            <%
                                                                }
                                                            %>
                                                        </section>
                                                    </section>
                                                    <!--Horas Jueves-->
                                                    <section
                                                        class="inpb_cnf flex-column justify-content-evenly align-items-center"
                                                        id="hjueves_cnf">
                                                        <section class="d-flex flex-column">
                                                            <span>Jueves:</span>
                                                            <%
                                                                if (Abierto[3].equals("No"))
                                                                {
                                                            %>
                                                            <span><%=Especial[3]%></span>
                                                            <%
                                                            } else
                                                            {
                                                            %>
                                                            <span><%=Abierto[3]%> - <%=Cerrado[3]%></span>

                                                            <%
                                                                }
                                                            %>
                                                        </section>
                                                    </section>
                                                    <!--Horas Viernes-->
                                                    <section
                                                        class="inpb_cnf flex-column justify-content-evenly align-items-center"
                                                        id="hviernes_cnf">
                                                        <section class="d-flex flex-column">
                                                            <span>Viernes:</span>
                                                            <%
                                                                if (Abierto[4].equals("No"))
                                                                {
                                                            %>
                                                            <span><%=Especial[4]%></span>
                                                            <%
                                                            } else
                                                            {
                                                            %>
                                                            <span><%=Abierto[4]%> - <%=Cerrado[4]%></span>

                                                            <%
                                                                }
                                                            %>
                                                        </section>
                                                    </section>
                                                    <!--Horas Sabado-->
                                                    <section
                                                        class="inpb_cnf flex-column justify-content-evenly align-items-center"
                                                        id="hsabado_cnf">
                                                        <section class="d-flex flex-column">
                                                            <span>Sábado:</span>
                                                            <%
                                                                if (Abierto[5].equals("No"))
                                                                {
                                                            %>
                                                            <span><%=Especial[5]%></span>
                                                            <%
                                                            } else
                                                            {
                                                            %>
                                                            <span><%=Abierto[5]%> - <%=Cerrado[5]%></span>

                                                            <%
                                                                }
                                                            %>
                                                        </section>
                                                    </section>
                                                    <!--Horas Domingo-->
                                                    <section
                                                        class="inpb_cnf flex-column justify-content-evenly align-items-center"
                                                        id="hdomingo_cnf">
                                                        <section class="d-flex flex-column">
                                                            <span>Domingo:</span>
                                                            <%
                                                                if (Abierto[6].equals("No"))
                                                                {
                                                            %>
                                                            <span><%=Especial[6]%></span>
                                                            <%
                                                            } else
                                                            {
                                                            %>
                                                            <span><%=Abierto[6]%> - <%=Cerrado[6]%></span>

                                                            <%
                                                                }
                                                            %>
                                                        </section>
                                                    </section>
                                                </div>
                                            </section>
                                        </div>
                                    </section>
                                    <section class="d-flex flex-column ancho h-100">
                                        <span class="fw-bold">Ubicación
                                            <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                               data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                        <section class="d-flex w-100">
                                            <span class="ancho dir_loc" id="dir_loc" data-bs-title="<%=direccion%>"><%=direccion%></span>
                                            <section class="w-50 d-flex align-items-center justify-content-around ">
                                                <button class="btn btn_bl" id="cop_dir">Copiar</button>
                                            </section>
                                        </section>
                                    </section>
                                </section>
                            </section>
                        </div>
                        <div class="d-flex flex-column p2_navn justify-content-between align-items-center">
                            <!--Propietario-->
                            <form class="propietario d-flex flex-column justify-content-between align-items-center" method="post">
                                <span class="fw-bold hu_tt">Propietario <i class="bi bi-question-circle"
                                                                           data-bs-toggle="tooltip" data-bs-placement="right"
                                                                           data-bs-title="Tooltip on right"></i></span>
                                <input type="text" class="Id_del_negociante d-none">
                                <button type="submit" class="prop_neg d-flex justify-content-center align-items-center">
                                    <section
                                        class="card_neg h-100 d-flex flex-column align-items-center justify-content-evenly">
                                        <section class="bord_color">
                                            <div></div>
                                        </section>
                                        <img src="<%=fp%>" alt="">
                                        <span class="nu_span_n"><%=usu%></span>
                                        <section class="d-flex w-100 justify-content-around numcont_section_n">
                                            <section class="d-flex flex-column justify-content-center align-items-center">
                                                <span class="num_span_n"><%=num%></span>
                                                <span class="txt_span_n">Número de Negocios</span>
                                            </section>
                                            <section class="d-flex flex-column justify-content-center align-items-center">
                                                <span class="num_span_n"><%=num2%></span>
                                                <span class="txt_span_n">Reseñas de Otros Usuarios</span>
                                            </section>

                                        </section>
                                    </section>

                                </button>
                            </form>
                            <!--Contactos-->
                            <section class="Contactos_section_n">
                                <span class="hu_tt">Contactos del Negocio <i class="bi bi-question-circle"
                                                                             data-bs-toggle="tooltip" data-bs-placement="right"
                                                                             data-bs-title="Tooltip on right"></i></span>
                                <section class="d-flex justify-content-between w-100 icnsc_section_n">



                                    <i class="bi bi-telephone contactos_usu_perfil" data-bs-toggle="tooltip"
                                       data-bs-placement="bottom" data-bs-title="<%=tel%>"></i>
                                    <i class="bi bi-envelope-fill contactos_usu_perfil" data-bs-toggle="tooltip"
                                       data-bs-placement="bottom" data-bs-title="<%=correo%>"></i>

                                    <%
                                        if (fb.equals(""))
                                        {
                                        } else
                                        {

                                    %>
                                    <a href="<%=fb%>" class="contact_red_cu"><i
                                            class="bi bi-facebook contact_red_cu" data-bs-toggle="tooltip"
                                            data-bs-placement="bottom" data-bs-title="Facebook"></i></a>
                                        <%
                                            }

                                            if (ig.equals(""))
                                            {
                                            } else
                                            {
                                        %>
                                    <a href="<%=ig%>" class="contact_red_cu"><i
                                            class="bi bi-instagram contact_red_cu" data-bs-toggle="tooltip"
                                            data-bs-placement="bottom" data-bs-title="Instageam"></i></a>
                                        <%
                                            }

                                            if (tw.equals(""))
                                            {
                                            } else
                                            {
                                        %>                               
                                    <a href="<%=tw%>" class="contact_red_cu"><i
                                            class="bi bi-twitter contact_red_cu" data-bs-toggle="tooltip"
                                            data-bs-placement="bottom" data-bs-title="Twitter"></i></a>
                                        <%
                                            }

                                            if (web.equals(""))
                                            {
                                            } else
                                            {
                                        %>  
                                    <a href="<%=web%>" class="contact_red_cu"><i
                                            class="bi bi-globe2 contact_red_cu" data-bs-toggle="tooltip"
                                            data-bs-placement="bottom" data-bs-title="Pagina Web"></i></a>
                                        <%
                                            }


                                        %>    

                                </section>
                            </section>
                        </div>
                    </div>
                    <form class="d-flex flex-column" id="Productos_Neg">
                        <span class="tittle_n">Productos</span>
                        <div class="w-100 products_div_n justify-content-between d-flex">
                            <div class="flex-column justify-content-between sp_div_n">
                                <img src="<%=logo%>" alt="" id="img_L_pr">
                                <button type="button" class="btn btn_sp btn_active btn_general"
                                        id="general_most">General</button>
                                <button type="button" class="btn btn_sp sp_div_n_desactive" id="precios_most_mn">Menor a Mayor Precio</button>
                                <button type="button" class="btn btn_sp sp_div_n_desactive" id="precios_most_nm">Mayor a Menor Precio</button>
                                <button type="button" class="btn btn_sp sp_div_n_desactive" id="pro_most_nue">Nuevos Productos</button>
                                <button type="button" class="btn btn_sp sp_div_n_desactive" id="pro_most_ant">Productos Antiguos</button>
                                <select class="select_sp" id="select_sp">
                                    <option selected disabled hidden>Disponibilidad</option>
                                    <option value="Disponible en todo momento">Disponible en todo momento</option>
                                    <option value="Por Pedido">Por pedido</option>
                                    <option value="Mayoreo">Mayoreo</option>
                                    <option value="Solo por Unidad">Solo por unidad</option>
                                    <option value="Disponible por un tiempo">Disponible por un tiempo</option>
                                    <option value="Proximamente">Próximamente</option>
                                    <option value="General">General</option>
                                </select>
                            </div>
                            <div class="d-flex flex-column justify-content-between productos_most p-2">
                                <section class="w-100 d-flex buscpro_form_n">
                                    <input type="text" class="form-control" placeholder="Buscar un producto específico" id="Busq_Pro_inp_n">
                                </section>

                                <section class="Mostrar_Productos">
                                    <span class="Mostrar_Productos_busq">Mostrar Productos: "<span
                                            id="Busqueda_pro">General</span>"</span>
                                    <div class="Productos_most" id="Cont_pr_most">

                                        <%

                                            ResultSet pr, it;

                                            String sl = "Select * from Producto where neg_id=" + id + ";";

                                            it = stmt.executeQuery(sl);
                                            int z = 0;
                                            while (it.next())
                                            {
                                                z = z + 1;
                                            }

                                            String[] pi = new String[z];

                                            String sq = "select p.*, d.dis_nombre from Producto p inner join Disponibilidad d on p.dis_id=d.dis_id where p.neg_id=" + id + ";";

                                            pr = stmt.executeQuery(sq);
                                            int y = 0;
                                            while (pr.next())
                                            {

                                                String np = pr.getString("pro_nombre");
                                                int pre = pr.getInt("pro_precio");
                                                pi[y] = pr.getString("pro_imagen");
                                                String dis = pr.getString("dis_nombre");
                                                String pd = pr.getString("pro_descripcion");

                                        %>

                                        <section class="card_pro_most card_pro_most_active" id="card_pro_neg">
                                            <span class="pre_sl">$<div class="pre_most_pro" id="pre_most_pro"><%=pre%>
                                                </div>
                                            </span>
                                            <img src="<%=pi[y]%>" class="card-img-top img_most" alt="..." id="card-img-top">
                                            <input type="text" class="dis_most_pro" value="<%=dis%>" disabled>
                                            <span class="card-title tt_pro_most" id="tt_pro_most"><%=np%></span>
                                            <span class="card-text dis_most_pro" id="desc_com_pro"><%=pd%></span>
                                        </section>
                                        
                                        

                                        <%
                                                y = y + 1;
                                            }
                                        %>

                                    </div>

                            </div>
                        </div>
                    </form>
                    <div class="Imagenes_Neg" id="Imagenes_Neg">
                        <span class="tittle_n">Fotografías</span>
                        <section class="d-flex bnts_img_sec">
                            <button class="btns_img" Id="btns_imgn">Negocio</button>
                            <button class="btnd_img" id="btns_imgp">Productos</button>
                        </section>
                        <div class="most_img_div">
                            <section class="imgneg">
                                <img src="<%=imagen1%>" alt="">
                            </section>
                            <section class="imgneg">
                                <img src="<%=imagen2%>" alt="">
                            </section>
                            <section class="imgneg">
                                <img src="<%=imagen3%>" alt="">
                            </section>

                            <%
                                for (int q = 0; q < y; q++)
                                {


                            %>

                            <section class="imgpro">
                                <img src="<%=pi[q]%>" alt="">
                            </section>

                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="resenas_otros_usuarios" id="resenas_otros_usuarios">
                        <span class="tittle_n">Reseñas</span>
                        <section class="d-none justify-content-between">
                            <button class="esc_res" id="esc_res">Escribir una Reseña</button>
                        </section>
                        <div class="hacer_resena_neg w-50 d-none" id="hacer_resena_neg">
                            <section class="d-flex w-100 w-75 comment_realizar_div comment_realizar_div2" method="post">
                                <section class="comment_realizar" id="comment_realizar">
                                    <textarea name="coment_prod_usu_n" id="coment_prod_usu_n" class="coment_prod_usu"
                                              placeholder="Escribir un comentario"></textarea>
                                    <hr>
                                    <section>
                                        <button type="button" id="cancelar_resena_neg">Cancelar</button>
                                    </section>
                                </section>
                                <section class="heart_pro_res d-flex flex-column">
                                    <label for="like_neg">
                                        <i class="bi bi-heart h_sc" id="h_sc_n" data-bs-toggle="tooltip"
                                           data-bs-placement="bottom" data-bs-title="Me Gusta"></i>
                                    </label>
                                    <label for="like_neg">
                                        <i class="bi bi-heart-fill h_cc" id="h_cc_n" data-bs-toggle="tooltip"
                                           data-bs-placement="bottom" data-bs-title="Ya no me Gusta"></i>
                                    </label>
                                    <input type="checkbox" name="like_neg" id="like_neg" class="d-none">
                                    <input type="hidden" name="idn" value="<%=id%>"/>
                                </section>
                            </section>
                        </div>

                        <section class="res_neg_ou">
                            <button id="prev_ros" class="btn prev_ros"><i class="bi bi-caret-left"></i></button>
                            <button id="next_ros" class="btn next_ros"><i class="bi bi-caret-right"></i></button>
                            <div class="d-flex res_neg_ou_div" id="res_neg_ou">

                                <%

                                    ResultSet rs7 = stmt.executeQuery("select u.usu_nombre, f.fed_comentario, f.fed_like, p.per_foto from Usuario u inner join Persona p "
                                            + "on p.usu_id = u.usu_id inner join Feedback f on f.per_id = p.per_id where f.neg_id=" + neid + ";");

                                    while (rs7.next())
                                    {

                                        String nomu = rs7.getString("usu_nombre");
                                        String ft = rs7.getString("per_foto");
                                        String comentario = rs7.getString("fed_comentario");
                                        Boolean like = rs7.getBoolean("fed_like");
                                %>

                                <section class="resena_usua_esp d-flex flex-column">
                                    <section
                                        class="d-flex justify-content-around flex-column align-items-center comentario_n">
                                        <img src="<%=ft%>" alt="">
                                        <section class="d-flex flex-column align-items-center">
                                            <span><%=nomu%></span>
                                            <%
                                                if (like == true)
                                                {
                                            %>
                                            <span><i class="bi bi-heart-fill" id="h_sc"></i> Le gustó este Negocio</span>
                                            <%
                                                }
                                            %>

                                        </section>
                                    </section>
                                    <span class="texto_res_usu"><%=comentario%></span>
                                </section>

                                <%
                                    }
                                %>
                            </div>
                        </section>
                    </div>
                    <section class="w-100 d-flex justify-content-center repo_btn">
                        <button class="p-2 btn" id="Reporte"><i class="bi bi-flag-fill"></i> Reportar Negocio</button>
                    </section>
                    <!--FOOTER-->
                    <footer class="footeri" id="footer_n">
                        <div class="contacts-section">
                            <section class="contacts-section1">

                                <section class="line-footer"></section>
                                <div class="contacts-footer">
                                    <section class="facebook-contact">
                                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" class="facebook-footer"
                                             id="facebook-footer"
                                             viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                                        <path
                                            d="M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z" />
                                        </svg>
                                    </section>
                                    <section class="instragram-contact">
                                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" class="instagram-footer"
                                             id="instagram-footer"
                                             viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                                        <path
                                            d="M224.1 141c-63.6 0-114.9 51.3-114.9 114.9s51.3 114.9 114.9 114.9S339 319.5 339 255.9 287.7 141 224.1 141zm0 189.6c-41.1 0-74.7-33.5-74.7-74.7s33.5-74.7 74.7-74.7 74.7 33.5 74.7 74.7-33.6 74.7-74.7 74.7zm146.4-194.3c0 14.9-12 26.8-26.8 26.8-14.9 0-26.8-12-26.8-26.8s12-26.8 26.8-26.8 26.8 12 26.8 26.8zm76.1 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM398.8 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z" />
                                        </svg>
                                    </section>
                                    <section class="youtube-contact">
                                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" class="youtube-footer"
                                             id="youtube-footer"
                                             viewBox="0 0 576 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                                        <path
                                            d="M549.655 124.083c-6.281-23.65-24.787-42.276-48.284-48.597C458.781 64 288 64 288 64S117.22 64 74.629 75.486c-23.497 6.322-42.003 24.947-48.284 48.597-11.412 42.867-11.412 132.305-11.412 132.305s0 89.438 11.412 132.305c6.281 23.65 24.787 41.5 48.284 47.821C117.22 448 288 448 288 448s170.78 0 213.371-11.486c23.497-6.321 42.003-24.171 48.284-47.821 11.412-42.867 11.412-132.305 11.412-132.305s0-89.438-11.412-132.305zm-317.51 213.508V175.185l142.739 81.205-142.739 81.201z" />
                                        </svg>
                                    </section>
                                    <section class="link-contact">
                                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" class="link-footer"
                                             id="link-footer"
                                             viewBox="0 0 640 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                                        <path
                                            d="M579.8 267.7c56.5-56.5 56.5-148 0-204.5c-50-50-128.8-56.5-186.3-15.4l-1.6 1.1c-14.4 10.3-17.7 30.3-7.4 44.6s30.3 17.7 44.6 7.4l1.6-1.1c32.1-22.9 76-19.3 103.8 8.6c31.5 31.5 31.5 82.5 0 114L422.3 334.8c-31.5 31.5-82.5 31.5-114 0c-27.9-27.9-31.5-71.8-8.6-103.8l1.1-1.6c10.3-14.4 6.9-34.4-7.4-44.6s-34.4-6.9-44.6 7.4l-1.1 1.6C206.5 251.2 213 330 263 380c56.5 56.5 148 56.5 204.5 0L579.8 267.7zM60.2 244.3c-56.5 56.5-56.5 148 0 204.5c50 50 128.8 56.5 186.3 15.4l1.6-1.1c14.4-10.3 17.7-30.3 7.4-44.6s-30.3-17.7-44.6-7.4l-1.6 1.1c-32.1 22.9-76 19.3-103.8-8.6C74 372 74 321 105.5 289.5L217.7 177.2c31.5-31.5 82.5-31.5 114 0c27.9 27.9 31.5 71.8 8.6 103.9l-1.1 1.6c-10.3 14.4-6.9 34.4 7.4 44.6s34.4 6.9 44.6-7.4l1.1-1.6C433.5 260.8 427 182 377 132c-56.5-56.5-148-56.5-204.5 0L60.2 244.3z" />
                                        </svg>
                                    </section>
                                </div>
                                <section class="line-footer"></section>
                            </section>
                        </div>
                        <div class="footer-section">
                            <img src="assets/mydea_com.png" alt="logo-footer" class="logo-footer">
                            <span class="ethev">Todos los derechos de uso son exclusivos de ETHEV</span>
                            <section class="line-footer2"></section>
                            <div class="more-footer">
                                <a href="indexCC.jsp">Regresar al Inicio</a>
                                <a href="">Explora más Negocios</a>
                                <a href="">Regístrate</a>
                                <a href="">Inicia Sesión</a>
                                <a href="">Términos y Condiciones</a>
                                <a href="">Aviso de Privacidad</a>
                            </div>
                        </div>
                    </footer>
                </div>
            </section>
        </div>

        <!--Producto-->
        <div class="Prod_most_espe align-items-center justify-content-center h-100 w-100 flex-column"
             id="producto_epecifico">
            <div class="producto_epecifico_contenedor">
                <section class="btns_pro_most_esp_res">
                    <button class="btn btns_pro_most bpmer_active" id="IDP">Información del producto</button>
                </section>
                <div class="Prod_most_espe_cont justify-content-around">
                    <div class="Prod_most_espe_cont1 w-100 h-100 justify-content-around" id="Prod_most_espe_cont1">
                        <img src="assets/neg1.jpg" alt="" class="h-100 img_pro_mosr_espe" id="img_pro_mosr_espe" >
                        <section class="d-flex flex-column h-100 secc_pro_most_espe">
                            <span id="npv_pro_esp">Nombre del Producto Vendido</span>
                            <span id="pre_pro_esp">$000000.00</span>
                            <span id="des_pro_esp">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Placeat eum
                                distinctio ipsum nostrum
                                labore veritatis id quia reiciendis animi at odio sunt maxime eaque ipsa natus iusto,
                                possimus
                                facere vitae.</span>
                            <span id="dis_pro_esp">Disponibilidad</span>
                        </section>
                    </div>
                </div>
            </div>
            <span class="text_inst_pro_espe">Si desea salir dé click fuera de esta ventana emergente</span>
        </div>

        <!--Reporte-->
        <form class="Emergente_Reporte" id="Emergente_Reporte" method="post">
            <div class="Reporte_Emer">
                <div class="TxtReport">
                    <span>REPORTE</span>
                    <i class="bi bi-exclamation-circle-fill Info" data-bs-toggle="tooltip" data-bs-placement="right"
                       data-bs-title="Este reporte será compartido con los administradores quienes tomarán las medidas necesarias, muchas gracias por su aporte."></i>
                </div>
                <span class="Tipo_Reporte_Txt" id="Tipo_Reporte_Txt"></span>
                <ul class="Opciones_Reporte" id="Opciones_Reporte">
                    <li>
                        <span>Por favor elija por que quiere reportar este negocio:</span>
                    </li>
                    <li>
                        <input type="radio" name="PSA" id="PSA"
                               value="Productos o servicios atrevidos o con intenciones sexuales" class="Option_R"><label
                               for="PSA"> Productos o servicios atrevidos o con intenciones sexuales</label>
                    </li>
                    <li>
                        <input type="radio" name="PSR" id="PSR"
                               value="Productos o servicios repulsivos o que inciten a la violencia" class="Option_R"><label
                               for="PSR">Productos o servicios repulsivos o que inciten a la violencia</label>
                    </li>

                    <li>
                        <input type="radio" name="IED" id="IED" value="Información erronea o desactualizada"
                               class="Option_R"><label for="IED">Información erronea o desactualizada</label>
                    </li>
                    <li>
                        <input type="radio" name="PST" id="PST" value="Productos o servicios que fomenten el terrorismo"
                               class="Option_R"><label for="PST">Productos o servicios que fomenten el terrorismo</label>
                    </li>
                    <li>
                        <input type="radio" name="PSM" id="PSM"
                               value="Productos o servicios que involucren el maltrato o abuso de personas"
                               class="Option_R"><label for="PSM">Productos o servicios que involucren el maltrato o abuso de
                            personas</label>
                    </li>
                    <li>
                        <input type="radio" name="PSE" id="PSE" value="Productos o servicios engañosos"
                               class="Option_R"><label for="PSE">Productos o servicios engañosos</label>
                    </li>
                    <li>
                        <input type="radio" name="RUP" id="RUP" value="Usuario Peligroso" class="Option_R"><label
                            for="RUP">Usuario Peligroso</label>
                    </li>
                    <li>
                        <input type="radio" name="PSP" id="PSP" value="Pesimos Servicios o Productos"
                               class="Option_R"><label for="PSP">Pesimos Servicios o Productos</label>
                    </li>
                    <li>
                        <input type="radio" name="OTH" id="OTH" value="Otro" class="Option_R"><label for="OTH">Otro</label>
                    </li>
                </ul>
                <section class="Formalario_R" id="Input_Form">
                    <textarea class="Input_Form" placeholder="Por favor especifique la razon de su reporte"></textarea>
                </section>
                <section class="Botones_Reporte">
                    <button id="Cancelar_R" type="button">Cancelar</button>
                    <button id="Continuar_R" type="button">Siguiente</button>
                    <button id="Regresar" class="Regresar" type="button"><i class="bi bi-arrow-bar-left"></i>
                        Regresar</button>
                    <button id="Enviar_R" class="Enviar_R" type="submit">Enviar Reporte</button>
                </section>
            </div>
        </form>
        <%
            c.close();
        %>

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
        <script src="js/Nav.js"></script>
        <script src="js/negocio.js"></script>
        <script src="js/cu.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
