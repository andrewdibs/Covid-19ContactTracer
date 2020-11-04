package cap;
import java.sql.*;
import java.util.ArrayList;

public class runTest 
{
	
	public static void main(String[] args) throws SQLException, ClassNotFoundException 
	{
		String user = "abc";
		runTest(user);
	}
	
	
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