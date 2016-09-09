//
//  Globals.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 08/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import Foundation
import UIKit

let jackpotURLString: String = "https://dl.dropboxusercontent.com/u/49130683/nativeapp-test.json"
let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
let kCurrency: String = "kCurrency"
let kNewData: String = "kNewData"
let kFileSaved: String = "kFileSaved"
let topMargin: CGFloat = 20.0
let standardControlHeight: CGFloat = 30.0
let standardControlWidth: CGFloat = 100.0

/*
 * Colours
 */
let primaryColor = UIColor(hexString: "#A600A6")
let secondaryColor = UIColor(hexString: "#530FAD")
let primaryTextColor = UIColor(hexString: "#FFFFFF")
let secondaryTextColor = UIColor(hexString: "#000000")
let primaryAttentionColor = UIColor(hexString: "#E40045")
let secondaryAttentionColor = UIColor(hexString: "#EB5BA7")
let pinkColor = UIColor(hexString: "#FF00FF")

/*
 * DLog
 *
 * Prints a message to the console prefixed with filename, function & line number
 * A replacement for __PRETTY_FUNCTION__
 * A combination of several posts on stack overflow
 *
 * @param: msg:      String  - The message to print
 * @param: function: String  - Defaults to #function
 * @param: file:     String  - Defaults to #file
 * @param: line:     Int     - Defaults to #line
 */
func DLog(msg: String, function: String = #function, file: String = #file, line: Int = #line) {
    let url = NSURL(fileURLWithPath: file)
    let className:String! = url.lastPathComponent == nil ? file : url.lastPathComponent!
    print("[\(className) \(function)](\(line)) \(msg)")
}

/*
 * Create colour from hex string.
 * Taken from http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios
 */
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
