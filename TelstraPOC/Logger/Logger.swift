//
//  Logger.swift
//  TelstraPOC
//
//  Created by Guchhait, Saikat on 18/07/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import QuartzCore

/**
 Logger class is used print string instead of print method with details
 */
class Logger {
    static let startTime = CACurrentMediaTime()
    
    /// Method used to print the message in console as Debug
    ///
    /// - Parameters:
    ///   - message: display String on the console
    ///   - function: display function name in file
    ///   - file:  display the file name
    ///   - line: display the line number in file
    class func debug (message: String, function: String = #function, file: String = #file, line: Int = #line) {
        #if DEBUG
            printLog (loglevel: "DEBU", message: message, function: function, file: file, line: line)
        #endif
    }
    
    /// Method used to print the message in console as Information
    ///
    /// - Parameters:
    ///   - message:  display String on the console
    ///   - function: display function name in file
    ///   - file: display the file name
    ///   - line: display the line number in file
    class func info (message: String, function: String = #function, file: String = #file, line: Int = #line) {
        #if DEBUG
            printLog (loglevel: "INFO", message: message, function: function, file: file, line: line)
        #endif
    }
    
    ///  Method used to print the message in console as Warning
    ///
    /// - Parameters:
    ///   - message: display String on the console
    ///   - function: display function name in file
    ///   - file: display the file name
    ///   - line: display the line number in file
    class func warning (message: String, function: String = #function, file: String = #file, line: Int = #line) {
        #if DEBUG
            printLog (loglevel: "WARN", message: message, function: function, file: file, line: line)
        #endif
    }
    
    /// Method used to print the message in console as Error
    ///
    /// - Parameters:
    ///   - message: display String on the console
    ///   - function: display function name in file
    ///   - file: display the file name
    ///   - line: display the line number in file
    class func error (message: String, function: String = #function, file: String = #file, line: Int = #line) {
        #if DEBUG
            printLog (loglevel: "ERRO", message: message, function: function, file: file, line: line)
        #endif
    }
    
    /// Private method used to print the message in console
    ///
    /// - Parameters:
    ///   - loglevel: display type of log
    ///   - message:  display String on the console as output String
    ///   - function: display function name in file
    ///   - file: display the file name
    ///   - line: display the line number in file
    class private func printLog (loglevel: String, message: String, function: String, file: String, line: Int) {
        let filename = (file as NSString).lastPathComponent
        let runtime = String(format: "%04.f", max(floor(CACurrentMediaTime() - startTime), 0))
        print ("\(loglevel)[\(runtime)] (\(filename):\(line) \(function)) \(message)")
    }
    
}

