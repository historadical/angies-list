//
//  angies_listTests.swift
//  angies-listTests
//
//  Created by Nicholas Laughter on 3/7/20.
//  Copyright © 2020 niclaughter.com. All rights reserved.
//

import XCTest
@testable import angies_list

class angies_listTests: XCTestCase {

    func test_serviceProvider_init_success() {
        let url = URL(string: "http://private-895ba-angieslistcodingchallenge.apiary-mock.com/angieslist/codingChallenge/serviceproviders")!
        let expect = expectation(description: "GET \(url)")

        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")

            if let httpResponse = response as? HTTPURLResponse,
                let responseURL = httpResponse.url,
                let mimeType = httpResponse.mimeType {
                XCTAssertEqual(responseURL.absoluteString, url.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(httpResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(mimeType, "application/json", "HTTP response content type should be application/json")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            let serviceProvidersJSON = try? JSONSerialization.jsonObject(with: data!) as? [String: Any]
            let serviceProvidersArray = serviceProvidersJSON!["serviceproviders"] as? [[String: Any]]
            let serviceProviders: [ServiceProvider] = serviceProvidersArray!.compactMap { ServiceProvider(json: $0) }
            XCTAssertTrue(serviceProviders.count > 0)
            expect.fulfill()
        }

        task.resume()

        waitForExpectations(timeout: task.originalRequest?.timeoutInterval ?? 30) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
