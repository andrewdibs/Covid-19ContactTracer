package com.capping.javarest.javaRestApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.Map;

@SpringBootApplication
@RestController
public class JavaRestAppApplication extends tester {

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
		System.out.println(myUser);
		runTest(myUser);
		return myUser;
	}

	public static void main(String[] args) {
		SpringApplication.run(JavaRestAppApplication.class, args);
	}

}
