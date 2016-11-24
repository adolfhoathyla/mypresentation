//
//  Region.swift
//  AdolfhoBeserra
//
//  Created by Adolfho Athyla on 16/04/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import Foundation
import MapKit

struct Region {
    var name: String
    var coordinate: CLLocationCoordinate2D
    var latitudeDistance: CLLocationDistance
    var longitudeDistance: CLLocationDistance
    
    init(name: String, coordinate: CLLocationCoordinate2D, latitudeDistance: CLLocationDistance, longitudeDistance: CLLocationDistance) {
        self.name = name
        self.coordinate = coordinate
        self.latitudeDistance = latitudeDistance
        self.longitudeDistance = longitudeDistance
    }
}
