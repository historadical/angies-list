//
//  APIService.swift
//  angies-list
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
    case apiError
    case invalidURL
    case invalidResponse
    case noData
    case decodeError
}

class APIService {

    func getResources(url: URL,
                      urlParameters: [String: String]? = nil,
                      completion: @escaping (Result<Data, APIServiceError>) -> Void) {
        let requestURL = getURL(byAdding: urlParameters, to: url)
        URLSession.shared.dataTask(with: requestURL) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard !data.isEmpty else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(data))
            case .failure:
                completion(.failure(.apiError))
            }
        }.resume()
    }

    /**
     Builds the final URL to use in the network call by adding the parameters in the appropriate format to the end of
     the base URL
     * NOTICE: If a full URL with parameters is passed in to
     performRequest(forURL:withMethod:urlHeaders:urlParameters:body:completion:), everything following and including
     the ? will be removed. Be sure to include parameters in the urlParameters parameter above.
     - Parameter parameters: the parameters to add to the base URL
     - Returns: returns the base URL if it was not successful, or the new URL if it was.
     */
    private func getURL(byAdding parameters: [String: String]?, to url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        guard let url = components?.url else { fatalError("URL is nil") }
        return url
    }
}

