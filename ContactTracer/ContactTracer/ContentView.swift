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
    var compromised = 0 { didSet{ didChange.send() } }
    var healthy = 0 { didSet{ didChange.send() } }
    var initilized = false { didSet{ didChange.send() } }
   
    
}


struct ContentView: View {
    
    
   
    // Authentication state variable
    @State var logged = false
    
    var body: some View {
        
        ZStack{
            if (self.logged){
                // return the main content view
                Home()
            }
            else {
                Login()
            }
            
        }.onAppear(perform: authenticate)
        
    }
    
    // Allows authentication with biometric faceID or touchID
    func authenticate() {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
