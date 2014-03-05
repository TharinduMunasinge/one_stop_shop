/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataLayer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Malakagl
 */
public class DataConnection {
    public Connection getConnection(){
        try {
           
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/One_Stop_Shop","root","");
            return con;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE, null, ex);
            
        }
        return null;
    }
    public static void main(String args [])
       {
           DataConnection con= new DataConnection();
           System.out.println(con.getConnection());
    
    }
}
