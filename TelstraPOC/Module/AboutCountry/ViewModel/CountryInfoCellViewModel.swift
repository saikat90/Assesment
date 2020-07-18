//
//  CountryInfoCellViewModel.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

enum ImageDownloadingState {
    case new
    case downloaded
    case failed
}

class CountryInfoCellViewModel {
    let title: String?
    let imageURL: String?
    let description: String?
    var downloadingState: ImageDownloadingState = .new
    var imageData: Data?
    
    init?(model: CountryInformation?) {
        guard let infoTitle = model?.title else {
            return nil
        }
        self.description = model?.description
        self.title = infoTitle
        self.imageURL = model?.imageHref
    }
}
