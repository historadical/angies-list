//
//  ServiceProvider.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import Foundation
import CoreLocation

struct ServiceProvider: Decodable {

    let city: String
    let coordinates: CLLocationCoordinate2D
    let name: String
    let overallGrade: String
    let postalCode: String
    let state: String
    let reviewCount: Int

    enum CodingKeys: String, CodingKey {
        case city, coordinates, latitude, longitude, name, overallGrade, postalCode, state, reviewCount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        let coordinatesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coordinates)
        let latitudeString = try coordinatesContainer.decode(String.self, forKey: .latitude)
        let longitudeString = try coordinatesContainer.decode(String.self, forKey: .longitude)
        self.coordinates = CLLocationCoordinate2D(latitude: Double(latitudeString) ?? 0, longitude: Double(longitudeString) ?? 0)
        self.name = try container.decode(String.self, forKey: .name)
        self.overallGrade = try container.decode(String.self, forKey: .overallGrade)
        self.postalCode = try container.decode(String.self, forKey: .postalCode)
        self.state = try container.decode(String.self, forKey: .state)
        self.reviewCount = try container.decode(Int.self, forKey: .reviewCount)
    }
}

struct ServiceProvidersPage: Decodable {

    let serviceProviders: [ServiceProvider]

    enum CodingKeys: String, CodingKey {
        case serviceproviders
    }

    // Need to include init here since the key in the JSON is different than the property name
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.serviceProviders = try container.decode([ServiceProvider].self, forKey: .serviceproviders)
    }
}
