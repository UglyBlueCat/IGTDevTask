//
//  DataHandler.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 08/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import Foundation

class DataHandler {
    
    /*
     * Create a shared instance to initialise class as a singleton
     * originally taken from: http://krakendev.io/blog/the-right-way-to-write-a-singleton
     */
    static let sharedInstance = DataHandler()
    private init() {}
    
    func parseJackpotData (data: NSData) {
        
        DLog("data: \(data.debugDescription)")
    }
}