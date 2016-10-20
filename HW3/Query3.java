import java.sql.*;


public class Query3
{
  public static void main( String args[] )
  {
    Connection c = null;
    Statement stmt = null;
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