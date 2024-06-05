<%-- 
    Document   : Gest_neg
    Created on : 22 abr 2024, 17:23:05
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
        <title>Gestionar Novedades</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CA.jsp"/>

        <div class="gestion_tickets_container" id="gestion_usu_container">
            <div class="controlls_gest_tick" id="controlls_gest_usu">
                <div class="fltr_tickets" id="fltr_tickets">
                    <section class="busq_admin_acc">
                        <input class="form-control bus_admin_acc" id="bus_admin_acc" type="text"
                               placeholder="Buscar Negocio">
                        <i class="bi bi-search text-white"></i>
                    </section>
                    <section class="opt_admin">
                        <select class="select_adm" id="filtr_est">
                            <option selected disabled hidden>Filtrar por Estado</option>
                            <option value="true">Negocio Activo</option>
                            <option value="false">De Baja</option>
                            <option value="General">Cualquiera</option>
                        </select>
                    </section>
                </div>
            </div>
            <div class="tickets_container container_admin" id="neg_container_admin">
                <%
                        Conexion con;
                        Connection c;
                        Statement stmt;
                        ResultSet rs, rs2, rs3, rs4, rs5;
                
                               con = new Conexion();
                        con.setCon();
                        c = con.getCon();
                        stmt = c.createStatement();
                        
                       int contador =0;
                        
                        rs2 = stmt.executeQuery("select d.*, n.*, p.usu_id, u.usu_nombre from Direccion d inner join Negocio n on d.dir_id=n.dir_id inner join Persona "
                                + "p on n.per_id = p.per_id inner join Usuario u on p.usu_id = u.usu_id;");
                        if (rs2 != null)
                        {
                            while (rs2.next())
                            {
                            contador = contador + 1;
                            
                            }
                    }
                    
                    
                    int[] ids = new int[contador];
                    int cont = 0;
                    rs3 = stmt.executeQuery("select d.*, n.*, p.usu_id, u.usu_nombre from Direccion d inner join Negocio n on d.dir_id=n.dir_id inner join Persona "
                                + "p on n.per_id = p.per_id inner join Usuario u on p.usu_id = u.usu_id;");
                       
                        if (rs3 != null)
                        {
                            while (rs3.next())
                            {
                            
                                ids[cont] = rs3.getInt("neg_id");
                                cont=cont +1;
                            }
                    }
                    
                    int cont2 =0;
                    int[] nlike = new int[contador];
                    int[] ncomentario = new int[contador];
                    int cont3 = 0;
                    int cont4=0;
                    int cont5=0;
                    
                    for (int f = 0; f < contador; f++) {
                           rs4 = stmt.executeQuery("Select * from Feedback where neg_id="+ids[cont2]+" and fed_like=true;"); 
                           
                           while(rs4.next()){
                           cont3= cont3 +1;
                    }
                           nlike[cont2]=cont3;
                           cont3=0;
                           cont2= cont2+1;
                        }
                        
                    for (int f = 0; f < contador; f++) {
                           rs5 = stmt.executeQuery("Select * from Feedback where neg_id="+ids[cont4]+";"); 
                           
                           while(rs5.next()){
                           cont5= cont5 +1;
                    }
                           ncomentario[cont4]=cont5;
                           cont5=0;
                           cont4= cont4+1;
                        }
                    
                    
                    
                        
                       int cont6 = 0; 
                       
                         rs = stmt.executeQuery("select d.*, n.*, p.usu_id, u.usu_nombre from Direccion d inner join Negocio n on d.dir_id=n.dir_id inner join Persona "
                                + "p on n.per_id = p.per_id inner join Usuario u on p.usu_id = u.usu_id;");

                        while (rs.next()) {

                            String nombre = rs.getString("neg_nombre");
                            String nombreu = rs.getString("usu_nombre");
                            String img = rs.getString("neg_logo");
                            String desc = rs.getString("neg_descripcion");
                            String colonia = rs.getString("dir_colonia");
                            String calle = rs.getString("dir_calle");
                            Boolean activo = rs.getBoolean("neg_activo");
                            int numero = rs.getInt("dir_numero");
                            int id = rs.getInt("neg_id");
                            String direccion = colonia + ", " + calle + ", " + numero;
                 %>
                <!-- Novedad -->
                <section class="busq_result busq_neg" id="negbusq">
                    <input type="hidden" name="name" value="<%=activo%>" id="inp_activo">
                    <section class="neg_bus_pre">
                        <img class="img_neg_busq" src="<%=img%>" alt="" id="img_loc_busq">
                        <span class="nb_busq nb busqueda_nombre" id="nb_busq"><%=nombre%></span>
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
                                <i class="bi bi-heart-fill"></i><%=nlike[cont6]%><span id="calf_neg_busq"></span>
                            </section>
                            <section class="inf_neg_busq">
                                <i class="bi bi-chat-square-dots-fill"></i><%=ncomentario[cont6]%><span id="com_neg_busq"></span>
                            </section>
                            <section class="form_admin_nego">
                                <%
                                if(activo==true){
                                %>
                                <form action="EliminarNegocioA">
                                    <button id="baja_usu">Dar de baja Negocio <i class="bi bi-shop"></i></button>
                                    <input type="hidden" id="idu" name="idn" value="<%=id%>"/>
                                    <input type="hidden" name="coso" value="1"/>
                                </form>
                                <%
                                    }else{
                                %>
                                <form action="RecuperarNegocio">
                                    <button id="baja_usu">Restaurar Negocio <i class="bi bi-shop"></i></button>
                                    <input type="hidden" id="idu" name="idn" value="<%=id%>"/>
                                </form>
                                <%
                                    }
                                %>
                            </section>
                        </section>
                    </section>
                </section>
                <%
                    cont6=cont6+1;
                    }
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
