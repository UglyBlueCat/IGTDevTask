//
//  DataHandler.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 08/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import Foundation

class DataHandler {
    
    var games : Array <JackpotGame>
    
    /*
     * Create a shared instance to initialise class as a singleton
     * originally taken from: http://krakendev.io/blog/the-right-way-to-write-a-singleton
     */
    static let sharedInstance = DataHandler()
    private init() {
        games = Array()
    }
    
    /*
     * handleJackpotData
     * 
     * Handle data retrieved from the jackpot data URL
     *
     * @param: data: NSData - the retrieved data
     */
    func handleJackpotData (data: NSData) {
        
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves)
            parseJackpotData(jsonData)
        } catch {
            DLog("JSON conversion error: \(error)")
        }
    }
    
    /*
     * parseJackpotData
     * 
     * Parse jackpot data converted from JSON to an unknown data type 
     *
     * @param: jsonData: AnyObject - the converted data
     */
    func parseJackpotData (jsonData: AnyObject) {
        
        if let response = jsonData["response"] as? String {
            guard response == "success" else {
                DLog("Download response failure (!= \"success\")")
                return
            }
        } else {
            DLog("Cannot extract response string from data")
            return
        }
        
        if let currency = jsonData["currency"] as? String {
            userDefaults.setObject(currency, forKey: kCurrency)
        } else {
            DLog("Cannot extract currency string from data")
            return
        }
        
        if let data = jsonData["data"] as? NSArray {
            extractDataPoints(data)
        } else {
            DLog("Cannot extract game data array from data")
            return
        }
    }
    
    /*
     * extractDataPoints
     * 
     * extracts game objects from an array of game data and stores them as JackpotGame objects in an array
     *
     * @param: dataPoints: NSArray - the array of game data
     */
    func extractDataPoints (dataPoints: NSArray) {
        for point: AnyObject in dataPoints {
            if let name = point["name"] as? String,
               let jackpot = point["jackpot"] as? Int,
               let date = point["date"] as? String {
                
                   let game : JackpotGame = JackpotGame(name: name, jackpot: jackpot, date: date)
                   games.append(game)
            } else {
                DLog("Cannot extract data for point: \(point)")
            }
        }
        if dataPoints.count > 0 {
            NSNotificationCenter.defaultCenter().postNotificationName(kNewData, object: nil)
        } else {
            FileHandler.sharedInstance.readDataFromFile()
        }
    }
}