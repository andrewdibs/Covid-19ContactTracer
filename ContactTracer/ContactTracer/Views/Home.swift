//
//  Home.swift
//  ContactTracer
//
//  Created by dibs on 10/14/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI
import MapKit

struct Home: View {
    
    @State var exposed = UserDefaults.standard.bool(forKey: "exposed")
    @State var positive = UserDefaults.standard.bool(forKey: "positive")
    @State var reporting = false
    @ObservedObject var user: User
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        // Recieve user coordinates from location manager
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate: CLLocationCoordinate2D()
        
        // timer set for 14 days that runs after being exposed or reporting positive
        let timer = Timer.publish(every: 1209600, on: .main, in: .common).autoconnect()
        let timer2 = Timer.publish(every: 1209600, on: .main, in: .common).autoconnect()
 
        // PUT
        func putCoordinates(){
             let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
            print("PUT")
            let parameters: [String: String] = ["hash": String(hashnodash), "x": String(coordinate.latitude), "y": String(coordinate.longitude)]
            //create the url with URL
            guard let url = URL(string: "http://10.10.9.180:8000/user")else{return} //change the url
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
            print("GET")
            
            //create the url with URL
            guard let url = URL(string: "http://10.10.9.180:8000/user/\(hashnodash)")else{return} //change the url
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
                    // show alert
                    self.exposed = true
                    UserDefaults.standard.set(true, forKey: "exposed")

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
                let parameters: [String: String] = ["hash": String(hashnodash)]
                //create the url with URL
                guard let url = URL(string: "http://10.10.9.180:8000/user")else{return} //change the url
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
            positive = true
            UserDefaults.standard.set(true, forKey: "positive")
            patchHash()
            // Update screen to show that they have reported a covid instance
        }
        
        // perform http requests
        if (coordinate.longitude != 0 && coordinate.latitude != 0){
                getUserHash()
                putCoordinates()
        }
        
        
        return ZStack{
                // Background
                Rectangle()
                    .foregroundColor(Color( red: 38/255, green: 143/255, blue: 135/255))
                    .edgesIgnoringSafeArea(.all)
                
//                Rectangle()
//                    .foregroundColor(Color( red: 102/255, green: 153/255, blue: 255/255))
//                    .rotationEffect(Angle(degrees: 45))
//                    .edgesIgnoringSafeArea(.all)
                VStack{
      
                    Image("whiteMask").resizable()
                        .frame(width: 76.0, height: 76.0)
                        .alert(isPresented: $exposed) {
                            Alert(
                                title: Text("WARNING: You have been in contact with someone who tested positive for the COVID-19 virus. Please take the proper precautions."),
                                dismissButton: Alert.Button.cancel(Text("Quarentine")){
                                    // take any other action here
                                    }
                            )
                        }
                    ZStack{
                        Rectangle()
                        .foregroundColor(Color( red: 66/255, green: 165/255, blue: 157/255))
                            .frame(width: 380, height: 200)
                        .cornerRadius(20)
                        
                        VStack{
                            Spacer()
                            
                            Text("Status")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                            Spacer()
                            // reported positive
                            VStack{
                                if (positive){
                                    Text("COVID-19 POSITIVE")
                                        .foregroundColor(Color(.white))
                                        .fontWeight(.heavy)
                                        .font(.system(size: 25))
                                        .onReceive(timer){ _ in
                                            print("covid reported expired")
                                            self.positive = false
                                            UserDefaults.standard.set(false, forKey: "positive")
                                        }
                                        
                                }else{
                                    Text("COVID-19 NEGATIVE")
                                        .foregroundColor(Color(.white))
                                        .font(.system(size: 25))
                                        
                                }
                                if(self.positive){
                                    Button(action: {
                                        self.positive = false
                                        UserDefaults.standard.set(false, forKey: "positive")
                                    }) {
                                        Text("report negative")
                                            .padding(.all, 10)
                                            .foregroundColor(.white)
                                            .background(Color(red: 38/255, green: 143/255, blue: 135/255))
                                            .cornerRadius(50)
                                            .lineLimit(5)
                                    }.disabled(!positive)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                }
                                
                                
                                
                            }
                            
                            Spacer()
                            // exposed
                            if (exposed){
                                Text("WARNING: Please Quarentine, you have been in contact with COVID-19")
                                    .foregroundColor(Color(.white))
                                    .fontWeight(.heavy)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                                    .onReceive(timer2){ _ in
                                        print("covid exposed expired")
                                        self.exposed = true
                                        UserDefaults.standard.set(true, forKey: "exposed")
                                    }
                            }else{
                                Text("You have not been in any confirmed contact with the COVID-19 Virus")
                                    .foregroundColor(Color(.white))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                                    .font(.system(size: 20))
                                    
                                    
                            }
                            Spacer()
                        }.frame(width:380,height:200)
                        .padding(.horizontal, 10)
                        
                    }
                    // COVID-19 report button
                    Button(action: {self.reporting = true}) {
                        Text("REPORT COVID-19 POSITVE")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.all, 30)
                            .foregroundColor(.white)
                            .background(Color( red: 66/255, green: 165/255, blue: 157/255))
                            .cornerRadius(50)
                            .lineLimit(5)
                        
                    }.disabled(positive)
                    
                    .padding(.top)
                    
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
          
                    ZStack{
                        
                        MapView()
                            
                            .edgesIgnoringSafeArea(.bottom)
                        Text("\(coordinate.latitude), \(coordinate.longitude)").foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color(  red: 66/255, green: 165/255, blue: 157/255))
                            .cornerRadius(40).padding(.top,250)
                    }
                    
                }
        // Background Process
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)){
            _ in
            print("moving to the background")
            
        }
        // Foreground
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)){
            _ in
            print("moving to the forerground")
        }
           // original alert
        }
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(user: User())
    }
}
