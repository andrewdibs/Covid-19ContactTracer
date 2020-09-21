//
//  ContentView.swift
//  ContactTracer
//
//  Created by dibs on 9/9/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private var locationManager = LocationManager()
    var body: some View {
        
        MapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
