/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ControllLayer;

import DataLayer.DataConnection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JTable;
import javax.swing.table.TableColumn;

/**
 *
 * @author Malakagl
 */
public class ManagerController {

    public static int insertCustomer(String[][] details) {
        return DataConnection.insertData("Customer", details);
    }

    public static JTable getTable(Object[] conds) {

        String[] param = new String[6];
        for (int i = 0; i < param.length; i++) {
            param[i] = "";
        }

        String attr, predicate;

        attr = (String)conds[0];
        predicate = (String) conds[1];

        if ((Boolean) conds[2]) {
            param[0] = "CustomerID";
        }
        if ((Boolean) conds[3]) {
            param[1] = "Name";
        }
        if ((Boolean) conds[4]) {
            param[2] = "AddressCity";
        }
        if ((Boolean) conds[5]) {
            param[3] = "Email";
        }
        if ((Boolean) conds[6]) {
            param[4] = "CustomerType";
        }
        if ((Boolean) conds[7]) {
            param[5] = "TelephoneNumber";
        }

        ResultSet resultSet = DataConnection.getJoin("Customer",
                "CustomerContact" , "CustomerID" , "ID" , 
                param , attr , predicate);
        if (resultSet == null) {
            return null;
        } else {
            return getTable(resultSet);
        }
    }

    public static String getNewCustomerID() {
        return DataConnection.getLastId("Customer");
    }

    public static String[] getCustomerDetails(String id) {
        String[] details = new String[8];
        try {
            String[] all = new String[1];
            all[0] = "*";

            ResultSet rs = DataConnection.getSelectedData("Customer natural "
                    + "join customercontact", all, "CustomerID", id);
            System.out.println("Resultset : " + rs);
            if (rs.next()) {
                details[0] = rs.getString(1);
                details[1] = rs.getString(2);
                details[2] = rs.getString(3);
                details[3] = rs.getString(4);
                details[4] = rs.getString(5);
                details[5] = rs.getString(6);
                details[6] = rs.getString(7);
                if (rs.next()) {
                    details[7] = rs.getString(8);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManagerController.class.getName()).log(
                    Level.SEVERE, null, ex);
        }
        return details;
    }

    private static JTable getTable(ResultSet resultSet) {
        try {
            Vector columnNames = new Vector();
            Vector data = new Vector();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columns = metaData.getColumnCount();
            for (int i = 1; i <= columns; i++) {
                columnNames.addElement(metaData.getColumnName(i));
                System.out.println("Column " + metaData.getColumnName(i));
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

            JTable table = new JTable(data, columnNames);
            TableColumn column;
            for (int i = 0; i < table.getColumnCount(); i++) {
                column = table.getColumnModel().getColumn(i);
                column.setMaxWidth(250);
            }

            return table;
        } catch (SQLException ex) {
            Logger.getLogger(ManagerController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static boolean updateCust(String[] details) {
        String update = "UPDATE Customer SET Name = '" + details[1]
                + "' , AddressCity = '" + details[2] + "' , AddressStreet = '"
                + details[3] + "' , AddressNumber = '" + details[4]
                + "' , Email = '" + details[5] + "' , CustomerType = '"
                + details[6] + "' WHERE CustomerID = '" + details[0] + "';";
        System.out.println("update : " + update);
        return DataConnection.update("Customer", update);
    }

    public static boolean removeCust(String table, String id) {
        return DataConnection.remove(table, id, "CustomerID");
    }

    public static String getNewSupplierID() {
        return DataConnection.getLastId("Supplier");
    }

    public static int insertSupplier(String[][] details) {
        return DataConnection.insertData("Supplier", details);
    }

    public static int insertContact(String[][] contact) {
        String[][] temp = new String[2][1];

        temp[0][0] = contact[0][0];
        temp[1][0] = contact[0][1];
        int t1 = DataConnection.insertData("customercontact", temp);
        if ((temp[0][0] = contact[1][0]) != "") {
            int t2 = DataConnection.insertData("customercontact", temp);
            if ((t1 > 0) && (t2 > 0)) {
                return 1;
            }
        }
        if (t1 > 0) {
            return 1;
        }
        return 0;
    }
}
