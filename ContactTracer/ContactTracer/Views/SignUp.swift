//
//  SignUp.swift
//  ContactTracer
//
//  Created by dibs on 10/14/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI

struct SignUp: View {
    @State  private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    func postUserHash(){
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        let parameters: [String: String] = ["hash": "A342xce3sffHE324"]
        //create the url with URL
        guard let url = URL(string: "http://10.10.9.180:8080/user")else{return} //change the url
        //create the session object
        let session = URLSession.shared
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func goToLogin(){
        
    }
    
    func signUp(){
        postUserHash()
    }
    
    var body: some View {
        
        
        return ZStack{
            // background colors
            Rectangle()
                .foregroundColor(Color( red: 0/255, green: 128/255, blue: 255/255))
                .edgesIgnoringSafeArea(.all)
                       
            Rectangle()
                .foregroundColor(Color( red: 102/255, green: 153/255, blue: 255/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            // sign up information
            VStack{
                
                Spacer()
                Image("whiteMask").resizable()
                    .frame(width: 76.0, height: 76.0)
                
                
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                HStack{
                    Image(systemName: "")
                    TextField("full name", text: $name)
                }.padding()
                    .background(Color.white.opacity(name == "" ? 0.18 : 0.9))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "envelope")
                        .foregroundColor(Color.white.opacity(0.5))
                    TextField("email", text: $email)
                }.padding()
                    .background(Color.white.opacity(email == "" ? 0.18 : 0.9))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "lock")
                    .foregroundColor(Color.white.opacity(0.5))
                    SecureField("password", text: $password)
                }.padding()
                    .background(Color.white.opacity(password == "" ? 0.18 : 0.9))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                
                Button(action: signUp) {
                Text("Create Account")
                    .fontWeight(.heavy)
                    .foregroundColor(Color(red: 0/255, green: 128/255, blue: 255/255))
                    .padding(.vertical)
                    .frame(width:UIScreen.main.bounds.width - 150)
                    .background(Color.white.opacity(0.78))
                    .clipShape(Capsule())
                }.padding(.top)
                
                Spacer(minLength: 0)
                
                HStack(spacing:5){
                    Text("Already have an account? ")
                        .foregroundColor(Color.white.opacity(0.6))
                    
                    Button(action: goToLogin) {
                    Text("Login")
                        .fontWeight((.heavy))
                        .foregroundColor(Color.white)
                        
                    }
                }
            }.padding()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
