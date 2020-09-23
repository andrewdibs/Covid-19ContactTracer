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
        
            
        
        
        func iHaveCovid() -> Void{
            print("I have covid")
            //TODO:
            // Prompt the user to double check if they meant to press the button
            
            // Send signal to backend for covid positive case
            
            // Update screen to show that they have reported a covid instance
        }
        
        // return the main content view
        return ZStack{
            // Background
            Rectangle()
                .foregroundColor(Color( red: 160/255, green: 45/255, blue: 45/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color( red: 160/255, green: 60/255, blue: 60/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                // TODO Maybe add a graph for daily cases
                Text("Display statistics and logo here ").foregroundColor(Color.white)
                
                
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
                .padding(.top, 350.0)
                
                
                Spacer()
                MapView()
                    .padding()
                Text("\(coordinate.latitude), \(coordinate.longitude)").foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
                .padding()
            
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
