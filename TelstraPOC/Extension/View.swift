//
//  View.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import UIKit

private let acivityIndicatorTag = 100

extension UIView {
    
    class var identifier: String {
        return "\(self)"
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = center
        addSubview(activityIndicator)
        activityIndicator.tag = acivityIndicatorTag
        activityIndicator.startAnimating()
        isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        let activityIndicator = viewWithTag(acivityIndicatorTag) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        isUserInteractionEnabled = true
    }
}
