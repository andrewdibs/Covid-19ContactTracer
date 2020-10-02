package cap;
import java.sql.*;
import java.util.ArrayList;

public class getData
{
	public static ArrayList<Users> getData() throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		ArrayList<Users> userList = new ArrayList<>();
		
		try {
			//Class.forName("com.mysql.jdbc.Driver");
			// 1. Get a connection to database
			myConn = DriverManager.getConnection("jdbc:mysql://localhost:3308/capping", "root" , "password");
			
			// 2. Create a statement
			myStmt = myConn.createStatement();
			
			// 3. Execute SQL query
			myRs = myStmt.executeQuery("select * from abc");
			
			// 4. Process the result set
			while (myRs.next()) {
			Users user = new Users(myRs.getString("hash"), myRs.getDouble("x"), myRs.getDouble("y"), myRs.getDate("time"), myRs.getInt("infected"));
			userList.add(user);
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
		
		return(userList);

	}

}



