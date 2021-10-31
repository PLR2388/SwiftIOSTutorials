//
//  Capital.swift
//  Project16
//
//  Created by Paul-Louis Renard on 31/10/2021.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var url: URL
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, url: URL) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.url = url
    }
}
