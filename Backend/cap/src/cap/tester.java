package cap;
import java.sql.*;
import java.util.ArrayList;
public class tester {
	
	public static void main(String[] args) throws SQLException, ClassNotFoundException 
	{
		ArrayList<Users> myUsers = new ArrayList<Users>();
		ArrayList<Users> myInf = new ArrayList<Users>();
		
		myUsers= getData();
		myInf= getInfected(myUsers);
	}
	
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
		//System.out.println(userList.get(0));
		
		//System.out.println(userList);
		return userList;
		
	}
	
	public static ArrayList<Users> getInfected(ArrayList<Users> userList){
		//Declare ArrayList that will hold infected users
		ArrayList<Users> infList = new ArrayList<>();
		
		//Go through userList and add all sick users to a new ArrayList, then remove them from userList
		for(int i=0; i < userList.size(); i++) {
			if(userList.get(i).getSick() == 1) {
				infList.add(userList.get(i));
				userList.remove(i);
			}
		}
		
		//for testing
		System.out.println("Healthy: " + userList);
	    System.out.println("Sick: " + infList);
	    
	    //Return the infected List
		return infList;
	}

}