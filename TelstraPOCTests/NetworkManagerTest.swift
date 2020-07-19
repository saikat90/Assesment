//
//  NetworkManagerTest.swift
//  TelstraPOCTests
//
//  Created by Guchhait, Saikat on 19/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import XCTest
@testable import TelstraPOC

private let JSONExtension = "json"

class MockNetworkManager: NetworkManagerProtocol {
    
    func fetchCountry(request: URLRequest, completionHandler: ((NetworkResponse) -> Void)?) {
        var response: NetworkResponse!
        let requestString = request.url?.absoluteString ?? ""
        switch requestString {
        case _ where requestString.contains("facts.json"):
            let url =  Bundle(for: type(of: self)).url(forResource: "AboutCountryJSON", withExtension: JSONExtension)
            if let jsonURL = url  {
                let data = try? Data(contentsOf: jsonURL)
                response = NetworkResponse(data: data, response: nil, error: nil)
            } else {
                response =  NetworkResponse(data: nil,
                                            response: nil,
                                            error: NetworkError.network(description: "No Data Found"))
            }
        default:
            response = NetworkResponse(data: nil,
                                       response: nil,
                                       error: NetworkError.network(description: "No Data Found"))
        }
        completionHandler?(response)
    }
    
}

class NetworkManagerTest: XCTestCase {
    
    var networkManger: NetworkManager!
    
    override func setUp() {
        let mockNetworkManger = MockNetworkManager()
        networkManger = NetworkManager(session: mockNetworkManger)
    }
    
    override func tearDown() {
    }
    
    func test_fetchCountryDataUsingRequestComponent() {
        let urlComponent = NetworkRequestPath.aboutCountry.component()
        networkManger.fetchCountryDataUsing(urlComponent) { response in
            XCTAssertNotNil(response.data)
        }
    }
    
}
