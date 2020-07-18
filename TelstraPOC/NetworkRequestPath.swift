//
//  NetworkRequestPath.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

enum NetworkRequestPath {
    case aboutCountry
    
    private struct CountryAPI {
        let scheme = "https"
        let host = "dl.dropboxusercontent.com"
        let basePath = "/s/2iodh4vg0eortkl/"
        
        func countryURLComponent(path: NetworkRequestPath) -> URLComponents {
            var components = URLComponents()
            components.host = host
            components.scheme = scheme
            components.path = basePath + path.pathValue()
            return components
        }
    }
    
    private func pathValue() -> String {
        var path: String
        switch self {
        case .aboutCountry:
            path = "facts.json"
        }
        return path
    }
    
    func component() -> URLComponents {
        return CountryAPI().countryURLComponent(path: self)
    }
}


