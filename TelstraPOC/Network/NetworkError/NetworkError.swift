//
//  NetworkError.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case network(description: String)
}
