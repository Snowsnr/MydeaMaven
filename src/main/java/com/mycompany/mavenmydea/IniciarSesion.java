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

//enviar correos
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//necesario para validar
import java.util.Arrays;
import java.util.List;

//expresiones
import java.util.regex.Pattern;

//Caducidad 
import java.util.Random;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

//Inyecciones
import org.owasp.encoder.Encode;

/**
 *
 * @author 980030870
 */
@WebServlet(urlPatterns = {"/IniciarSesion"})
public class IniciarSesion extends HttpServlet {

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
      
      
            boolean create = true;         
            HttpSession session = request.getSession(create);
            
            String nom=request.getParameter("Nom_usu_is");
            String encnom = Encode.forHtml(nom);
            request.setAttribute("valorNom", nom);
            String pass=request.getParameter("Con_is");
            String encpass = Encode.forHtml(pass);
            request.setAttribute("valorPass", pass);
            String correo=request.getParameter("Email_is");
            String enccorreo = Encode.forHtml(correo);
            request.setAttribute("valorCorreo", correo);
            
            
            
            String codigo = request.getParameter("codigo");
            String enccodigo = Encode.forHtml(codigo);
            
            
            //Expresiones regulares
                //Solo letras
                String regex_Letras = "^[a-zA-Z ]*$";
                //Correo
                String regex_Correo = "^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)*(\\.[a-zA-Z]{2,})$";
                //Telefono
                String regex_Telefono = "^[0-9]{10}$";
                //Contraseña
                String regex_Contraseña = "^(?=.*[0-9]).*$";
            
            
            if (codigo != null) {
                //Confirmación del código
                String codigoCompletado = (String) request.getSession().getAttribute("confirmationCode");
                LocalDateTime generationTime = (LocalDateTime) request.getSession().getAttribute("generationTime");
                
                // Verifica si han pasado más de 5 minutos
                if (ChronoUnit.MINUTES.between(generationTime, LocalDateTime.now()) > 5) {
                    request.setAttribute("error_codigo", "El código de confirmación ha caducado");
                    request.getRequestDispatcher("ConfirmarCodigo_I.jsp").forward(request, response);
                } else if (enccodigo.equals(codigoCompletado)) {
                    
                    Conexion c = new Conexion();
                    Connection con;

                    c.setCon();
                    con=c.getCon();

                    String mensaje = c.ISU(encnom, encpass, enccorreo);

                    if(mensaje==null){

                        String[] Persona = new String[9];

                        Persona=c.InfoPersona(encnom);

                        String tipo = c.Tipo(encnom);

                        try {
                            con.close();
                        } catch (SQLException ex) {
                            Logger.getLogger(CrearNegocio.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        String descripcion = Persona[0];
                        String nombrereal = Persona[1];
                        String telefono = Persona[2];
                        String foto = Persona[3];
                        String fb = Persona [4];
                        String ig = Persona[5];
                        String tw= Persona[6];
                        String web = Persona[7];
                        
                        System.out.println("Correo: " + correo);
                        System.out.println("Telefono: " + telefono);
                        System.out.println("Nombre Real: " + nombrereal);
                        System.out.println("Foto: " + foto);
                        System.out.println("Facebook: " + fb);
                        System.out.println("Instagram: " + ig);
                        System.out.println("Twitter: " + tw);
                        System.out.println("Web: " + web);
                        System.out.println("Descripcion: " + descripcion);
                        
                        Persona person = new Persona(correo, telefono, nombrereal, foto, fb, ig, tw, web, descripcion);
                        session.setAttribute("persona", person);

                        // Imprime el objeto Persona para verificar
                        System.out.println("Objeto Persona guardado en la sesión: " + person);


                        Usuario usuario = new Usuario(nom, pass);
                        session.setAttribute("usuario",usuario);
                        
                        System.out.println("Sesión completa: " + request.getSession());

                        if(tipo.equals("1")){

                            response.sendRedirect("indexCC.jsp");
                        }else if (tipo.equals("2")){
                            response.sendRedirect("indexCV.jsp");
                        }else{
                            response.sendRedirect("index.jsp");
                        }


                        }else{
                        try {
                            con.close();
                        } catch (SQLException ex) {
                            Logger.getLogger(CrearNegocio.class.getName()).log(Level.SEVERE, null, ex);
                        }
                           request.setAttribute("mensaje", mensaje);
                           RequestDispatcher rd = request.getRequestDispatcher("Iniciar_Sesion.jsp");
                           rd.forward(request, response);
                        }
                    
                } else {
                    // El código es incorrecto
                    request.setAttribute("error_codigo", "El código de confirmación no es correcto");
                    request.getRequestDispatcher("ConfirmarCodigo_I.jsp").forward(request, response);
                }
            } else {
                boolean error = false;
                
                //Nombre de usuario
                if(encnom != null){
                    encnom = encnom.trim();
                    //Que no este vacio
                    if(encnom.isEmpty()){
                        request.setAttribute("error_nombreUsuario_Vacio", "El campo no debe de estar vacio");
                        error = true;
                    }
                    //Muy largo
                    if(encnom.length() > 60){
                        request.setAttribute("error_nombreUsuario_Largo", "Solo se permiten hasta 60 caracteres");
                        error = true;
                    }
                } else {
                    request.setAttribute("error_nombreUsuario_Vacio", "El campo no debe de estar vacio");
                    error = true;
                }
                
                //Correo
                if(enccorreo != null){
                    enccorreo = enccorreo.trim();
                    //Que no este vacio
                    if(enccorreo.isEmpty()){
                        request.setAttribute("error_correo_Vacio", "El campo no debe de estar vacio");
                        error = true;
                    }
                    //Que sea correcto el correo
                    if(!Pattern.matches(regex_Correo, enccorreo)){
                        request.setAttribute("error_correo_Invalido", "Ingrese un correo electronico valido");
                        error = true;
                    } 
                } else {
                    request.setAttribute("error_correo_Vacio", "El campo no debe de estar vacio");
                    error = true;
                }
                
                //Contraseña
                if(encpass != null){
                    encpass = encpass.trim();
                    //Que no este vacio
                    if(encpass.isEmpty()){
                        request.setAttribute("error_contraseña_Vacio", "El campo no debe de estar vacio");
                        error = true;
                    }
                } else {
                    request.setAttribute("error_contraseña_Vacio", "El campo no debe de estar vacio");
                    error = true;
                }
                
                
                if (error){
                    request.getRequestDispatcher("Iniciar_Sesion.jsp").forward(request, response);
                }        
                
                else {
                    request.getSession().setAttribute("nom", nom);
                    request.getSession().setAttribute("correo", correo);
                    request.getSession().setAttribute("pass", pass);
                    
                    
                    VerificacionCorreo_I emailSender = new VerificacionCorreo_I();
                    String confirmationCode = emailSender.sendConfirmationCode(request);
                    request.getSession().setAttribute("confirmationCode", confirmationCode);
                    response.sendRedirect("ConfirmarCodigo_I.jsp");
                    
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
