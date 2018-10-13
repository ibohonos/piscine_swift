//
//  LocationModel.swift
//  d05
//
//  Created by Ivan BOHONOSIUK on 10/9/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation
import MapKit

var spots : [Spot] = [
    Spot(title: "42 School", subtitle: "Original school", locationName:"Ecole 42", discipline: "School", coordinate:CLLocationCoordinate2D(latitude: 48.8966037, longitude: 2.3184669)),
    Spot(title: "42 Silicon Valey", subtitle: "School in USA", locationName: "Fremont", discipline: "Ville", coordinate:CLLocationCoordinate2D(latitude: 37.546673, longitude: -122.0632397)),
    Spot(title: "UNIT Factory", subtitle: "Home sweet home", locationName: "Kyiv", discipline: "Adress", coordinate:CLLocationCoordinate2D(latitude: 50.4688257, longitude: 30.4599701))]

class Spot: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
    
    var markerTintColor: UIColor  {
        switch self.discipline {
        case "School":
            return .red
        case "Ville":
            return .green
        case "Adress":
            return .blue
        case "2":
            return .purple
        default:
            return .cyan
        }
    }
}
