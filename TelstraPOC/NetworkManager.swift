//
//  NetworkManager.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

struct NetworkManager {
    let session: NetworkManagerProtocol
    
    init(session: NetworkManagerProtocol = SessionManager()) {
        self.session = session
    }
    
    func fetchAboutCountryUsing(_ requestComponent: URLComponents, onCompletion: ((NetworkResponse) -> Void)?) {
        guard let requestURL = requestComponent.url else {
            onCompletion?(NetworkResponse(error: .badRequest))
            return
        }
        session.fetchAboutCountry(request: URLRequest(url: requestURL),
                                  completionHandler: onCompletion)
    }
}
