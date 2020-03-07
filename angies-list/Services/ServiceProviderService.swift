//
//  ServiceProviderService.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import Foundation

class ServiceProviderService {

    static let shared = ServiceProviderService()
    var serviceProviders = [ServiceProvider]()
    private let url = URL(string: "http://private-895ba-angieslistcodingchallenge.apiary-mock.com/angieslist/codingChallenge/serviceproviders")

    var hasData: Bool {
        return self.serviceProviders.count > 0
    }

    init() {
        self.loadServiceProviders()
    }

    func loadServiceProviders() {
        guard let url = self.url else { return }
        APIService().getResources(url: url) { [weak self] (result: Result<Data, APIServiceError>) in
            switch result {
            case .success(let data):
                guard let serviceProvidersJSON = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let serviceProvidersArray = serviceProvidersJSON["serviceproviders"] as? [[String: Any]] else { return }
                self?.serviceProviders = serviceProvidersArray.compactMap { ServiceProvider(json: $0) }
            case .failure(let error):
                print(error)
            }
        }
    }
}
