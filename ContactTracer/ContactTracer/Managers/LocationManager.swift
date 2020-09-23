//
//  LocationManager.swift
//  ContactTracer
//
//  Created by dibs on 9/21/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import MapKit
import Foundation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

// TODO: Create alert for authorization if not always on
func checkAuthorizationStatus() {
    switch CLLocationManager.authorizationStatus(){
    case .authorizedWhenInUse:
        // alert user to turn on always on authorization
        break
    case .authorizedAlways:
        // authorization status is OK
        break
    case .restricted:
        // alert user to turn on always on authorization
        break
    case .notDetermined:
        // alert user to turn on always on authorization
        break
    case .denied:
        // alert user to turn on always on authorization
        break
    @unknown default:
        break
    }
}

// Location Manager Delegate for location update
extension LocationManager: CLLocationManagerDelegate{
    // updates location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{
            return
        }
        self.location = location
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus()
    }
}
