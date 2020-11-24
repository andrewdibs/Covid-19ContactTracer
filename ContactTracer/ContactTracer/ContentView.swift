//
//  ContentView.swift
//  ContactTracer
//
//  Created by dibs on 9/9/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import Combine
import MapKit

class User: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    let hash: String = UIDevice.current.identifierForVendor?.uuidString ?? "hash"
    var initilized = false { didSet{ didChange.send() } }
    
}


struct ContentView: View {

    // Authentication state variable
    @State var logged = false
    @ObservedObject var user = User()
    @State var emailSet = false
    @State var initilized = UserDefaults.standard.integer(forKey: "email")
    
    
    var body: some View {
        
        ZStack{
            if (self.logged){
                // if email not already configured display signup
                if (!emailSet) {
                    Signup(user: self.user, emailSet: $emailSet)
                }else{
                    // return the main content view
                    Home(user: self.user)
                }
            }
            else{
                //login every time user opens app
                Login(user: self.user)
            }
            
        }.onAppear(perform: authenticate)
        
    }
   
    // Allows authentication with biometric faceID or touchID
    func authenticate() {
        print("init: \(self.initilized)")
        if (self.initilized == 1){
            self.emailSet = true
        }
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let prompt = "To ensure your privacy allow faceID or touchID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: prompt) { success, authenticationError in DispatchQueue.main.async{
                    if success {
                        self.logged = true
                        print("authenticated")
                    }
                    else {
                        print("faceid failed")
                    }
                }
            }
        }
    }
        
}
struct Signup: View {

    @ObservedObject var user: User
    @State var email = ""
    @Binding var emailSet: Bool
    var body: some View {
        print(user.initilized)
        // POST
        func postUserHash(){
            //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
            print("fire post" )
            let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            print(hashnodash)
            let parameters: [String: String] = ["hash": String(hashnodash),"email": self.email]
            //create the url with URL
            guard let url = URL(string: "http://10.10.9.180:8000/user")else{return} //change the url
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
        } // END POST
        
        func sendEmail(){
            user.initilized = true
            postUserHash()
            
            sleep(2)
            
            self.emailSet = true
            UserDefaults.standard.set(1, forKey: "email")
            
        }
        
        return ZStack{
            
           Rectangle()
               .foregroundColor(Color( red: 38/255, green: 143/255, blue: 135/255))
               .edgesIgnoringSafeArea(.all)
           
           Rectangle()
               .foregroundColor(Color( red: 66/255, green: 165/255, blue: 157/255))
               .rotationEffect(Angle(degrees: 45))
               .edgesIgnoringSafeArea(.all)
           VStack{
               Image("whiteMask").resizable()
                    .frame(width: 100.0, height: 100.0)
               
            Spacer()
            
            Text("Signup")
                   .fontWeight(.bold)
                   .foregroundColor(.white)
                   .font(.largeTitle)
                .padding(.top,70)
            
            
            VStack{
                HStack(spacing: 15){
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color(red: 38/255, green: 143/255, blue: 135/255))
                    
                    TextField("Email Address", text: self.$email)
                        .foregroundColor(Color.white)
                }
                Divider().background(Color.white)
            }
            .padding(.horizontal)
            .padding(.top,20)
            
                Button(action: {sendEmail()}) {
                    Text("continue")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 55)
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .background(Color( red: 38/255, green: 143/255, blue: 135/255))
                        .cornerRadius(20)
                        .lineLimit(5)
                    
                }.padding(.top,30)
               Spacer()
               Spacer()
 
           }
       }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
