/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataLayer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Malakagl
 */
public class DataConnection {

    public static Connection getConnection() {
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost/One_Stop_Shop", "root", "");
            return con;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE,
                    null, ex);

        }
        return null;
    }

    public static int insertData(String table , String [][] details) {
        int temp = 0;
        try {
            Connection con = getConnection();
            String values = "'";
            
            for (int i = 0; i < details.length; i++) {
                    values += details[i][0] +"','";
            }
            
            values = values.substring(0, values.length()-2);
            PreparedStatement pStmt = con.prepareStatement(
                    "insert into "+ table +" value("+values+")");
            System.out.println("Statement : " + pStmt);
            temp = pStmt.executeUpdate();
            pStmt.close();
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return temp;
    }

    public static String getLastId(String table) {
        int temp = 1;
        try {
            String id = "0";
            Connection con = getConnection();
            String query = "select " + table + "ID from " + table + " order by 1 desc "
                    + "limit 1";
            Statement stmnt = con.createStatement();
            ResultSet res = stmnt.executeQuery(query);
            System.out.println("Checked." + res);
            if (res == null) {
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
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        String s = Float.toString(temp);
        s = s.substring(0, s.length() - 2);
        System.out.println(s);
        while (s.length() < 6) {
            s = "0" + s;
        }
        return s;
    }

    public static ResultSet getSelectedData(String tableName, String[] param,
            String attr, String predicate) {
        try {
            String values = "";
            for (int i = 0; i < param.length; i++) {
                System.out.println("Parameter " + i + " : " + param[i]);
                if (!param[i].equals("")) {
                    values += param[i] + ",";
                }
            }

            values = values.substring(0, values.length() - 1);
            System.out.println("Values " + values);
            System.out.println("Predicates " + predicate);

            Connection con = DataConnection.getConnection();
            PreparedStatement pStmt = con.prepareStatement(
                    "select " + values + " from " + tableName + " where "
                    + attr + " = '" + predicate + "';");
            System.out.println("Statement " + pStmt);
            ResultSet resultSet = pStmt.executeQuery();

            return resultSet;
        } catch (SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return null;
    }

    public static boolean update(String table, String update) {
        try {
            Connection con = DataConnection.getConnection();
            PreparedStatement pStmt = con.prepareStatement(update);
            pStmt.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE,
                    null, ex);
            return false;
        }
    }

    public static boolean remove(String table, String val, String attr) {
        try {
            Connection con = DataConnection.getConnection();
            PreparedStatement pStmt = con.prepareStatement(
                    "DELETE FROM " + table + " WHERE " + attr + " = '"
                    + val + "'");
            return pStmt.execute();
        } catch (SQLException ex) {
            Logger.getLogger(DataConnection.class.getName()).log(Level.SEVERE,
                    null, ex);
            return false;
        }
    }
}
