//
//  ContentView.swift
//  ContactTracer
//
//  Created by dibs on 9/9/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    // device ID
    let hash = UIDevice.current.identifierForVendor?.uuidString
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
        }else {
            print("biometrics not enabled")
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
