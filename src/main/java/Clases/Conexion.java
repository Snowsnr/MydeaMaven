/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Diego
 */
public class Conexion {
    private Connection con;
    
    
    public Conexion(){
        
    }

    public Connection getCon() {
        return con;
    }

    public void setCon() {
       try{
           
     //POSTGRE HOST, CON ESTE HACEN LA PULL REQUEST
/*String dbDriver = "org.postgresql.Driver";
     String dbURL = "jdbc:postgresql://ec2-100-26-73-144.compute-1.amazonaws.com/db3v6hean6n35q";
                          
                // Database name to access
     String dbUsername = "ipsrpxvnaqxiwm";
     String dbPassword = "45a8d512e214c8aec0d15935b70c9addc631a10c65bc23296d0e2e2bd0b2f0a0";
     Class.forName(dbDriver).newInstance();
     con = DriverManager.getConnection(dbURL,dbUsername, dbPassword);*/
     
     
     // MYSQL LOCAL CAMBIEN LA CONTRASEÑA
     
     String dbDriver = "com.mysql.jdbc.Driver";
     String dbURL = "jdbc:mysql://localhost:3306/";
                // Database name to access
     String dbName = "mydea";
     String dbUsername = "root";
     String dbPassword = "20232707SQL.";
     Class.forName(dbDriver).newInstance();
     con = DriverManager.getConnection(dbURL + dbName,
     dbUsername,
     dbPassword); 
     
     
     
      } catch (Exception e ) {
            System.out.println("erore");
                System.err.println("Error"+e);
      }
    }
    
    public String Registro(String usu_nombre, String usu_pass, String per_nombrereal, String per_telefono, String per_correo, String tipo){
        
        
        Statement stmt=null;
       
        String mensaje = null;
        int h=0;
        try{
        stmt=con.createStatement();
        String sql="SELECT * FROM Usuario WHERE usu_nombre= ?";
        String sql2="SELECT * FROM Usuario;";
        String sql3="SELECT * FROM Persona;";
        
        
       
        ResultSet nom = stmt.executeQuery(sql2);
                       
        //comprobar si el nombre ya existe
        while(nom.next()){
            String nombre = nom.getString("usu_nombre");
            if(nombre.equals(usu_nombre)){
                h=1;
                mensaje="Este nombre de usuario ya existe por favor elige otro";
                break;
            }
        }
                
        //comprobar si el correo o telefono ya existe
        ResultSet persona = stmt.executeQuery(sql3);
            while(persona.next()){
                String correo = persona.getString("per_correo");
                String telefono = persona.getString("per_telefono");
                    if(correo.equals(per_correo)){
                        h=1;
                        mensaje="Este correo ya está en uso, por favor ingresa otro";
                        break;
                    }else if(telefono.equals(per_telefono)){
                        h=1;
                        mensaje="Este telefono ya está en uso, por favor ingresa otro";
                        break;
                    }
                    
            }
        if(h==0){
            
            
            PreparedStatement ps2 = con.prepareStatement("INSERT INTO Usuario(usu_nombre, usu_password, tip_id) VALUES( ? "
                    + ", ? , ?);");
            ps2.setString(1, usu_nombre);
            ps2.setString(2, usu_pass);
            ps2.setInt(3, Integer.parseInt(tipo));
            ps2.execute();
            
             PreparedStatement ps = con.prepareStatement(sql);
             ps.setString(1, usu_nombre);
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                int usu_id =rs.getInt("usu_id");
                
            PreparedStatement ps3 = con.prepareStatement("INSERT INTO Persona(usu_id, per_telefono, per_nombrecompleto, "
                    + "per_correo) VALUES(? , ? , ? , ? );");
                
                ps3.setInt(1, usu_id);
                ps3.setString(2, per_telefono);
                ps3.setString(3, per_nombrereal);
                ps3.setString(3, per_correo);
                
            }

        }
      } catch (Exception e ) {
                System.err.println("Error"+e);
      }
      return mensaje;              
    }
    
    public String ISU(String usu_nom, String usu_pass, String per_correo){
    String mensaje=null;
    Statement stmt = null;
    try{
        
        stmt=con.createStatement();
                String sql="SELECT * FROM Usuario WHERE usu_nombre=?";
                String sql2="SELECT * FROM Usuario;";
                int usu_id=0;
                
                
                int h=0;
                
                
                ResultSet nom = stmt.executeQuery(sql2);
                //comprobar si el nombre ingresado existe
                while(nom.next()){
                    String nombre = nom.getString("usu_nombre");
                    if(nombre.equals(usu_nom)){
                        h=h+1;
                        
                        usu_id=nom.getInt("usu_id");
                        break;
                    }
                } 
                //comprobar si la contraseña coincide
                
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, usu_nom);
                
                ResultSet pass = ps.executeQuery();
                while(pass.next()){
                    
                    String clave = pass.getString("usu_password");
                    
                    if(clave.equals(usu_pass)){
                        h=h+1;
                        break;
                    }
                }
                //comprobar si el correo coincide
                String sql3="SELECT * FROM Persona WHERE usu_id='"+usu_id+"';";
                ResultSet persona = stmt.executeQuery(sql3);
                while(persona.next()){
                    String correo = persona.getString("per_correo");
                   
                    if(correo.equals(per_correo)){
                        
                        h=h+1;
                       
                        break;
                    }                 
                } 
                if(h==3){
                }else{
                   mensaje="Por favor revisa que los datos proporcionados sean correctos";       
                }
        
        
    } catch (Exception e ) {
                System.err.println("Error"+e);
      }
    
    return mensaje;
}
    
    public String Tipo(String nombre){
        String mensaje = null;
        try{
        Statement stmt=con.createStatement();
        
        String sql="Select * FROM Usuario where usu_nombre= ? ";
        
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, nombre);
        
        
        ResultSet idq = ps.executeQuery();
        
        while(idq.next()){
            int tipo = idq.getInt("tip_id");
            mensaje=Integer.toString(tipo);
        }
        
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return mensaje;
    }
    
    public String[] InfoPersona(String usu_nombre){
        
        String[] Persona = new String[9];
        int usu_id =0;
        String nombrereal, telefono, foto, fb, ig, tw, web, correo, desc;
     
        try{
        Statement stmt=con.createStatement();
        String sql="Select * FROM Usuario where usu_nombre='"+usu_nombre+"';";
        
        
        ResultSet idq = stmt.executeQuery(sql);
        
        while(idq.next()){
            usu_id = idq.getInt("usu_id");
        }
        String sql2="Select * from Persona where usu_id="+usu_id+";";
        
        ResultSet per = stmt.executeQuery(sql2);
        while(per.next()){
            desc=per.getString("per_descripcion");
            nombrereal=per.getString("per_nombrecompleto");
            telefono=per.getString("per_telefono");
            foto = per.getString("per_foto");
            fb = per.getString("per_facebook");
            ig = per.getString("per_instagram");
            tw = per.getString("per_twitter");
            web = per.getString("per_web");
            correo=per.getString("per_correo");
          
            
            Persona[0]=desc;
            Persona[8]=correo;
            Persona[1]=nombrereal;
            Persona[2]=telefono;
            Persona[3]=foto;
            Persona[4]=fb;
            Persona[5]=ig;
            Persona[6]=tw;
            Persona[7]=web;
            
        }
        
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return Persona;
    }
    
    public String AgNeg(String uid, String nombre, String desc, String colonia, String calle, String numero, String indicaciones, String cp, String web, 
        String logo, String tema, String fb, String tw, String ig, String ft1, String ft2, String correo, String ft3, String tel){
        
        String mensaje=null;
    
     
        try{
            
            
         Statement stmt=con.createStatement();
            String sql="select * from Negocio;";
        
            int h=0;
           
           ResultSet neg = stmt.executeQuery(sql);
            while(neg.next()){
                String nom = neg.getString("neg_nombre");
                String telefono = neg.getString("neg_telefono");
                String cor = neg.getString("neg_correo");
                    if(nom.equals(nombre)){
                        h=1;
                        mensaje="Este nombre de negocio ya está en uso, por favor ingresa otro";
                        break;
                    }else if(telefono.equals(tel)){
                        h=1;
                        mensaje="Este telefono ya está en uso, por favor ingresa otro";
                        break;
                    }else if(cor.equals(correo)){
                        h=1;
                        mensaje="Este correo ya está en uso, por favor ingresa otro";
                        break;
                    }
                    
                 
                    
            }         
            if(h==0){
               ResultSet rs = null;
                String sqld = "INSERT INTO Direccion(dir_colonia, dir_calle, dir_numero, dir_indicaciones, dir_cp)"
                        + " VALUES ( ?, ?, ?, ?, ?);";
                String sqlb = "SELECT MAX(dir_id) as dir_id FROM Direccion;";
                
                PreparedStatement ps = con.prepareStatement(sqld);
                ps.setString(1, colonia);
                ps.setString(2, calle);
                ps.setInt(3, Integer.parseInt(numero));
                ps.setString(4, indicaciones);
                ps.setInt(5, Integer.parseInt(cp));
                
                ps.execute();
                
                rs=stmt.executeQuery(sqlb);
            while(rs.next()){
                int dir_id =rs.getInt("dir_id");
                
                PreparedStatement psd = con.prepareStatement("INSERT INTO Negocio(neg_correo, neg_telefono, neg_logo, neg_descripcion, neg_facebook, neg_instagram, neg_twitter, neg_web, per_id,"
                     + " neg_nombre, dir_id, tem_id, neg_imagen1, neg_imagen2, neg_imagen3)"
            + "VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
                psd.setString(1, correo);
                psd.setString(2, tel);
                psd.setString(3, logo);
                psd.setString(4, desc);
                psd.setString(5, fb);
                psd.setString(6, ig);
                psd.setString(7, tw);
                psd.setString(8, web);
                psd.setInt(9, Integer.parseInt(uid));
                psd.setString(10, nombre);
                psd.setInt(11, dir_id);
                psd.setInt(12, Integer.parseInt(tema));
                psd.setString(13, ft1);
                psd.setString(14, ft2);
                psd.setString(15, ft3);
                
                psd.execute();
             
            }

           
            
            
            
        }
        
        
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        
        return mensaje;
    }
    
    public int Pid(String correo){
         int id=0;
      
        try{
         Statement stmt=con.createStatement();
            String sql="select * from Persona where per_correo='"+correo+"';";
            
            ResultSet rr= stmt.executeQuery(sql);
            
            while(rr.next()){
                id = rr.getInt("per_id");
            }
        
        
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        
        return id;
    }
    
    public int Nid(String nombre){
        int id = 0;
        try{
            Statement stmt=con.createStatement();
            String sqlq="Select neg_id from Negocio where neg_nombre='"+nombre+"';";
            ResultSet rr= stmt.executeQuery(sqlq);
            while(rr.next()){
                id = rr.getInt("neg_id");
                }
            
            } catch (Exception e ) {
                System.err.println("Error"+e);
                }
        return id;  
    }
    
        
    public String Agprod(String neid, String nombre, String descripcion, String imagen, String precio, String dis){
        String mensaje=null;
      
        try{
         Statement stmt=con.createStatement();
         
            String sql="insert into Producto(pro_nombre, pro_descripcion, pro_precio, neg_id, dis_id, pro_imagen)"
                    + "values(?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, descripcion);
            ps.setInt(3, Integer.parseInt(precio));
            ps.setInt(4, Integer.parseInt(neid));
            ps.setInt(5, Integer.parseInt(dis));
            ps.setString(6, imagen);
            
            ps.execute();
            
            mensaje="¡Listo! Producto agregado, puede seguir agregando productos";
        
        
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        
        return mensaje;
    }
    
    public void Horario(String abierto, String cerrado, String especial, String dia, String nid){
        
        try{
            Statement stmt=con.createStatement();
            String sql="Insert into Horario(hor_abierto, hor_cerrado, hor_especial, hor_dia) VALUES( ?, ?, ?, ?);";
            String sql2 = "SELECT MAX(hor_id) as hor_id FROM Horario;";
            int hid=0;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, abierto);
            ps.setString(2, cerrado);
            ps.setString(3, especial);
            ps.setString(4, dia);
            ps.execute();
            
            ResultSet rr= stmt.executeQuery(sql2);
            
            while(rr.next()){
                hid = rr.getInt("hor_id");
            }
            
            String sql3 = "Insert into Negocio_Horario(hor_id, neg_id) Values("+hid+","+nid+");";
            stmt.execute(sql3);
            
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        
    }
    
    public void EHorario(String abierto, String cerrado, String especial, String dia, int hid){
        
        try{
            Statement stmt=con.createStatement();
  
            String sql="Update Horario set hor_abierto= ?, hor_cerrado= ?, hor_especial= ?, hor_dia= ? where hor_id= ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,abierto);
            ps.setString(2, cerrado);
            ps.setString(3, especial);
            ps.setString(4, dia);
            ps.setInt(5, hid);
            ps.execute();
            
            
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        
    }
    
    public int[] Hid(String nid){
        int[] hid = new int[7];
        try{
            Statement stmt=con.createStatement();
            
            String s="Select hor_id from Negocio_Horario where neg_id="+nid+";";
            
            
            
            ResultSet rs = stmt.executeQuery(s);
            int k =0;
            while(rs.next()){
                hid[k] = rs.getInt("hor_id");
                k=k+1;
            }

            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return hid;
    }
    
    public String EUsuario(String nombreu, String nombreua, String nombrec, String correo, String descripcion, String telefono,
    String facebook, String instagram, String twitter, String web, String foto, String correoa, String telefonoa){
        
        String mensaje=null;
      int h =0;
        try{
         
        Statement stmt=con.createStatement();
       
        String sql2="SELECT * FROM Usuario;";
        String sql3="SELECT * FROM Persona;";
        ResultSet nom = stmt.executeQuery(sql2);
                       
        //comprobar si el nombre ya existe
        while(nom.next()){
            String nombre = nom.getString("usu_nombre");
            if(nombre.equals(nombreu)&&!nombre.equals(nombreua)){
                h=1;
                mensaje="Este nombre de usuario ya existe por favor elige otro";
                break;
            }
        }
                
        //comprobar si el correo o telefono ya existe
        ResultSet persona = stmt.executeQuery(sql3);
            while(persona.next()){
                String correor = persona.getString("per_correo");
                String telefonor = persona.getString("per_telefono");
                    if(correor.equals(correo)&&!correor.equals(correoa)){
                        h=1;
                        mensaje="Este correo ya está en uso, por favor ingresa otro";
                        break;
                    }else if(telefonor.equals(telefono)&&!telefonor.equals(telefonoa)){
                        h=1;
                        mensaje="Este telefono ya está en uso, por favor ingresa otro";
                        break;
                    }
                    
            }
            
            
        if(h==0){
            System.out.println(foto);
            
            PreparedStatement ps = con.prepareStatement("update Usuario set usu_nombre= ? where usu_nombre= ? ");
            ps.setString(1, nombreu);
            ps.setString(2, nombreua);
            ps.execute();
            
            PreparedStatement pss = con.prepareStatement("update Persona set per_nombrecompleto = ?, per_correo= ?, per_descripcion= ?, per_telefono= ?, per_facebook= ?,"
            + " per_instagram= ?, per_twitter= ?, per_web= ?, per_foto= ? where per_correo= ?");
            pss.setString(1, nombrec);
            pss.setString(2, correo);
            pss.setString(3, descripcion);
            pss.setString(4, telefono);
            pss.setString(5, facebook);
            pss.setString(6, instagram);
            pss.setString(7, twitter);
            pss.setString(8, web);
            pss.setString(9, foto);
            pss.setString(10, correoa);
            pss.execute();
        }
        
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        
        return mensaje;
        
    }
    
    public String Novedad(String nombre, String descripcion, String foto, String id){
        String mensaje=null;
        try{
           
            String sql3 = "Insert into Novedad(neg_id, nov_nombre, nov_descripcion, nov_foto) Values( ?, ?, ?, ?);";
            PreparedStatement ps = con.prepareStatement(sql3);
            ps.setInt(1, Integer.parseInt(id));
            ps.setString(2, nombre);
            ps.setString(3, descripcion);
            ps.setString(4, foto);
            ps.execute();
            
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return mensaje;
    }
    
    public String ENegocio(String nombre, String desc, String colonia, String calle, String numero, String indicaciones, String cp, String web, 
        String logo, String tema, String fb, String tw, String ig, String ft1, String ft2, String correo, String ft3, String tel,
        String tela, String correoa, String nombrea, String did){
        String mensaje=null;
        
        try{
            Statement stmt=con.createStatement();
            
            
         
            String sql="select * from Negocio;";
        
            int h=0;
           
           ResultSet neg = stmt.executeQuery(sql);
            while(neg.next()){
                String nom = neg.getString("neg_nombre");
                String telefono = neg.getString("neg_telefono");
                String cor = neg.getString("neg_correo");
                    if(nom.equals(nombre)&&!nom.equals(nombrea)){
                        h=1;
                        mensaje="Este nombre de negocio ya está en uso, por favor ingresa otro";
                        break;
                    }else if(telefono.equals(tel)&&!telefono.equals(tela)){
                        h=1;
                        mensaje="Este telefono ya está en uso, por favor ingresa otro";
                        break;
                    }else if(cor.equals(correo)&&!cor.equals(correoa)){
                        h=1;
                        mensaje="Este correo ya está en uso, por favor ingresa otro";
                        break;
                    }         
            }         
            if(h==0){
            
               String sq ="Update Negocio set neg_nombre= ?, neg_descripcion= ?, neg_correo= ?, neg_telefono= ?, neg_logo= ?, "
                       + "neg_imagen1= ?, neg_imagen2= ?, neg_imagen3= ?, neg_facebook= ?, neg_instagram= ?, neg_twitter= ?, "
                       + "neg_web= ?, tem_id= ? where neg_correo= ?";
               
               PreparedStatement ps = con.prepareStatement(sq);
               ps.setString(1, nombre);
               ps.setString(2, desc);
               ps.setString(3, correo);
               ps.setString(4, tel);
               ps.setString(5, logo);
               ps.setString(6, ft1);
               ps.setString(7, ft2);
               ps.setString(8, ft3);
               ps.setString(9, fb);
               ps.setString(10, ig);
               ps.setString(11, tw);
               ps.setString(12, web);
               ps.setInt(13, Integer.parseInt(tema));
               ps.setString(14, correoa);
               
               ps.execute();
               
               String sq2="Update Direccion set dir_calle= ?, dir_colonia= ?, dir_indicaciones= ?, dir_cp= ?, dir_numero= ? where dir_id= ?";
           
               PreparedStatement psd = con.prepareStatement(sq2);
               psd.setString(1, calle);
               psd.setString(2, colonia);
               psd.setString(3, indicaciones);
               psd.setInt(4, Integer.parseInt(cp));
               psd.setInt(5, Integer.parseInt(numero));
               psd.setInt(6, Integer.parseInt(did));
               
               psd.execute();
            
            
        }
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return mensaje;
        
    }
    
    public String Comentario(String idn, int idu, String comentario, String like){
        String mensaje = "Comentario realizado";
        try{
          
            
            
            String sql3 = "Insert into Feedback(neg_id, per_id, fed_comentario, fed_like) Values( ? , ? , ? , ? );";
            PreparedStatement ps = con.prepareStatement(sql3);
            ps.setInt(1, Integer.parseInt(idn));
            ps.setInt(2, idu);
            ps.setString(3, comentario);
            ps.setBoolean(4, Boolean.valueOf(like));
            ps.execute();
            
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return mensaje;
    }
    
    public String Guardar(String idn, int idu){
        String mensaje = null;
        try{
            Statement stmt=con.createStatement();
            String pid=null;
            
            ResultSet rs=stmt.executeQuery("Select * from Guardado where per_id="+idu+" and neg_id="+idn+";");
            while(rs.next()){
                     pid = "1";
                    
                    System.out.println("pid "+pid);
                }
            if(pid!=null){
                mensaje="Ya has guardado este negocio";
            }else{
            String sql3 = "Insert into Guardado(neg_id, per_id) Values("+idn+","+idu+");";
            stmt.execute(sql3);
            mensaje="Negocio guardado";
            }
            System.out.println("pid "+pid);
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return mensaje;
    }
    
    public String Eliminar(String id){
        String mensaje = "Negocio eliminado con éxito";
        try{
          
            
            
            String sql3 = "Update Negocio set neg_activo=false where neg_id="+id+";";
            Statement stmt =con.createStatement();
            stmt.execute(sql3);
            
            
        } catch (Exception e ) {
                System.err.println("Error"+e);
        }
        return mensaje;
    }
    
}
