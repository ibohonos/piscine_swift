//
//  SecondViewController.swift
//  d05
//
//  Created by Ivan BOHONOSIUK on 10/8/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapKit: MKMapView!
    
    @IBOutlet weak var segControll: UISegmentedControl!
    
    @IBAction func segAction(_ sender: Any) {
        switch (segControll.selectedSegmentIndex) {
        case 0:
            mapKit.mapType = .standard
        case 1:
            mapKit.mapType = .satellite
        default:
            mapKit.mapType = .hybrid
        }
    }
    
    @IBAction func btnLocaion(_ sender: Any) {
        
//        let coordinates = CLLocationCoordinate2D(latitude: (locMan.location?.coordinate.latitude)!, longitude: (locMan.location?.coordinate.longitude)!)
//        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        mapKit.setRegion(region, animated: true)
//        mapKit.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        
        
        let regionRadius: CLLocationDistance = 500
        let coordRegion = MKCoordinateRegionMakeWithDistance(gps.coordinate, regionRadius, regionRadius)
        mapKit.setRegion(coordRegion, animated: true)
        mapKit.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        
        
        
    }
    
    var locMan = CLLocationManager()
    var gps = MKPointAnnotation()
    var sendFromList: Int?
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        mapKit.delegate = self
//        init42()
//        locMan.requestWhenInUseAuthorization()
//        locMan.delegate = self
//        locMan.desiredAccuracy = kCLLocationAccuracyBest
//        locMan.distanceFilter = 100
//        locMan.startUpdatingLocation()
        
        
        super.viewDidLoad()
        mapKit.delegate = self
        locMan.delegate = self
        // определяем precision для геолокации
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        // запрашиваем геолокацию
        locMan.requestWhenInUseAuthorization()
        // we will ask it to start updating the position
        locMan.startUpdatingLocation()
        init42()
        
        // Create annotation
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if sendFromList != nil {
            let regionRadius: CLLocationDistance = 500
            let coordRegion = MKCoordinateRegionMakeWithDistance(spots[sendFromList!].coordinate, regionRadius, regionRadius)
            mapKit.setRegion(coordRegion, animated: true)
            sendFromList = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func init42 () {
        mapKit.addAnnotations(spots)
        let regionRadius: CLLocationDistance = 200
        let coordRegion = MKCoordinateRegionMakeWithDistance(spots[0].coordinate, regionRadius, regionRadius)
        mapKit.setRegion(coordRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Spot else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            view.markerTintColor = annotation.markerTintColor
            view.glyphText = String(annotation.discipline.first!)
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.markerTintColor = annotation.markerTintColor
            view.glyphText = String(annotation.discipline.first!)
        }
        
        
        return view
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Create annotation
        let annotation = MKPointAnnotation()
        annotation.title = "My position"
        annotation.subtitle = "test Desc"
        annotation.coordinate = locations.last!.coordinate
        self.mapKit.addAnnotation(annotation)
        self.mapKit.showsUserLocation = true
        
        
//        gps.coordinate = locations.first!.coordinate
//        mapKit.showsUserLocation = true
//        locations.f
    }

}

