//
//  AboutCountryViewModel.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

class AboutCountryViewModel {
        
    lazy var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    func fetchCountryInformation() {
        let requestComponent = NetworkRequestPath.aboutCountry.component()
        networkManager.fetchAboutCountryUsing(requestComponent) { response in
            guard let aboutCountry: AboutCountry = response.parseData() else {
                print(response.parseError())
                return
            }
            print(aboutCountry)
        }
    }
        
}
