package com.capping.javarest.javaRestApp;

import java.util.ArrayList;

public class getContam 
{
	//getContam(x,y) -> takes full list of users and list of sick users and makes a new ArrayList of "contaminated" user
		public static ArrayList<Users> getContam(ArrayList<ArrayList<Users>> userList, ArrayList<Users> infList)
		{
			
			ArrayList<Boolean> checked = new ArrayList<Boolean>();
			for(int c= 0; c < userList.size(); c++) {
				checked.add(false);
			}
			
			boolean run = true;

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
						//Check if we've checked this table already
						if(checked.get(i) == false) 
						{

							//System.out.println(userList.get(i).get(j) + " is " + (userList.get(i).get(j).getContam()));

							//If the x-value of the healthy and sick user is within .000021 (6ft), go into next loop
							if(userList.get(i).get(j).getX() - infList.get(k).getX() <= .000021 ||  infList.get(k).getX() - userList.get(i).get(j).getX() >= .000021 && userList.get(i).get(j).getY() - infList.get(k).getY() <= .000016 ||  infList.get(k).getY() - userList.get(i).get(j).getY() >= .000016)
							{
								//If the y-value of the healthy and sick user is within .000016 (6ft), go into next loop
								if(userList.get(i).get(j).getY() - infList.get(k).getY() <= .000016 ||  infList.get(k).getY() - userList.get(i).get(j).getY() >= .000016)
								{

									//If the time that the healthy and sick user is equal...
									if(userList.get(i).get(j).getTime().compareTo(infList.get(k).getTime()) == 0)
									{
											//if the hashes match, the program does not proceed == 0 WAS ORIGINAL
											if(userList.get(i).get(j).getHash().compareTo(infList.get(k).getHash()) != 0)
											{	
												/*for(int q=0; q < userList.get(i).size(); q++){
													
													if(userList.get(i).get(j).getContam() == 1){
														System.out.println("Am I doing anything?");
														run = false;
														q= userList.get(i).size() + 1000000;
													}
												}*/
												if(userList.get(i).get(j).getContam() != 1)										
												{
													//Then add that healthy user to the infected list...
													contList.add(userList.get(i).get(j));
													
													checked.set(i, true);
												}									
											}
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
		}
}
