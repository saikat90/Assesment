//
//  AboutCountryViewModel.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

class AboutCountryViewModel {
    
    private var networkManager: NetworkManager?
    
    var navigationTitle: String?
    private var cellModels = [CountryInfoCellViewModel]()
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchCountryInformation(onCompletion: @escaping () ->()) {
        let requestComponent = NetworkRequestPath.aboutCountry.component()
        networkManager?.fetchCountryDataUsing(requestComponent) {[weak self] response in
            guard let strongSelf = self else { return }
            guard let aboutCountry: AboutCountry = response.parseData() else {
                Logger.error(message: response.parseError())
                strongSelf.cellModels = [CountryInfoCellViewModel(errorTitle: response.parseError())]
                onCompletion()
                return
            }
            strongSelf.navigationTitle = aboutCountry.title
            strongSelf.cellModels = aboutCountry.countryInformations?.compactMap(CountryInfoCellViewModel.init) ?? []
            onCompletion()
        }
    }
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func cellModelAt(index: Int) -> CountryInfoCellViewModel {
        return cellModels[index]
    }
    
}
