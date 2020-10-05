package cap;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
public class tester 
{
	
	public static void main(String[] args) throws SQLException, ClassNotFoundException 
	{
		ArrayList<Users> myUsers = new ArrayList<Users>();
		ArrayList<Users> myInf = new ArrayList<Users>();
		ArrayList<Users> myCont = new ArrayList<Users>();
		ArrayList<ArrayList<Users>> myTables = new ArrayList<ArrayList<Users>>();
		ArrayList<String> use = new ArrayList<String>();
		use = getUsers();
		
		myTables= getData(use);
		myInf= getInfected(myTables);
		
		//myUsers= getData(use);
		//myInf= getInfected(myUsers);
		//myCont= getContam(myUsers, myInf);
		
		System.out.println("");
		System.out.println(myInf);
		System.out.println("");
		System.out.print(myTables);
	}
	
	public static ArrayList<String> getUsers() throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		ArrayList<Users> userList = new ArrayList<>();
		ArrayList<String> allUsers = new ArrayList<String>();
		try {
			// 1. Get a connection to database
			myConn = DriverManager.getConnection("jdbc:mysql://localhost:3308/capping", "root" , "password");
			
			// 2. Create a statement
			myStmt = myConn.createStatement();
			
			// 3. Execute SQL query to get all of the current users hashes
			myRs = myStmt.executeQuery("Select * from users");			
			
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
	
	public static ArrayList<ArrayList<Users>> getData(ArrayList<String> users) throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		//ArrayList<Users> userList = new ArrayList<>();
		ArrayList<ArrayList<Users>> tables = new ArrayList<ArrayList<Users>>();
		
		try {
			// 1. Get a connection to database
			myConn = DriverManager.getConnection("jdbc:mysql://localhost:3308/capping", "root" , "password");
			
			// 2. Create a statement
			myStmt = myConn.createStatement();
			
			//Goes through userList and we add from every single entry from our user's own tables
			for(int i=0; i < users.size();i++) {
				myRs = myStmt.executeQuery("select * from " + users.get(i));
				
				ArrayList<Users> userList = new ArrayList<>();
				
				//adds the entire database entry into our ArrayList<Users>
				while (myRs.next()) {
					Users user = new Users(myRs.getInt("id"),myRs.getString("hash"), myRs.getDouble("x"), myRs.getDouble("y"), myRs.getDate("time"), myRs.getInt("healthy"));
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
		
		//for testing
		//System.out.println("Healthy: " + userList);
	    //System.out.println("Sick: " + infList);
	    
	    //Return the infected List
		return infList;
	}
	
	//getContam(x,y) -> takes full list of users and list of sick users and makes a new ArrayList of "contaminated" user
	public static ArrayList<Users> getContam(ArrayList<Users> userList, ArrayList<Users> infList)
	{
		//Instantiate new ArrayList for contaminated users
		ArrayList<Users> contList = new ArrayList<Users>();
		
		//For the whole length of i (userList)
		for(int i=0; i < userList.size(); i++) 
		{
			//For the whole length of j (infList)
			for(int j=0; j < infList.size(); j++)
			{
				//If the x-value of the healthy and sick user is within .000021 (6ft), go into next loop
				if(userList.get(i).getX() - infList.get(j).getX() <= .000021 ||  infList.get(j).getX() - userList.get(i).getX() >= .000021)
				{
					//If the y-value of the healthy and sick user is within .000016 (6ft), go into next loop
					if(userList.get(i).getY() - infList.get(j).getY() <= .000016 ||  infList.get(j).getY() - userList.get(i).getY() >= .000016)
					{
						//If the time that the healthy and sick user is equal...
						if(userList.get(i).getTime().compareTo(infList.get(j).getTime()) == 0 )//||  infList.get(j).getTime().compareTo(userList.get(i).getTime()))
						{
							//Then add that healthy user to the infected list...
							contList.add(userList.get(i));
							
							//and remove the healthy user from the userList
							userList.remove(i);							
						}
					 }		
				}
			}
		}
				
		//Return which users have been compromised for COVID
		System.out.println("WARNING: These users may have COVID");
		System.out.println(contList);
		return contList;
	}
}