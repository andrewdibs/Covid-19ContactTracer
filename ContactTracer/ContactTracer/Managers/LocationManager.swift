//
//  LocationManager.swift
//  ContactTracer
//
//  Created by dibs on 9/21/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import MapKit
import Foundation

class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    var location: CLLocation? = nil
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    
}
