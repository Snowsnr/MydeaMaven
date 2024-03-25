<%-- 
    Document   : Subir_Novedad
    Created on : 21 nov 2023, 2:24:22
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
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.Conexion"%>
<%
    HttpSession session1 = request.getSession(false);
    if (session1.getAttribute("usuario") != null) {

    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="templates/Referencias/Todas_Ref.jsp"/>
        <title>Novedades</title>
    </head>
    <body>
        <jsp:include page="templates/Navegadores/Navegador_CV.jsp"/>
        <div class="d-flex flex-column w-100 justify-content-between cnf1 Inria">
            <%
                String id = request.getParameter("idn");
                %>
            <section class="color1" id="color"></section>
            <section class="color2" id="color"></section>
            <div class="content_form w-100">
                <section class="d-flex text-white align-items-center p1_cnf">
                    <span class="txt_prin_cnf fw-bolder">Crea y Revisa las Novedades de tu Negocio</span>
                    <i class="bi bi-question-circle quicon_cnf_lg" data-bs-toggle="tooltip" data-bs-placement="right"
                       data-bs-title="Tooltip on right"></i>
                </section>
                <div class="p2_cnf d-flex flex-column" id="FORM_CNF">
                    <div class="p22_cnf p-4 pt-3">
                        <span class="dt_txt_cnf" id="dt_txt_cnf">Novedades</span>
                        <div class="form_cnf Productos_cnf justify-content-between" id="Productos_cnf" >
                            <form class="prof1_cnf d-flex flex-column" id="prof1_cnf" method="post" action="SubirNovedad" >
                                <section class="d-flex w-100 h-50 justify-content-around">
                                    <section class="prof1_s1">
                                        <section
                                            class="log_cnf d-flex flex-column justify-content-center align-items-center prof1_s11">
                                            <span class="fw-bold">Imagen de la Novedad
                                                <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                   data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                            
                                     <%//arregla esta cosa valdivia%>       
                                            <div class="elementos-derecha">
                <input type="file" name="" id="inpt_file_img_perf" accept="image/png, image/jpeg">
                <div class="cont-img" id="nue_img">
                    <img class="img" src="" alt="" id="nimg_most">
                    <i class="bi bi-image icon_img_most" id="icon_img_most"></i>
                </div>
            </div>
                                            
                                            
                                        </section>
                                    </section>
                                    <section class="prof1_s2 d-flex flex-column justify-content-around">
                                        <section>
                                            <span class="fw-bold">Titulo de la Novedad
                                                <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                                   data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                            <input type="text" class="form-control" placeholder="Novedad de su Negocio"
                                                   id="Nom_Pro_inp" name="Nom_Pro_inp" />
                                        </section>
                                    </section>
                                </section>
                                <section class="d-flex flex-column w-100 h-50 justify-content-center">
                                    <section class="d-flex flex-column h-75">
                                        <span class="fw-bold">Describa la Novedad de su Negocio
                                            <i class="bi bi-question-circle" data-bs-toggle="tooltip"
                                               data-bs-placement="right" data-bs-title="Tooltip on right"></i></span>
                                        <textarea class="form-control txta_cnf" name="Desc_Pro_inp" id="Desc_Pro_inp"></textarea>
                                    </section>
                                    <section class="d-flex h-25 justify-content-around w-100 flex-column">
                                        <button type="submit" type="button"
                                                class="btn btn-outline-dark btn_rosa h-75 text-white" id="btn_AProd">
                                            Añadir Novedad
                                        </button>
                                    </section>
                                </section>
                                <input type="hidden" name="idn" value="<%=id%>"/>
                                <input type="hidden" name="ft" id="ft" value=""/>
                            </form>
                            <div class="prof2_cnf">
                                <span class="dt_txt_cnf">Lista de Novedades<i class="bi bi-question-circle"
                                                                              data-bs-toggle="tooltip" data-bs-placement="right"
                                                                              data-bs-title="Tooltip on right"></i></span>
                                <%
                                    Conexion con;
        Connection c;
        Statement stmt;
        ResultSet rs;
        con = new Conexion();
        con.setCon();
        c = con.getCon();
        stmt = c.createStatement();
        
        rs=stmt.executeQuery("Select * from Novedad where neg_id="+id+";");
        
        while(rs.next()){
        
        String nombre = rs.getString("nov_nombre");
        String descripcion = rs.getString("nov_descripcion");
        String foto = rs.getString("nov_foto");
          

                                    %>
                                
                                <section class="w-100 Prod_Cont">
                                    <div class="prod d-flex" id="prod1">
                                        <img src="<%=foto%>" alt="prod" class="img_prod_cnf">
                                        <section class="d-flex flex-column Prod_Lis w-75 h-100">
                                            <span class="N_ProVP"><%=nombre%></span>
                                            <textarea type="text" class="D_ProVP h-75" disabled><%=descripcion%></textarea>
                                        </section>
                                    </div>
                                </section>
                                
                                    <%
                                        }
                                        c.close();
                                        %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.min.js"></script>
    <script src="js/sn.js"></script>
     <%
            if(request.getAttribute("mensaje")!=null) 
            {  
        %>          
                <script>
    window.onload=function() {
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
                                                                <%
            }else{
    System.out.println("Error: Sesión no existe");
    response.sendRedirect("index.jsp");
}
            %>
    </body>
</html>
