//
//  ViewController.swift
//  MapViewNotesNoftz
//
//  Created by EVANGELINE NOFTZ on 1/24/25.
//

import UIKit
// import the map kit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var currentLocation: CLLocation!
    
    var parks: [MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // certain methods in delegate auto called
        locationManager.delegate = self
        
        // updates your location as it changes
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
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
    
    
    // automatically called when your location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // most recent location is at index 0
        currentLocation = locations[0]
    }

    
    @IBAction func searchAction(_ sender: UIButton) {
        // blank request object
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = "Parks"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        
        // says that when everything else is done, do this:
        // response and error are parameters of this function we are building
        search.start { (response, error) in
            
            // similar to if let (response cannot be nil -- does else if nil)
            guard let response = response
            else {return}
            for mapItem in response.mapItems {
                
                // must use self when in closure trying to access a global variable
                self.parks.append(mapItem)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapViewOutlet.addAnnotation(annotation)
                
            }
        }
    }
    

}

