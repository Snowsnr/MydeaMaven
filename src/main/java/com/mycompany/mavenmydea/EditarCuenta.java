/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Clases.Conexion;
import Clases.Persona;
import Clases.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


//necesario para validar
import java.util.Arrays;
import java.util.List;

//expresiones
import java.util.regex.Pattern;

//Caducidad 
import java.util.Random;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

/**
 *
 * @author Diego
 */
@WebServlet(urlPatterns = {"/EditarCuenta"})
public class EditarCuenta extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            String nombreu = request.getParameter("nomu");
            request.setAttribute("valorNomu", nombreu);
            String nombrec = request.getParameter("nomc");
            request.setAttribute("valorNomc", nombrec);
            String correo = request.getParameter("correo");
            request.setAttribute("valorCorr", correo);
            String descripcion = request.getParameter("desc");
            request.setAttribute("valorDesc", descripcion);
            String telefono = request.getParameter("telefono");
            request.setAttribute("valorTelef", telefono);
            String facebook = request.getParameter("fb");
            request.setAttribute("valorFb", facebook);
            String instagram = request.getParameter("ig");
            request.setAttribute("valorIg", instagram);
            String twitter = request.getParameter("tw");
            request.setAttribute("valorTwit", twitter);
            String web = request.getParameter("web");
            request.setAttribute("valorWeb", web);
            String foto = request.getParameter("foto");
            request.setAttribute("valorFot", foto);
            
            
            //Expresiones regulares
                //Solo letras
                String regex_Letras = "^[a-zA-Z ]*$";
                //Correo
                String regex_Correo = "^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)*(\\.[a-zA-Z]{2,})$";
                //Telefono
                String regex_Telefono = "^[0-9]{10}$";
                //Contraseña
                String regex_Contraseña = "^(?=.*[0-9]).*$";
                
            //Codigo
            String codigo = request.getParameter("codigo");

            HttpSession misession= (HttpSession) request.getSession();
            Usuario usuario= (Usuario) misession.getAttribute("usuario");
            String nombreua = usuario.getUsu_nom();
            Persona per= (Persona) misession.getAttribute("persona");
            String correoa = per.getPer_correo();
            String fotoa = per.getPer_foto();
            String telefonoa = per.getPer_telefono();
            String nombreca = per.getPer_nombrereal();
            String fba = per.getPer_fb();
            String iga = per.getPer_ig();
            String twa = per.getPer_twitter();
            String weba = per.getPer_web();
            String desca = per.getPer_descripcion();
            
            boolean error = false;
            
            //Correo
            if(correo.equals("")){
                correo=correoa;
            } else {
                correo = correo.trim();
                if (!Pattern.matches(regex_Correo, correo)) {
                    request.setAttribute("error_correo_Invalido", "Ingrese un correo valido");
                    error = true;
                } else if (!correo.equals(correoa) && codigo != null) { // Verifica si el correo ha cambiado
                    // Confirmación del código
                    String codigoCompletado = (String) request.getSession().getAttribute("confirmationCode");
                    LocalDateTime generationTime = (LocalDateTime) request.getSession().getAttribute("generationTime");

                    // Verifica si han pasado más de 5 minutos
                    if (ChronoUnit.MINUTES.between(generationTime, LocalDateTime.now()) > 5) {
                        request.setAttribute("error_codigo", "El código de confirmación ha caducado");
                        error = true;
                    } else if (!codigo.equals(codigoCompletado)) {
                        request.setAttribute("error_codigo", "El código de confirmación no es correcto");
                        error = true;
                    } else {
                        Conexion con = new Conexion();
                        Connection c;
                        con.setCon();
                        c=con.getCon();

                        String mensaje = con.EUsuario(nombreu,nombreua,nombrec,correo,descripcion,telefono,facebook,instagram,twitter,
                                web,foto,correoa,telefonoa);

                        try {
                            c.close();
                        } catch (SQLException ex) {
                            Logger.getLogger(EditarCuenta.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        if(mensaje==null){
                                mensaje="Datos actualizados correctamente";
                               request.setAttribute("mensaje", mensaje);

                               usuario.setUsu_nom(nombreu);
                               per.setPer_correo(correo);
                               per.setPer_descripcion(descripcion);
                               per.setPer_fb(facebook);
                               per.setPer_foto(foto);
                               per.setPer_ig(instagram);
                               per.setPer_nombrereal(nombrec);
                               per.setPer_telefono(telefono);
                               per.setPer_twitter(twitter);
                               per.setPer_web(web);

                              RequestDispatcher rd = request.getRequestDispatcher("Editar_CuentaCV.jsp");
                              rd.forward(request, response);


                        //
                        }else{
                           request.setAttribute("mensaje", mensaje);

                           RequestDispatcher rd = request.getRequestDispatcher("Editar_CuentaCV.jsp");
                           rd.forward(request, response);
                        }
                        
                    }
                }
            }
            //Nombre usuario
            if(nombreu.equals("")){
            nombreu=nombreua;
            } else {
                if(nombreu != null){
                    nombreu = nombreu.trim();
                    if(!nombreu.equals(nombreua)){

                        if(nombreu.isEmpty()){
                            request.setAttribute("error_nombreU_Vacio", "El campo no debe de estar vacio");
                            error = true;
                        }

                        if(nombreu.length() > 60){
                            request.setAttribute("error_nombreu_Largo", "Solo se permiten 60 caracteres");
                            error = true;
                        }
                    }
                }
            }
            
            //Nombre completo
            if(nombrec.equals("")){
                nombrec=nombreca;
            } else {
                if(nombrec != null){
                    nombrec = nombrec.trim();
                    if(!nombrec.equals(nombreca)){

                        if(nombrec.isEmpty()){
                            request.setAttribute("error_nombreC_Vacio", "El campo no debe de estar vacio");
                            error = true;
                        }

                        if(nombrec.length() > 60){
                            request.setAttribute("error_nombreC_Largo", "Solo se permiten 60 caracteres");
                            error = true;
                        }

                        if(!Pattern.matches(regex_Letras, nombrec)){
                            request.setAttribute("error_nombreC_Invalido", "Solo se permiten letras");
                            error = true;
                        }
                    }
                }
            }
            //descripcion
            if(descripcion.equals("")){
                descripcion=desca;
            }
            
            //telefono
            if(telefono.equals("")){
                telefono=telefonoa;
            } else {
                if(telefono != null){
                    telefono = telefono.trim();
                    if(!telefono.equals(telefonoa)){

                        if(telefono.isEmpty()){
                            request.setAttribute("error_telefono_Vacio", "El campo no debe de estar vacio");
                            error = true;
                        }
                        //
                        if(!Pattern.matches(regex_Telefono, telefono)){
                            request.setAttribute("error_telefono_Invalido", "Ingrese un numero de telefono valido");
                            error = true;
                        }
                    }
                }
            }
            
            if(facebook.equals("")){
                facebook=fba;
            }
            if(instagram.equals("")){
                instagram=iga;
            }
            if(twitter.equals("")){
                twitter=twa;
            }
            if(web.equals("")){
                web=weba;
            }
            if(foto.equals("")){
                foto=fotoa;
            }

            
            //errores y correos
            if(error){
                request.getRequestDispatcher("Editar_CuentaCV.jsp").forward(request, response);
            } else {
                if (!correo.equals(correoa)) {
                    request.getSession().setAttribute("nombreu", nombreu);
                    request.getSession().setAttribute("nombrec", nombrec);
                    request.getSession().setAttribute("correo", correo);
                    request.getSession().setAttribute("descripcion", descripcion);
                    request.getSession().setAttribute("telefono", telefono);
                    request.getSession().setAttribute("facebook", facebook);
                    request.getSession().setAttribute("instagram", instagram);
                    request.getSession().setAttribute("twitter", twitter);
                    request.getSession().setAttribute("web", web);
                    request.getSession().setAttribute("foto", foto);

                    VerificacionCorreo_E emailSender = new VerificacionCorreo_E();
                    String confirmationCode = emailSender.sendConfirmationCode(request);
                    request.getSession().setAttribute("confirmationCode", confirmationCode);
                    request.getRequestDispatcher("ConfirmarCodigo_E.jsp").forward(request, response);
                } else {

                    Conexion con = new Conexion();
                    Connection c;
                    con.setCon();
                    c=con.getCon();

                    String mensaje = con.EUsuario(nombreu,nombreua,nombrec,correo,descripcion,telefono,facebook,instagram,twitter,
                            web,foto,correoa,telefonoa);

                    try {
                        c.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(EditarCuenta.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    if(mensaje==null){
                           mensaje="Datos actualizados correctamente";
                           request.setAttribute("mensaje", mensaje);

                           usuario.setUsu_nom(nombreu);
                           per.setPer_correo(correo);
                           per.setPer_descripcion(descripcion);
                           per.setPer_fb(facebook);
                           per.setPer_foto(foto);
                           per.setPer_ig(instagram);
                           per.setPer_nombrereal(nombrec);
                           per.setPer_telefono(telefono);
                           per.setPer_twitter(twitter);
                           per.setPer_web(web);

                          RequestDispatcher rd = request.getRequestDispatcher("Editar_CuentaCV.jsp");
                          rd.forward(request, response);

                    }else{
                       request.setAttribute("mensaje", mensaje);

                       RequestDispatcher rd = request.getRequestDispatcher("Editar_CuentaCV.jsp");
                       rd.forward(request, response);
                    }
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

/*
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditarCuenta</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1> Datos a cambiar</h1>");
            out.println("<h3>Nombre de usuario antiguo: "+nombreua+" Nombre nuevo: "+nombreu+" </h3>");
            out.println("<h3>Nombre completo antiguo: "+nombreca+" Nombre completo nuevo: "+nombrec+" </h3>");
            out.println("<h3>Descripcion antigua: "+desca+" Descripcion nueva: "+descripcion+" </h3>");
            out.println("<h3>Telefono antiguo: "+telefonoa+" Telefono nuevo: "+telefono+" </h3>");
            out.println("<h3>Correo antiguo: "+correoa+" Correo nuevo: "+correo+" </h3>");
            out.println("<h3>Facebook antiguo: "+fba+" Facebook nuevo: "+facebook+" </h3>");
            out.println("<h3>Instagram antiguo: "+iga+" Instagram nuevo: "+instagram+" </h3>");
            out.println("<h3>Twitter antiguo: "+twa+" Twitter nuevo: "+twitter+" </h3>");
            out.println("<h3>Pagina web antigua: "+weba+" Pagina web nueva: "+web+" </h3>");
            out.println("<h3>Foto antigua: "+foto+" Foto nueva: "+foto+" </h3>");
            out.println("</body>");
            out.println("</html>");
            */
