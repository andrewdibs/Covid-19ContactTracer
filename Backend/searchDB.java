package cap;

//calendar instead of date
import java.util.Date;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class searchDB 
{
	//given a hash, go to the DB and retrieve the information on that specific user
		public static ArrayList<Users> searchDB(String hash) throws SQLException, ClassNotFoundException
		{
			Class.forName("com.mysql.jdbc.Driver"); 
			Connection myConn = null;
			Statement myStmt = null;
			ResultSet myRs = null;
			ArrayList<Users> sickUser = new ArrayList<Users>();
			try {
				// 1. Get a connection to database
				myConn = DriverManager.getConnection("jdbc:mysql://localhost:3308/cap", "root" , "password");
				
				// 2. Create a statement
				myStmt = myConn.createStatement();
				
				//Goes through userList and we add from every single entry from our user's own tables			
					myRs = myStmt.executeQuery("Select * from " + hash);
				
					//adds the entire database entry into our ArrayList<Users>
					while (myRs.next()) {
						//EDIT
						Users user = new Users(myRs.getString("hash"), myRs.getDouble("x"), myRs.getDouble("y"), myRs.getTimestamp("time"), myRs.getInt("contam"));
						sickUser.add(user);
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
			return sickUser;
			
		}
}
