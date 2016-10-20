import java.sql.*;


public class Query1
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
      System.out.println("**********************************************");
      System.out.println("*         Product Name          * Unit Price *");
      System.out.println("**********************************************");
      stmt = c.createStatement();
      ResultSet rs = stmt.executeQuery
      	( "SELECT ProductName, UnitPrice FROM Products ORDER BY UnitPrice desc LIMIT 10;" );
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