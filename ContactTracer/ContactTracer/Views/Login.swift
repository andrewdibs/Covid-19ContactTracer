//
//  Login.swift
//  ContactTracer
//
//  Created by dibs on 10/14/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    
    func goSignup(){
        NavigationView{
            SignUp()
        }
        
    }
    
    func login(){
     
    }
    
    func getBioMetricStatus() -> Bool {
        
        return true
    }
    
    var body: some View {
        
        
        return ZStack {
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
                
                
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                
                
                HStack{
                    Image(systemName: "envelope")
                        .foregroundColor(Color.white.opacity(0.5))
                    TextField("email", text: $email)
                }.padding()
                    .background(Color.white.opacity(email == "" ? 0.18 : 1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "lock")
                    .foregroundColor(Color.white.opacity(0.5))
                    SecureField("password", text: $password)
                }.padding()
                    .background(Color.white.opacity(password == "" ? 0.18: 1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                
                HStack{
                    Button(action: login) {
                    Text("Login")
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0/255, green: 128/255, blue: 255/255))
                        .padding(.vertical)
                        .frame(width:UIScreen.main.bounds.width - 150)
                        .background(Color.white.opacity(0.78))
                        .clipShape(Capsule())
                    }.padding(.top)
                        .opacity(email != "" && password != "" ? 1 : 0.5)
                        .disabled(email != "" && password != "" ? false : true)
                    
                    Button(action:{},label:{
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .background(Color(.white))
                    })
                }
                
                Spacer(minLength: 0)
                
                HStack(spacing:5){
                    Text("Dont have an account? ")
                        .foregroundColor(Color.white.opacity(0.6))
                    
                    Button(action: goSignup) {
                    Text("Sign Up")
                        .fontWeight((.heavy))
                        .foregroundColor(Color.white)
                        
                    }
                }
            }.padding()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
