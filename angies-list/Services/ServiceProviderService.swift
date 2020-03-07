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

    private func loadServiceProviders(completion: @escaping ([ServiceProvider]) -> Void) {
        guard let url = self.url else {
            completion([])
            return
        }
        APIService().getResources(url: url) { (result: Result<Data, APIServiceError>) in
            switch result {
            case .success(let data):
                do {
                    let serviceProvidersPage = try JSONDecoder().decode(ServiceProvidersPage.self, from: data)
                    completion(serviceProvidersPage.serviceProviders)
                } catch {
                    print(error)
                    completion([])
                }
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
