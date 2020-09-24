//
//  ContentView.swift
//  ContactTracer
//
//  Created by dibs on 9/9/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    @State var reporting = false
    var body: some View {
        
       
        
        // Recieve user coordinates from location manager
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate: CLLocationCoordinate2D()
        
        func postCoordinates(){
            //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
            let parameters: [String: String] = ["latitude": String(coordinate.latitude), "longitude": String(coordinate.longitude)]

            //create the url with URL
            guard let url = URL(string: "http://myServerName.com/api")else{return} //change the url

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
        
        
        func iHaveCovid() -> Void{
            print("I have covid")
            //TODO:
            
            // Send signal to backend for covid positive case
            //let url = URL(string: "APIURL")
            
            
            // Update screen to show that they have reported a covid instance
        }
        
        // return the main content view
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
                
                
                // COVID-19 report button
                Button(action: {self.reporting = true}) {
                    Text("REPORT COVID-19 POSITVE")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.all, 20)
                        .foregroundColor(.white)
                        .background(Color( red: 224/255, green: 66/255, blue: 10/255))
                        .cornerRadius(40)
                        .lineLimit(5)
                    
                }
                .padding(.top, 250.0)
                
                
                Spacer()
                MapView()
                    .padding()
                Text("\(coordinate.latitude), \(coordinate.longitude)").foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(red: 224/255, green: 66/255, blue: 10/255))
                    .cornerRadius(40)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
