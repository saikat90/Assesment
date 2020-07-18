//
//  InfoImageDownloader.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 19/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

class InfoImageDownloader: Operation {
    
    let cellViewModel: CountryInfoCellViewModel
    
    init(_ cellViewModel: CountryInfoCellViewModel) {
        self.cellViewModel = cellViewModel
    }
    
    override func main() {
        
        if isCancelled {
            return
        }
        
        guard let imageUrlString = cellViewModel.imageURL,
            let imageUrl =  URL(string: imageUrlString),
            let imageData = try? Data(contentsOf: imageUrl) else {
                cellViewModel.downloadingState = .failed
                return
        }
        
        if !imageData.isEmpty {
            cellViewModel.imageData = imageData
            cellViewModel.downloadingState = .downloaded
        } else {
            cellViewModel.downloadingState = .failed
        }
    }
}
