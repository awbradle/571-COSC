// Andrew Bradley
// COSC 571
// E01485852

// This is the 4th query that left joins employees with customers and prints
//the number of customers and numer of employees for each city with employees
// It modifies sample code given in class and from Tutorials Point on using
// Java to connect to a sqlite3 database.
//To run compile and use command:
//java -classpath ".:sqlite-jdbc-3.8.11.2.jar" Query4

import java.sql.*;

public class Query4
{
  public static void main( String args[] )
  {
    Connection c = null;
    Statement stmt = null;
    //Open Database, output query data if successful
    try {
      Class.forName("org.sqlite.JDBC");
      c = DriverManager.getConnection("jdbc:sqlite:Northwind.db");
      c.setAutoCommit(false);
      System.out.println("Opened database successfully");
      System.out.println("********************************************");
      System.out.println("*      City      * #Employees * #Customers *");
      System.out.println("********************************************");
      stmt = c.createStatement();
      ResultSet rs = stmt.executeQuery
      	( "Select E.city, E.emp, C.cust FROM (SELECT E.city, COUNT(E.city) AS emp FROM Employees E GROUP BY E.city) as E LEFT JOIN (SELECT C.city, COUNT(C.city) AS cust FROM Customers C GROUP BY C.city) as C ON E.city = C.city" );
       //get data from read in tuple and print formatted to the screen
      while ( rs.next() ) {
         String city = rs.getString("city");
         int employee = rs.getInt("emp");
         int customer = rs.getInt("cust");
         System.out.printf("* %-15s* %10d * %10d *%n",city,employee,customer);
      }
      rs.close();
      stmt.close();
      c.close();
      System.out.println("********************************************");
    } catch ( Exception e ) {
      System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      System.exit(0);
    }
    System.out.println("Operation done successfully");
  }
}