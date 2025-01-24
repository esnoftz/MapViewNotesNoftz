//
//  ViewController.swift
//  MapViewNotesNoftz
//
//  Created by EVANGELINE NOFTZ on 1/24/25.
//

import UIKit
// import the map kit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // go to info to see first step
        
        // hold down option key and click on showsUserLocation to see description of what it does
        locationManager.requestWhenInUseAuthorization()
        mapViewOutlet.showsUserLocation = true
        
        // use features thing on top of the screen to enter custom location
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let center = CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3226)
        let center2 = locationManager.location!.coordinate
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1600, longitudinalMeters: 1600)
        let region2 = MKCoordinateRegion(center: center2, span: span)
        mapViewOutlet.setRegion(region2, animated: true)
        
    }


}

