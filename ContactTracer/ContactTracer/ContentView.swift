//
//  ContentView.swift
//  ContactTracer
//
//  Created by dibs on 9/9/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
   
    @State var logged = false
    var body: some View {
        
        NavigationView{
            if (logged){
                // return the main content view
                Home()
            }
            else {
                Login()
            }
            
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
