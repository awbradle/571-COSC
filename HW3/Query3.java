// Andrew Bradley
// COSC 571
// E01485852

// This is the third query that prints all cities and employee #s where
//the city has more than two employees in it.
// It modifies sample code given in class and from Tutorials Point on using
// Java to connect to a sqlite3 database.
//To run compile and use command:
//java -classpath ".:sqlite-jdbc-3.8.11.2.jar" Query3

import java.sql.*;

public class Query3
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
      System.out.println("**************************");
      System.out.println("*    City   * #Employees *");
      System.out.println("**************************");
      stmt = c.createStatement();
      ResultSet rs = stmt.executeQuery
      	( "Select E.City, E.Emptot FROM (SELECT E.City, COUNT(E.EmployeeID) as Emptot FROM Employees E GROUP BY E.City) as E Where E.Emptot >= 2;" );
      //get data from read in tuple and print formatted to the screen
      while ( rs.next() ) {
         String city = rs.getString("E.City");
         int  emptotal = rs.getInt("E.Emptot");
         System.out.printf("* %-10s* %10d *%n",city,emptotal);
      }
      rs.close();
      stmt.close();
      c.close();
      System.out.println("**************************");
    } catch ( Exception e ) {
      System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      System.exit(0);
    }
    System.out.println("Operation done successfully");
  }
}