//
//  AboutCountry.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

struct AboutCountry: Decodable {
    let title: String?
    let countryInformations: [CountryInformation]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case countryInformations = "rows"
    }
}

struct CountryInformation: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
}
