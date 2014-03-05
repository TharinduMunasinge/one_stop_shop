/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ViewLayer;

import DataLayer.DataConnection;

/**
 *
 * @author Malakagl
 */
public class test {
    public static void main(String a[]){
        DataConnection dc = new DataConnection();
        System.out.println("Connection : " + dc.getConnection());
    }
}
