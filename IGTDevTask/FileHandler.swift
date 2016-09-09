//
//  FileHandler.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 08/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import Foundation

class FileHandler {
    
    let fileManager : NSFileManager = NSFileManager.defaultManager()
    let gamesFile : String = "gamesFile.txt"
    var gamesFilePath : String
    
    static let sharedInstance = FileHandler()
    
    private init() {
        let paths : [String] = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory : NSURL = NSURL(fileURLWithPath: paths[0])
        if let filePath = documentsDirectory.URLByAppendingPathComponent(gamesFile).relativePath {
            gamesFilePath = filePath
        } else {
            DLog("Cannot construct games file path")
            gamesFilePath = ""
        }
    }
    
    /*
     * writeDataToFile
     *
     * Writes an NSData object to a file
     * 
     * @param: data: NSData - the data to write to file
     */
    func writeDataToFile (data: NSData) {
        	
        guard fileManager.createFileAtPath(gamesFilePath, contents: data, attributes: nil) else {
            DLog("Cannot create file: \(gamesFilePath)")
            return
        }
        readDataFromFile()
    }
    
    /*
     * fileValid
     *
     * Checks the game file exists and is less than an hour old
     *
     * some ideas for date comparison taken from http://stackoverflow.com/questions/26198526/nsdate-comparison-using-swift
     */
    func fileValid () -> Bool {
        guard fileManager.fileExistsAtPath(gamesFilePath) else {
            return false
        }
        
        var fileAttributes : NSDictionary = NSDictionary()
        
        do {
            fileAttributes = try fileManager.attributesOfItemAtPath(gamesFilePath)
        } catch {
            DLog("Error accessing file attributes: \(error)")
            return false
        }
        
        if let fileCreationDate = fileAttributes[NSFileCreationDate] as? NSDate {
            let oneHour : NSTimeInterval = 60*60
            let fileExpiryDate = fileCreationDate.dateByAddingTimeInterval(oneHour)
            if fileExpiryDate.compare(NSDate()) == NSComparisonResult.OrderedAscending { // Expiry date before now
                return false
            }
        } else {
            DLog("Cannot determine file creation date")
            return false
        }
        
        return true
    }
    
    /*
     * readDataFromFile
     *
     * Reads data from file if it is valid
     * otherwise kicks off new download
     */
    func readDataFromFile () {
        if fileValid(),
           let data : NSData = fileManager.contentsAtPath(gamesFilePath) {
               DataHandler.sharedInstance.handleJackpotData(data)
        } else {
            NetworkManager.sharedInstance.fetchJackpotList()
        }
    }
}