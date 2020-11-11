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
    
    @ObservedObject var user: User
    @State private var initilized = UserDefaults.standard.integer(forKey: "init")
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(Color( red: 0/255, green: 128/255, blue: 255/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color( red: 102/255, green: 153/255, blue: 255/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            VStack{
 
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Image("whiteMask").resizable()
                                   .frame(width: 200.0, height: 200.0)
                
                Spacer()
                Image(systemName:  "faceid" )
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Text("Please enable faceID ")
                    .foregroundColor(.white)
  
            }
        }.onAppear(perform: initilize)
        
    }
    func initilize(){
        
        getUserData()
        
        if (initilized != 1){
            
            print("initial posting")
            
            UserDefaults.standard.set(1, forKey: "init")
        }
    }
    
    
    
    func getUserData(){
        // initilizes user data
    }
    
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(user: User())
    }
}
