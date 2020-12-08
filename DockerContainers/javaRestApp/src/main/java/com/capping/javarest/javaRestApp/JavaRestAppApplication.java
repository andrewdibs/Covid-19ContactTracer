package com.capping.javarest.javaRestApp;

import org.springframework.http.HttpStatus;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.Map;
import java.util.ArrayList;

@SpringBootApplication
@RestController
public class JavaRestAppApplication extends runTest {

	ArrayList<String> contamUsers = new ArrayList<String>();

	@GetMapping("/backend")
	public static void findSomething() {
		System.out.println("This is a test");
	}

	@GetMapping("/here")
	public String getMessage() {
		return "This is a test";
	}

	@RequestMapping(value = "/user" , method = RequestMethod.POST)
	public String getInfected(@RequestBody Map<String , String> user) throws SQLException , ClassNotFoundException {
		String myUser = user.get("hash");
		runTest(myUser);
		return myUser;
	}


 	/*@RequestMap(value = "/bruh" , method = RequestMethod.POST , produces = "application/json")
    ResponseEntity<> addTopic(@RequestBody Topic topic) {
          User user=new User();
          user.setName("myname");
          return new ResponseEntity<User>(user, httpHeaders, HttpStatus.CREATED);   
    }*/

	public static void main(String[] args) {
		SpringApplication.run(JavaRestAppApplication.class, args);
	}

}
