<%-- 
    Document   : Editar_Producto
    Created on : 29 nov 2023, 8:17:03
    Author     : altro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession session1 = request.getSession(false);
    if (session1.getAttribute("usuario") != null)
    {

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
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CV.jsp"/>
        <%            Conexion con;
            Connection c;

            ResultSet rs, rs2, rs3;
            con = new Conexion();
            con.setCon();
            c = con.getCon();
            Statement stmt = c.createStatement();
            String id = request.getParameter("idn");
            rs2 = stmt.executeQuery("select p.*, d.dis_nombre from Producto p inner join Disponibilidad d on p.dis_id=d.dis_id where p.pro_id=1 and p.neg_id=" + id + ";");
            String np = null, img = null, dis = null, pd = null;
            int pre = 0;
            while (rs2.next())
            {
                np = rs2.getString("pro_nombre");
                pre = rs2.getInt("pro_precio");
                img = rs2.getString("pro_imagen");
                dis = rs2.getString("dis_nombre");
                pd = rs2.getString("pro_descripcion");
            }
        %>
        <div class="d-flex flex-column w-100 justify-content-between cnf1 Inria">
            <section class="color1e"></section>
            <section class="color2e"></section>
            <div class="content_form w-100">
                <section class="d-flex text-white align-items-center p1_cnf">
                    <span class="txt_prin_cnf fw-bolder">Edita los Datos de tu Producto</span>
                    <i class="bi bi-question-circle quicon_cnf_lg" data-bs-toggle="tooltip" data-bs-placement="right"
                       data-bs-title="Tooltip on right"></i>
                </section>
                <div class="p2_cnf d-flex flex-column" method="post" id="FORM_CNF">
                    <section class="d-flex p21_cnf">
                        <section class="btn btn-light btn_nav_cnf" id="Btn_DtNg">
                            Seleccionar Producto a Editar
                            <button type="button" class="btn text-white btn_nav_cnf bg-dark">
                                Editar Producto
                            </button>
                        </section>
                        <div class="p22_cnf p-4 pt-3">
                            <span class="dt_txt_cnf" id="dt_txt_cnf">Datos de Producto</span>
                            <div class="form_cnf Productos_cnf justify-content-between" id="Productos_cnf">
                                <form class="prof1_cnf d-flex flex-column" method="post">
                                    <section class="d-flex w-100 h-50 justify-content-around">

                                        <section class="prof1_s1">
                                            <section
                                                class="log_cnf d-flex flex-column justify-content-center align-items-center prof1_s11">
                                                <span class="fw-bold">Imagen del Producto o Servicio
                                                    <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                       data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                                <section class="Logo_Prev" id="Prod_Prev">
                                                    <img src="<%=img%>" alt="Logo" id="Prev_img_Prod" class="Prev_Log" />
                                                    <input type="file" class="d-none" name="Prod_cnf" id="Prod_cnf"
                                                           accept="image/png, image/jpeg" />
                                                    <i class="bi bi-image Plus_L" id="Plus_Prod"></i>
                                                </section>
                                            </section>
                                        </section>
                                        <section class="prof1_s2 d-flex flex-column justify-content-around">
                                            <section>
                                                <span class="fw-bold">Nombre del Producto o Servicio
                                                    <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                       data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                                <input type="text" class="form-control" placeholder="<%=np%>"
                                                       id="Nom_Pro_inp" />
                                            </section>
                                            <section>
                                                <span class="fw-bold">Precio del Producto o Servicio
                                                    <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                       data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                                <input type="number" class="form-control"
                                                       placeholder="$<%=pre%>" id="Pre_Prod_inp" />
                                            </section>
                                        </section>
                                    </section>
                                    <section class="d-flex flex-column w-100 h-50 justify-content-around">
                                        <section class="d-flex flex-column h-50">
                                            <span class="fw-bold">Descripcion del Producto o Servicio
                                                <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                   data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                            <textarea class="form-control txta_cnf" name="" id="Desc_Pro_inp" placeholder="$<%=pre%>"></textarea>
                                        </section>
                                        <section class="d-flex h-50 justify-content-around w-100 flex-column">
                                            <span class="fw-bold">Disponibilidad del Producto o Servicio
                                                <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                   data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                            <section class="d-flex h-50 w-100 justify-content-between align-items-center">
                                                <select class="form-select w-75" aria-label="Default select example"
                                                        id="Tip_Pro_inp">

                                                    <option value="Disponible en todo momento">Disponible en todo momento
                                                    </option>
                                                    <option value="Por Pedido">Por Pedido</option>
                                                    <option value="Mayoreo">Mayoreo</option>
                                                    <option value="Solo por Unidad">Solo por Unidad</option>
                                                    <option value="Disponible por un Tiempo">Disponible por un Tiempo</option>
                                                    <option value="Proximamente" selected>Proximamente</option>
                                                </select>
                                                <button type="submit" type="button"
                                                        class="btn btn-outline-dark btn_rosa h-75 text-white" id="btn_AProd">
                                                    Actualizar Datos
                                                </button>
                                            </section>
                                        </section>
                                    </section>
                                </form>
                                <div class="prof2_cnf">
                                    <span class="dt_txt_cnf">Lista de Productos <i class="bi bi-question-circle"
                                                                                   data-bs-toggle="tooltip" data-bs-placement="right"
                                                                                   data-bs-title="Tooltip on right"></i></span>
                                    <section class="w-100 Prod_Cont" id="Prod_Cont">
                                        <%

                                            rs = stmt.executeQuery("select p.*, d.dis_nombre from Producto p inner join Disponibilidad d on p.dis_id=d.dis_id where p.neg_id=" + id + ";");

                                            while (rs.next())
                                            {

                                                String np2 = rs.getString("pro_nombre");
                                                int pre2 = rs.getInt("pro_precio");
                                                String img2 = rs.getString("pro_imagen");
                                                String dis2 = rs.getString("dis_nombre");
                                                String pd2 = rs.getString("pro_descripcion");


                                        %>
                                        <div class="prod d-flex" id="prod1">
                                            <img src="<%=img2%>" alt="prod" class="img_prod_cnf">
                                            <input type="file" class="d-none" disabled>
                                            <section class="d-flex flex-column Prod_Lis">
                                                <input type="text" class="N_ProVP" value="<%=np2%>" disabled>
                                                <textarea type="text" class="D_ProVP" disabled><%=pd2%></textarea>
                                                <section class="d-flex w-100 justify-content-between">
                                                    <input type="text" value="$<%=pre2%>" id="precio" disabled>
                                                    <input type="text" id="dis" value="<%=dis2%>" disabled>
                                                    <form action="" method="post">
                                                        <button class="btn_elim_pro btn_rosa" type="submit">Editar</button>
                                                    </form>
                                                    <form action="" method="post">
                                                        <button class="btn_elim_pro btn_rosa" type="submit">Eliminar</button>
                                                    </form>
                                                </section>
                                            </section>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </section>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
        <%  } else
            {
                System.out.println("Error: Sesión no existe");
                response.sendRedirect("index.jsp");
            }
        %>
        <script>
            // Activar todos los tooltips
            var tooltips = new bootstrap.Tooltip(document.body, {
                selector: '[data-bs-toggle="tooltip"]',
            });
        </script>
    </body>
</html>
