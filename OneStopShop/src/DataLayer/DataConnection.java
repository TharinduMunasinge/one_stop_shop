/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataLayer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JTable;
import javax.swing.table.TableColumn;

/**
 *
 * @author Malakagl
 */
public class DataConnection {

    public static Connection getConnection() {
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/One_Stop_Shop", "root", "");
            return con;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE, null, ex);

        }
        return null;
    }

    public static void insertData(String ID, String addressCity,
            String addressNumber, String addressStreet, String email,
            String name, String type) {
        try {
            Connection con = getConnection();
            PreparedStatement pStmt = con.prepareStatement(
                    "insert into customer value(?,?,?,?,?,?,?)");
            pStmt.setString(1, ID);
            pStmt.setString(2, name);
            pStmt.setString(3, addressCity);
            pStmt.setString(4, addressStreet);
            pStmt.setString(5, addressNumber);
            pStmt.setString(6, email);
            pStmt.setString(7, type);
            pStmt.executeUpdate();
            pStmt.close();
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static String getLastCustomerId( ) {
        int temp = 1;
        try {
            String id = "0";
            Connection con = getConnection();
            String query = "select CustomerID from Customer order by 1 desc limit 1";
            Statement stmnt = con.createStatement();
            ResultSet res = stmnt.executeQuery(query);
            System.out.println("Checked." + res);
            if (res == null ){
                return "000001";
            }
            while (res.next()) {
                id = res.getString(1);
            }
            System.out.println(id);
            temp = Integer.parseInt(id);
            temp++;
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        String s = Float.toString(temp);
        s = s.substring(0, s.length() - 2);
        System.out.println(s);
        while(s.length() < 6){
            s = "0" + s;
        }
        return s;
    }

    public static JTable getSelectedData(String tableName, String[] param, 
            String[] predicate) {
        String values = "";
        for (int i = 0; i < 5; i++) {
            if(param[i] != null){
                values += param[i] +",";
            }
        }
        values = values.substring(0, values.length() - 1);
        System.out.println("Values " + values);
        
        Vector columnNames = new Vector();
        Vector data = new Vector();
        try {
            Connection con = DataConnection.getConnection();
            PreparedStatement pStmt = con.prepareStatement(
                    "select "+values+ " from "+tableName+" where " + predicate[0]+" ="
                    + " '"+predicate[1]+"';");
            System.out.println("Statement " +pStmt);
            ResultSet resultSet = pStmt.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columns = metaData.getColumnCount();
            for (int i = 1; i <= columns; i++) {
                columnNames.addElement(metaData.getColumnName(i));
                System.out.println("Column "+metaData.getColumnName(i));
            }
            while (resultSet.next()) {
                System.out.println("while");
                Vector row = new Vector(columns);
                for (int i = 1; i <= columns; i++) {
                    row.addElement(resultSet.getObject(i));
                }
                data.addElement(row);
            }
            resultSet.close();
            pStmt.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        System.out.println("Done resultset.");
        JTable table = new JTable(data, columnNames);
        TableColumn column;
        for (int i = 0; i < table.getColumnCount(); i++) {
            System.out.println("For");
            column = table.getColumnModel().getColumn(i);
            column.setMaxWidth(250);
        }
        
        return table;
    }
}
