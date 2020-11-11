//
//  Signup.swift
//  ContactTracer
//
//  Created by dibs on 11/8/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI

struct Signup: View {

    @ObservedObject var user: User
    @State var email = ""
    var body: some View {
        print(user.initilized)
        // POST
        func postUserHash(){
            //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
            print("fire post" )
            let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            print(hashnodash)
            let parameters: [String: String] = ["hash": String("ahhhhhhhhhhhh"),"email": self.email]
            //create the url with URL
            guard let url = URL(string: "http://192.168.1.64:8000/user")else{return} //change the url
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
            
            
        }
        
        return ZStack{
            
           Rectangle()
               .foregroundColor(Color( red: 0/255, green: 128/255, blue: 255/255))
               .edgesIgnoringSafeArea(.all)
           
           Rectangle()
               .foregroundColor(Color( red: 102/255, green: 153/255, blue: 255/255))
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
                        .foregroundColor(Color(red: 0/255, green: 128/255, blue: 255/255))
                    
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
                        .background(Color( red: 0/255, green: 128/255, blue: 255/255))
                        .cornerRadius(20)
                        .lineLimit(5)
                    
                }.padding(.top,30)
               Spacer()
               Spacer()
 
           }
       }

    }

}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup(user: User())
    }
}
