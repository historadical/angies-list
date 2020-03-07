//
//  ServiceProviderRatingLabel.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import UIKit

class ServiceProviderRatingLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.text = nil
    }

    override var text: String? {
        didSet {
            self.configureForRating()
        }
    }

    private func configureForRating() {
        guard let text = self.text, text != "N/A" else {
            self.alpha = 0
            return
        }
        self.alpha = 1
        switch text {
            case "A":
                self.backgroundColor = .green
            case "B":
                self.backgroundColor = .green
            case "C":
                self.backgroundColor = .yellow
            case "D":
                self.backgroundColor = .orange
            case "F":
                self.backgroundColor = .red
            default: break
        }
    }
}
