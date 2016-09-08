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

/*
 * Colours
 */
let primaryColor = UIColor(hexString: "#515151")
let primaryTextColor = UIColor(hexString: "#FFFFFF")
let accentColor = UIColor(hexString: "#40371A")
let primaryAttentionColor = UIColor(hexString: "#8CF205")
let secondaryAttentionColor = UIColor(hexString: "#96BF3C")
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

/*
 * Create image from colour
 * Taken from http://stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
 */
public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image.CGImage else { return nil }
        self.init(CGImage: cgImage)
    }
}
