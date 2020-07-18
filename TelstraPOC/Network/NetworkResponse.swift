//
//  NetworkResponse.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

struct NetworkResponse {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    func parseData<T: Decodable>() -> T? {
        guard let anyData = data,
            let jsonData = String(decoding: anyData, as: UTF8.self).data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        var parsedData: T?
        do {
            parsedData = try decoder.decode(T.self, from: jsonData)
        } catch let error {
            Logger.error(message: error.localizedDescription)
        }
        return parsedData
    }
    
    func parseError() -> String {
        guard let networkError = error as? NetworkError else {
            switch (response as? HTTPURLResponse)?.statusCode {
            case 404:
                return "No Data Found"
            default:
                return error?.localizedDescription ?? ""
            }
        }
        switch networkError {
        case .badRequest:
            return "Bad Request"
        case .network(let description):
        return "\(description)"
        }
    }
}

extension NetworkResponse {
    init(error: NetworkError, response: URLResponse? = nil) {
        self.error = error
        self.data = nil
        self.response = response
    }
}
