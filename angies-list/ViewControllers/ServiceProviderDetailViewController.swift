//
//  ServiceProviderDetailViewController.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import UIKit
import MapKit

class ServiceProviderDetailViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var reviewsLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!

    var serviceProvider: ServiceProvider? {
        didSet {
            self.loadViewIfNeeded()
            self.configureForServiceProvider()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.serviceProvider = ServiceProviderService.shared.serviceProviders.first
    }

    func configureForServiceProvider() {
        guard let serviceProvider = self.serviceProvider else { dismiss(animated: true, completion: nil); return } // Handle showing alert
        self.mapView.setRegion(MKCoordinateRegion(center: serviceProvider.coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        self.nameLabel.text = serviceProvider.name
        let addressString: String
        if let state = serviceProvider.state {
            addressString = "\(serviceProvider.city), \(state) \(serviceProvider.postalCode)"
        } else {
            addressString = "\(serviceProvider.city) \(serviceProvider.postalCode)"
        }
        self.addressLabel.text = addressString
        self.reviewsLabel.text = "Reviews: \(serviceProvider.reviewCount)"
        self.ratingLabel.text = "Grade: \(serviceProvider.overallGrade)"
    }
}
