package com.capping.javarest.javaRestApp;;
import java.sql.*;
import java.util.ArrayList;

public class getData
{
	public static ArrayList<ArrayList<Users>> getData(ArrayList<String> users) throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		ArrayList<ArrayList<Users>> tables = new ArrayList<ArrayList<Users>>();
		
		try {
			// 1. Get a connection to database
			myConn = DriverManager.getConnection("jdbc:mysql://db:3306/db", "root", "FairView112");
			
			// 2. Create a statement
			myStmt = myConn.createStatement();
			
			//Goes through userList and we add from every single entry from our user's own tables
			for(int i=0; i < users.size();i++) {
				myRs = myStmt.executeQuery("select * from " + users.get(i));
				
				ArrayList<Users> userList = new ArrayList<>();
				
				//adds the entire database entry into our ArrayList<Users>
				while (myRs.next()) {
					Users user = new Users(myRs.getString("hash"), myRs.getDouble("x"), myRs.getDouble("y"), myRs.getDate("datetime"), myRs.getInt("compromised"));
					userList.add(user);
					}
				
				tables.add(userList);
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
		return tables;
		
	}

}



