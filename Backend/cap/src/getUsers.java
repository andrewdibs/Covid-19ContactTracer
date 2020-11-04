package cap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class getUsers 
{
	public static ArrayList<String> getUsers() throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		ArrayList<String> allUsers = new ArrayList<String>();
		try {
			// 1. Get a connection to database
			myConn = DriverManager.getConnection("jdbc:mysql://localhost:3308/cap", "root", "password");
			
			// 2. Create a statement
			myStmt = myConn.createStatement();
			
			// 3. Execute SQL query to get all of the current users hashes
			myRs = myStmt.executeQuery("Select hash from users");			
			
			// 4. Process the result set
			while (myRs.next()) {
				//adding all of our current users hashes to an ArrayList<String>
				allUsers.add(myRs.getString("hash"));
			}			
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
		finally {
			if (myRs != null) {
				myRs.close();
			}
			
			if (myStmt != null) {
				myStmt.close();
			}
			
			if (myConn != null) {
				myConn.close();
			}
		}		
		return allUsers;		
	}	
}
