//
//  MapCoordinator.swift
//  ContactTracer
//
//  Created by dibs on 9/21/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import Foundation
import MapKit

final class Coordinator: NSObject, MKMapViewDelegate{
    
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
}


