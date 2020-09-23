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
    
    var body: some View {
        
        // Recieve user coordinates from location manager
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate: CLLocationCoordinate2D()
        
        func iHaveCovid() -> Void{
            //TODO:
            // Send signal to backend for covid positive case
        }
        
        // return the main content view
        return ZStack{
            VStack{
                
                // TODO Maybe add a graph for daily cases
                Text("Display statistics and logo here ")
                
                Button(action: {iHaveCovid()}) {
                    Text("Press If Tested Positive For COVID-19")
                        .fontWeight(.heavy)
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .shadow(color: .black, radius: 0.1,x:2, y:2)
                        .background(Color.red)
                    .cornerRadius(40)
                    
                }
                .padding(.top, 350.0)
                .shadow(color: .black, radius: 0.1,x:1,y:1)
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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
