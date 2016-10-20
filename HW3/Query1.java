// Andrew Bradley
// COSC 571
// E01485852

// This is the first query that returns the top 10 most expensive products.
// It modifies sample code given in class and from Tutorials Point on using
// Java to connect to a sqlite3 database.
//To run compile and use command:
//java -classpath ".:sqlite-jdbc-3.8.11.2.jar" Query1

import java.sql.*;

public class Query1
{
  public static void main( String args[] )
  {
    Connection c = null;
    Statement stmt = null;
    //attempt to open database and print results
    try {
      Class.forName("org.sqlite.JDBC");
      c = DriverManager.getConnection("jdbc:sqlite:Northwind.db");
      c.setAutoCommit(false);
      System.out.println("Opened database successfully");
      System.out.println("**********************************************");
      System.out.println("*         Product Name          * Unit Price *");
      System.out.println("**********************************************");
      stmt = c.createStatement();
      ResultSet rs = stmt.executeQuery
      	( "SELECT ProductName, UnitPrice FROM Products ORDER BY UnitPrice desc LIMIT 10;" );
      //gets data from the read in tuple and prints it formatted to the screen
      while ( rs.next() ) {
         String name = rs.getString("ProductName");
         float  unitPrice = rs.getFloat("UnitPrice");
         System.out.printf("* %-30s* %10.2f *%n",name,unitPrice);
      }
      rs.close();
      stmt.close();
      c.close();
      System.out.println("**********************************************");
    } catch ( Exception e ) {
      System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      System.exit(0);
    }
    System.out.println("Operation done successfully");
  }
}