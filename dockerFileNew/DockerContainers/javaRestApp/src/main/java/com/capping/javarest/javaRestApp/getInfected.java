package com.capping.javarest.javaRestApp;
import java.sql.*;
import java.util.ArrayList;
public class getInfected 
{
	public static ArrayList<Users> getInfected(ArrayList<ArrayList<Users>> userList){
		//Declare ArrayList that will hold infected users
		ArrayList<Users> infList = new ArrayList<>();
		
		//Loop through the initial arrayList and go through each table
		for(int i=0; i < userList.size(); i++) {
			//Loop through the arrayList within the arrayList 
			for(int j=0; j < userList.get(i).size(); j++) {
				//If the user in the table is sick...
				if(userList.get(i).get(j).getContam() == 1) {
					//Add them to the array of sick users
					infList.add(userList.get(i).get(j));
				}
			}			
		}
	    
	    //Return the infected List
		return infList;
	}
}
