//
//  InfoImageDownloadingOperation.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 19/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

class InfoImageDownloadingOperation {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Downloading Queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
