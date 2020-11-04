package cap;
import java.sql.*;
import java.util.ArrayList;

public class tester 
{
	
	public static void main(String[] args) throws SQLException, ClassNotFoundException 
	{
		String user = "abc";
		runTest(user);
	}
	
	/*public static ArrayList<String> getUsers() throws SQLException, ClassNotFoundException
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
	}	*/
	
	/*public static ArrayList<ArrayList<Users>> getData(ArrayList<String> users) throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		ArrayList<ArrayList<Users>> tables = new ArrayList<ArrayList<Users>>();
		
		try {
			// 1. Get a connection to database
			myConn = DriverManager.getConnection("jdbc:mysql://localhost:3308/cap", "root" , "password");
			
			// 2. Create a statement
			myStmt = myConn.createStatement();
			
			//Goes through userList and we add from every single entry from our user's own tables
			for(int i=0; i < users.size();i++) {
				myRs = myStmt.executeQuery("select * from " + users.get(i));
				
				ArrayList<Users> userList = new ArrayList<>();
				
				//adds the entire database entry into our ArrayList<Users>
				while (myRs.next()) {
					Users user = new Users(myRs.getString("hash"), myRs.getDouble("x"), myRs.getDouble("y"), myRs.getDate("time"), myRs.getInt("contam"));
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
		
	}*/
	
	/*
	public static ArrayList<Users> getInfected(ArrayList<ArrayList<Users>> userList){
		//Declare ArrayList that will hold infected users
		ArrayList<Users> infList = new ArrayList<>();
		
		//Loop through the initial arrayList and go through each table
		for(int i=0; i < userList.size(); i++) {
			//Loop through the arrayList within the arrayList 
			for(int j=0; j < userList.get(i).size(); j++) {
				//If the user in the table is sick...
				if(userList.get(i).get(j).getSick() == 1) {
					//Add them to the array of sick users
					infList.add(userList.get(i).get(j));
				}
			}			
		}
	    
	    //Return the infected List
		return infList;
	}
	*/
	
	//getContam(x,y) -> takes full list of users and list of sick users and makes a new ArrayList of "contaminated" user
	/*public static ArrayList<Users> getContam(ArrayList<ArrayList<Users>> userList, ArrayList<Users> infList)
	{
		//Instantiate new ArrayList for contaminated users
		ArrayList<Users> contList = new ArrayList<Users>();
		
		//Loop through the initial arrayList and go through each table
		for(int i=0; i < userList.size();i++) 
		{
			//Loop through the arrayList within the arrayLIst
			for(int j=0; j < userList.get(i).size(); j++) 
			{
				//For the whole length of j (infList)
				for(int k= 0; k < infList.size(); k++) 
				{
									
					//If the x-value of the healthy and sick user is within .000021 (6ft), go into next loop
					if(userList.get(i).get(j).getX() - infList.get(k).getX() <= .000021 ||  infList.get(k).getX() - userList.get(i).get(j).getX() >= .000021)
					{
						//If the y-value of the healthy and sick user is within .000016 (6ft), go into next loop
						if(userList.get(i).get(j).getY() - infList.get(k).getY() <= .000016 ||  infList.get(k).getY() - userList.get(i).get(j).getY() >= .000016)
						{
							//If the time that the healthy and sick user is equal...
							if(userList.get(i).get(j).getTime().compareTo(infList.get(k).getTime()) == 0 )
							{
									//if the hashes match, the program does not proceed 
									if(userList.get(i).get(j).getHash().compareTo(infList.get(k).getHash()) != 0)
									{	
										//-System.out.println(userList.get(i).get(j).getHash() + " = " + infList.get(k).getHash() + "?");
										//Then add that healthy user to the infected list...
										contList.add(userList.get(i).get(j));
									}
							}
						}
					}
				}
			}
				
			}
		
				
		//Return which users have been compromised for COVID
		System.out.println("WARNING: These users may have COVID");
		System.out.println(contList);
		return contList;
	}*/
	
	//updated every table that has a potential contaminated user
	//by inserting a blank statement, with the contaminated value changed to 1 
/*	public static void updateContam(ArrayList<Users> contList) throws SQLException, ClassNotFoundException
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
				System.out.print("Adding to " + contList.get(i).getHash());
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
				
}*/
	//given a hash, go to the DB and retrieve the information on that specific user
	/*public static ArrayList<Users> searchDB(String hash) throws SQLException, ClassNotFoundException
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
					Users user = new Users(myRs.getString("hash"), myRs.getDouble("x"), myRs.getDouble("y"), myRs.getDate("time"), myRs.getInt("contam"));
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
		
	}*/
	
	private static void runTest(String sickUser) throws SQLException, ClassNotFoundException {
		//Instantiate myTables, the ArrayList+ that will hold the values of each user in the database
		ArrayList<ArrayList<Users>> myTables = new ArrayList<ArrayList<Users>>();
		
		//Instantiate use, the ArrayList<String> that holds the hash values of all the users in the database
		ArrayList<String> use = new ArrayList<String>();
		
		//Instantiate myInf, the ArrayList<Users> that will hold the values of the specific sick user
		ArrayList<Users> myInf = new ArrayList<Users>();
		
		//Instantiate myCont, the ArrayList<Users> that holds all the users who are contaminated (were in contact with a sick user)
		ArrayList<Users> myCont = new ArrayList<Users>();
			
		//Call getUsers() to get an ArrayList of all the hash's in the database
		use = getUsers.getUsers();
		
		//Call getData to create an ArrayList+ using the hash values collected by getUsers
		myTables= getData.getData(use);
		
		//Search for the sick user's data and load it into an ArrayList
		myInf = searchDB.searchDB(sickUser);
		
		//Determine the contaminated users using the full database and the infected user's data
		myCont= getContam.getContam(myTables, myInf);
		
		//updateContam.updateContam(myCont);
		
		System.out.println("Complete");
	}
}