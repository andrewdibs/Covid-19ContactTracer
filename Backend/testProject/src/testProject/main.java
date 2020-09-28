package testProject;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Properties;
import java.util.Date;

public class main {
	
	public static void main(String[] args) throws SQLException, ClassNotFoundException {
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
			//System.out.println(myRs.getString("hash") + ", " + myRs.getDouble("x") + "," + myRs.getDouble("y") + "," + myRs.getDate("time") + "," + myRs.getInt("infected"));
			Users user = new Users(myRs.getString("hash"), myRs.getDouble("x"), myRs.getDouble("y"), myRs.getDate("time"), myRs.getInt("infected"));
			
			//System.out.println("user: " + user);
			//System.out.println(user.getHash());
			//System.out.println(user.toString());
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
		
		//System.out.println(userList);
		
		//Tests ArrayList (FOR TESTING)
		for(int i = 0; i < userList.size(); i++)
		{
			System.out.println(userList.get(i));
			//System.out.println(userList.get(i).toString(userList.toArray()));
			//System.out.println(userList.get(i).getHash());
			//System.out.print(userList.get(i).getX());
			//System.out.print(userList.get(i).getY());
		}
	}

}