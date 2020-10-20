package com.capping.javarest.javaRestApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@SpringBootApplication
@RestController
public class JavaRestAppApplication {

	@GetMapping("/backend")
	public static void findSomething() {
		System.out.println("AlexHasASmallPenis");
	}

	@GetMapping("/here")
	public String getMessage() {
		return "Alex Has A Small PeePee";
	}

	@RequestMapping(value = "/user" , method = RequestMethod.POST)
	public String getInfected(@RequestBody Map<String , String> user) {
		String myUser = user.get("hash");
		System.out.println(myUser);
		return myUser;
	}

	public static void main(String[] args) {
		SpringApplication.run(JavaRestAppApplication.class, args);
	}

}
