//
//  University.swift
//  AdolfhoBeserra
//
//  Created by Adolfho Athyla on 16/04/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import Foundation
import MapKit

struct University {
    var name: String
    var coordinates: CLLocationCoordinate2D
    
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
    }
}
