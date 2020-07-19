//
//  AboutCountryViewModelTest.swift
//  TelstraPOCTests
//
//  Created by Guchhait, Saikat on 19/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import XCTest
@testable import TelstraPOC

class AboutCountryViewModelTest: XCTestCase {

    var viewModel: AboutCountryViewModel!
    
    override func setUp() {
        let networkManager = NetworkManager(session: MockNetworkManager())
        viewModel = AboutCountryViewModel(networkManager: networkManager)
        viewModel.fetchCountryInformation {}
    }

    override func tearDown() {
    }

    func test_numberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 13)
    }
    
    func test_cellModelAtIndex() {
        let model = viewModel.cellModelAt(index: 0)
        XCTAssertEqual(model.title, "Beavers")
        XCTAssertEqual(model.imageURL, "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
    }
}
