//
//  ServiceProviderTableViewCell.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import UIKit

@objc
class ServiceProviderTableViewCell: UITableViewCell {

    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var reviewsLabel: ServiceProviderRatingLabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        self.ratingLabel.text = nil
        self.reviewsLabel.text = nil
        self.nameLabel.text = nil
        self.addressLabel.text = nil
    }

    func setUpViews(for name: String, rating: String, reviews: String, at address: String) {
        self.ratingLabel.text = rating
        self.reviewsLabel.text = reviews
        self.nameLabel.text = name
        self.addressLabel.text = address
    }
}
