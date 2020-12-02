package cap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class updateContam 
{
	//updated every table that has a potential contaminated user
		//by inserting a blank statement, with the contaminated value changed to 1 
		public static void updateContam(ArrayList<Users> contList) throws SQLException, ClassNotFoundException
		{
			//creating a connection
			Class.forName("com.mysql.jdbc.Driver"); 
			Connection myConn = null;
			Statement myStmt = null;
			//creating an int to act as my insert statement
			int insertQuery = 0;
			
			try {
				// 1. Get a connection to database
				myConn = DriverManager.getConnection("jdbc:mysql://localhost:3308/cap", "root", "password");
				
				// 2. Create a statement
				myStmt = myConn.createStatement();
				
				//going through the entire contList 
				for(int i = 0; i < contList.size(); i++)
				{
					//inserting an empty entry to our contaminated table, with the contam at 1 to indicate an at risk individual
					System.out.println("Adding to " + contList.get(i).getHash());
					insertQuery = myStmt.executeUpdate("INSERT INTO " + contList.get(i).getHash() 
							+ "(hash, x, y, time, contam) "
							+ "VALUES ('" + contList.get(i).getHash() + "','0','0','2000:01:01 01:01:01','1');");
				}					
			}
			catch (Exception exc) {
				exc.printStackTrace();
			}
			finally {
				
				if (myStmt != null) {
					myStmt.close();
				}
				
				if (myConn != null) {
					myConn.close();
				}
			}
					
	}
}
