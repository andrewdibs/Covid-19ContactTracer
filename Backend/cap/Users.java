package cap;
import java.util.Date;

//User Object - Stores the values from the database
public class Users 
{
private String hash = null;
private double x = 0;
private double y = 0;
private Date time = null;
private int sick = 0;

//User Constructor:
public Users(String hash, double x, double y, Date time, int sick) 
{
	this.hash = hash;
	this.x = x;
	this.y = y;
	this.time = time;
	this.sick = sick;
}

//-----Hash-----
//getHash() - Getter statement for hash
public String getHash() {
	return hash;
}

//setHash() - Setter statement for hash
public void setHash(String hash) {
	this.hash = hash;
}

//-----x-----
//getX() - Getter Statement for x
public double getX() {
	return x;
}

//setX - Setter statement for x
public void setX(double x) {
	this.x = x;
}

//-----y-----
//getY() - Getter Statement for y
public double getY() {
	return y;
}

//setY() - Setter Statement for y
public void setY(double y) {
	this.y = y;
}

//-----time-----
//getTime() - Getter statement for time
public Date getTime() {
	return time;
}

//setTime() - Setter statement for time
public void setTime(Date time) {
	this.time = time;
}

//-----sick-----
//getSick() - Getter statement for sick
public int getSick() {
	return sick;
}

//setSick() - Setter statement for sick
public void setSick(int sick) {
	this.sick = sick;
}

//----ToString()-----
//Allows us to print the object's contents in a coherent manner
public String toString()
{
	return "{Hash: " + hash + " x: " + x + " y: " + y + " time: " + time + " sick:" + sick + "}";
}

}
