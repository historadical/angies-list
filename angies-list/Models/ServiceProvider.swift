//
//  ServiceProvider.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import Foundation
import CoreLocation

struct ServiceProvider {

    let city: String
    let coordinates: CLLocationCoordinate2D
    let name: String
    let overallGrade: String
    let postalCode: String
    let state: String?
    let reviewCount: Int

    init?(json: [String: Any]) {
        guard let city = json["city"] as? String,
            let coordinates = json["coordinates"] as? [String: String],
            let latitudeString = coordinates["latitude"],
            let longitudeString = coordinates["longitude"],
            let latitude = Double(latitudeString),
            let longitude = Double(longitudeString),
            let name = json["name"] as? String,
            let overallGrade = json["overallGrade"] as? String,
            let postalCode = json["postalCode"] as? String,
            let reviewCount = json["reviewCount"] as? Int else { return nil }
        self.city = city
        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.name = name
        self.overallGrade = overallGrade
        self.postalCode = postalCode
        self.state = json["state"] as? String
        self.reviewCount = reviewCount
    }
}
