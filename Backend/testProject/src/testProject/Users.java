package testProject;
import java.util.Date;

public class Users 
{
private String hash = null;
private double x = 0;
private double y = 0;
private Date time = null;
private int sick = 0;

public Users(String hash, double x, double y, Date time, int sick) 
{
	this.hash = hash;
	this.x = x;
	this.y = y;
	this.time = time;
	this.sick = sick;
}
public String getHash() {
	return hash;
}
public void setHash(String hash) {
	this.hash = hash;
}
public double getX() {
	return x;
}
public void setX(double x) {
	this.x = x;
}
public double getY() {
	return y;
}
public void setY(double y) {
	this.y = y;
}
public Date getTime() {
	return time;
}
public void setTime(Date time) {
	this.time = time;
}
public int getSick() {
	return sick;
}
public void setSick(int sick) {
	this.sick = sick;
}

public String toString()
{
	return "Hash: " + hash + " x: " + x + " y: " + y + " time: " + time + " sick:" + sick;
}
}
