//
//  LocationManager.swift
//  desktop
//
//  Created by Rauhul Varma on 2/12/17.
//  Copyright © 2017 rvarma. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private override init() {
        super.init()
        clLocationManager.delegate = self
        clLocationManager.startUpdatingLocation()
    }
    
    private var monitoringSignificantLocationChanges = false
    
    private var location: CLLocation?
    let clLocationManager = CLLocationManager()
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        if !monitoringSignificantLocationChanges {
            clLocationManager.stopUpdatingLocation()
            clLocationManager.startMonitoringSignificantLocationChanges()
            monitoringSignificantLocationChanges = true
        }
    }
    
    var locationAsCSV: String? {
        guard let location = location else { return nil }
        return "\(location.coordinate.latitude),\(location.coordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            manager.startUpdatingLocation()

        case .notDetermined:
            manager.startUpdatingLocation()
            manager.stopUpdatingLocation()

        default:
            break
        }

    }
}
