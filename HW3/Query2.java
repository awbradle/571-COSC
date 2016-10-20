// Andrew Bradley
// COSC 571
// E01485852

// This is the second query that returns customer contact for customers having fax #'s
// It modifies sample code given in class and from Tutorials Point on using
// Java to connect to a sqlite3 database.
//To run compile and use command:
//java -classpath ".:sqlite-jdbc-3.8.11.2.jar" Query2


import java.sql.*;

public class Query2
{
  public static void main( String args[] )
  {
    Connection c = null;
    Statement stmt = null;
    
    //Open Database, output query data if successful
    try {
      int i = 0; //counter to output 15 tuples
      Class.forName("org.sqlite.JDBC");
      c = DriverManager.getConnection("jdbc:sqlite:Northwind.db");
      c.setAutoCommit(false);
      System.out.println("Opened database successfully");
      System.out.println("*****************************************************************************************************");
      System.out.println("*              Company Name               *         Contact Name          *        Fax Number       *");
      System.out.println("*****************************************************************************************************");
      stmt = c.createStatement();
      ResultSet rs = stmt.executeQuery
      	( "SELECT CompanyName, ContactName, Fax FROM Customers WHERE Fax NOT NULL;" );
      //get data from read in tuple and print first 15 formatted to the screen
      while ( rs.next() ) {
         if(i++ < 15){
            String companyName = rs.getString("CompanyName");
	    String contactName = rs.getString("ContactName");
	    String fax = rs.getString("Fax");
	    System.out.printf("* %-40s* %-30s* %-24s*%n",companyName,contactName,fax);
         }
      }
      System.out.println("*****************************************************************************************************");
      //print # of tuples because there are > 15
      System.out.println("Number of tuples: " + i);
      rs.close();
      stmt.close();
      c.close();
    } catch ( Exception e ) {
      System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      System.exit(0);
    }
    System.out.println("Operation done successfully");
  }
}