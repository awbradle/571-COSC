import java.sql.*;


public class Query5
{
  public static void main( String args[] )
  {
    Connection c = null;
    Statement stmt = null;
    int i = 0; //counter for 15 tuples
    try {
      Class.forName("org.sqlite.JDBC");
      c = DriverManager.getConnection("jdbc:sqlite:Northwind.db");
      c.setAutoCommit(false);
      System.out.println("Opened database successfully");
      System.out.println("********************************************");
      System.out.println("*      City      * #Customers * #Employees *");
      System.out.println("********************************************");
      stmt = c.createStatement();
      ResultSet rs = stmt.executeQuery
      	( "Select C.city, C.cust, E.emp FROM (SELECT C.city, COUNT(C.city) AS cust FROM Customers C GROUP BY C.city) as C LEFT JOIN (SELECT E.city, COUNT(E.city) AS emp FROM Employees E GROUP BY E.city) as E ON C.city = E.city;" );
      while ( rs.next() ) {
         if(i++ < 15){
            String city = rs.getString("city");
            int customer = rs.getInt("cust");
            int employee = rs.getInt("emp");
            System.out.printf("* %-15s* %10d * %10d *%n",city,customer,employee);
         }
      }
      rs.close();
      stmt.close();
      c.close();
      System.out.println("********************************************");
      System.out.println("Number of tuples: " + i);
    } catch ( Exception e ) {
      System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      System.exit(0);
    }
    System.out.println("Operation done successfully");
  }
}