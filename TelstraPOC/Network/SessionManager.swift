//
//  SessionManager.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCountry(request: URLRequest,
                      completionHandler: ((_ response: NetworkResponse) -> Void)?)
}

struct SessionManager {
    let urlSession: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        urlSession = URLSession(configuration: configuration)
    }
}

extension SessionManager: NetworkManagerProtocol {
    
    func fetchCountry(request: URLRequest,
                      completionHandler: ((NetworkResponse) -> Void)?) {
        urlSession.dataTask(with: request) { (data, response, error) in
            let response = NetworkResponse(data: data, response: response, error: error)
            DispatchQueue.main.async {
                completionHandler?(response)
            }
        }.resume()
    }
}
