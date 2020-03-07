//
//  ServiceProviderService.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import Foundation

class ServiceProviderService {

    private let url = URL(string: "http://private-895ba-angieslistcodingchallenge.apiary-mock.com/angieslist/codingChallenge/serviceproviders")

    func loadServiceProviders(completion: @escaping ([ServiceProvider]) -> Void) {
        guard let url = self.url else {
            completion([])
            return
        }
        APIService().getResources(url: url) { (result: Result<Data, APIServiceError>) in
            switch result {
            case .success(let data):
                guard let serviceProvidersJSON = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let serviceProvidersArray = serviceProvidersJSON["serviceproviders"] as? [[String: Any]] else {
                        completion([])
                        return
                }
                let serviceProviders: [ServiceProvider] = serviceProvidersArray.compactMap { ServiceProvider(json: $0) }
                completion(serviceProviders)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
