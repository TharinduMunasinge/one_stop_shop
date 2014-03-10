/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ControllLayer;

import DataLayer.DataConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Vector;
import javax.swing.JTable;
import javax.swing.table.TableColumn;

/**
 *
 * @author Malakagl
 */
public class ManagerController {
    
    public static boolean insertCustomer(Customer c){
        boolean success = false;
        DataConnection.insertData(c.ID,c.addressCity,c.addressNumber
                ,c.addressStreet,c.email,c.name,c.type);
        return success;
    }
    
    public static JTable getTable(Object [] conds){
        
        String [] param = new String[5];
        String [] predicate = new String[2];
        
        if(((String)conds[0]).equals("Customer ID")){
            predicate[0] = "CustomerID";
        }
        else if(((String)conds[0]).equals("Customer Type")){
            predicate[0] = "CustomerType";
        }
        else{
            predicate[0] = (String)conds[0];
        }
        predicate[1] = (String)conds[1];
        if((Boolean)conds[2]){
            param[0] = "CustomerID";
        }
        if((Boolean)conds[3]){
            param[1] = "Name";
        }
        if((Boolean)conds[2]){
            param[2] = "AddressCity";
        }
        if((Boolean)conds[2]){
            param[3] = "Email";
        }
        if((Boolean)conds[2]){
            param[4] = "CustomerType";
        }
        
        return DataConnection.getSelectedData("Customer",param,predicate);
    }

    public static String getNewCustomerID() {
        return DataConnection.getLastCustomerId( );
    }
}
