//
//  Home.swift
//  ContactTracer
//
//  Created by dibs on 10/14/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI
import MapKit
import UserNotifications

struct Home: View {
    
    @State var reporting = false
    @ObservedObject var user: User
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        // Recieve user coordinates from location manager
        var coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate: CLLocationCoordinate2D()
        
        // Notification Handler
        let center = UNUserNotificationCenter.current
        center().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // authorization enabled
        }

        
        // PUT
        func putCoordinates(){
             let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
            print("PUT")
            let parameters: [String: String] = ["hash": "abc", "x": String(coordinate.latitude), "y": String(coordinate.longitude)]
            //create the url with URL
            guard let url = URL(string: "http://192.168.1.64:8000/user")else{return} //change the url
            //create the session object
            let session = URLSession.shared
            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "PUT" //set http method as POST
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
        }// END PUT
        
        // GET
        func getUserHash(){
            //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
            let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            print("fire get")
            
            //create the url with URL
            guard let url = URL(string: "http://192.168.1.64:8000/user/abc")else{return} //change the url
            //create the session object
            let session = URLSession.shared
            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "GET" //set http method as POST
           

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                
            //create json object from data
            if let http = response as? HTTPURLResponse{
                if (http.statusCode == 200){
                    print("chillen")
                    
                }else if (http.statusCode == 202){
                    //alert
                    print("Your sick")
                    self.user.compromised = 1
                    // create notification content
                    let content = UNMutableNotificationContent()
                    content.title = "You have been exposed to COVID-19!"
                    content.body = "Please take proper COVID-19 precautions."
                    
                    // create the notification request TODO: CHECK THE NIL TRIGGER
                    let uuidString = UUID().uuidString
                    let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: nil)
                    
                    center().add(request) {(error) in
                        // check for errors
                        print("error in adding request to notification center")
                    }
                }
                
            }
                
            })
            task.resume()
        }// END GET
        
        // PATCH
        func patchHash(){
           //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
                let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                print("fire get")
                let parameters: [String: String] = ["hash": "abc"]
                //create the url with URL
                guard let url = URL(string: "http://192.168.1.64:8000/user")else{return} //change the url
                //create the session object
                let session = URLSession.shared
                //now create the URLRequest object using the url object
                var request = URLRequest(url: url)
                request.httpMethod = "PATCH" //set http method as POST
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
            }// END PATCH
        
        func iHaveCovid() -> Void{
            print("I have covid")
            //TODO: CREATE PATCH for covid 
            user.healthy = 1
            patchHash()
            // Update screen to show that they have reported a covid instance
        }
        
        getUserHash()
        putCoordinates()
        
        return ZStack{
                // Background
                Rectangle()
                    .foregroundColor(Color( red: 0/255, green: 128/255, blue: 255/255))
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .foregroundColor(Color( red: 102/255, green: 153/255, blue: 255/255))
                    .rotationEffect(Angle(degrees: 45))
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    
                    // TODO Maybe add a graph for daily cases
                    Image("whiteMask").resizable()
                        .frame(width: 76.0, height: 76.0)
                    
                    Spacer()
                    // COVID-19 report button
                    Button(action: {self.reporting = true}) {
                        Text("REPORT COVID-19 POSITVE")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.all, 30)
                            .foregroundColor(.white)
                            .background(Color( red: 224/255, green: 66/255, blue: 10/255))
                            .cornerRadius(50)
                            .lineLimit(5)
                        
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 250)
                    
                    
                    
                    Spacer()
                    ZStack{
                        MapView()
                            
                            .edgesIgnoringSafeArea(.bottom)
                        Text("\(coordinate.latitude), \(coordinate.longitude)").foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color( red: 0/255, green: 128/255, blue: 255/255))
                            .cornerRadius(40).padding(.top,250)
                    }
                    
                }
            }
            .alert(isPresented: $reporting) {
                Alert(
                    title: Text("WARNING: If you have not been tested for COVID-19 plese press Do not report. Only report that you have COVID-19 if you have been tested and the results are positive."),
                    message: Text("Would you like to report your results?"),
                    primaryButton: Alert.Button.default(Text("I am COVID-19 Positive")){
                        iHaveCovid()
                        },
                        secondaryButton: Alert.Button.cancel(Text("Do Not Report")){
                        print("Report cancled")
                        }
                )
            }
        }
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(user: User())
    }
}
