//
//  GameViewController.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 08/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var game : JackpotGame!
    var nameLabel: IGTLabel!
    var dateLabel: IGTLabel!
    var jackpotLabel: IGTLabel!
    var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        positionObjectsWithinSize(size)
    }
    
    /*
     * setupView()
     *
     * Set up the view
     */
    func setupView () {
        view.backgroundColor = primaryColor
        addObjects()
        positionObjectsWithinSize(view.bounds.size)
    }
    
    /*
     * addObjects()
     *
     * Add objects to the view
     */
    func addObjects () {

        nameLabel = IGTLabel(textStr: game.name)
        view.addSubview(nameLabel)
        
        dateLabel = IGTLabel(textStr: formatDate(game.date))
        view.addSubview(dateLabel)
        
        jackpotLabel = IGTLabel(textStr: formatJackpot(game.jackpot))
        view.addSubview(jackpotLabel)
        
        doneButton = UIButton()
        configureDoneButton()
        view.addSubview(doneButton)
    }
    
    /*
     * configureDoneButton
     *
     * Configures the done buton
     */
    func configureDoneButton () {
        
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), forControlEvents: .TouchUpInside)
        doneButton.setTitleColor(primaryTextColor, forState: .Normal)
        doneButton.layer.cornerRadius = 5
        doneButton.layer.borderWidth = 2
        doneButton.layer.borderColor = primaryTextColor.CGColor
    }
    
    /*
     * positionObjectsWithinSize
     *
     * Sets the size of objects separately so this function can be called from different places
     */
    func positionObjectsWithinSize (size: CGSize) {
        
        let viewHeight : CGFloat = size.height
        let viewWidth : CGFloat = size.width
        let margin: CGFloat = (viewWidth + viewHeight)/100
        
        nameLabel.frame = CGRect(x: margin, 
                                  y: topMargin, 
                                  width: viewWidth - 2*margin, 
                                  height: standardControlHeight)
        
        dateLabel.frame = CGRect(x: margin, 
                                  y: CGRectGetMaxY(nameLabel.frame) + margin, 
                                  width: viewWidth - 2*margin, 
                                  height: standardControlHeight)
        
        jackpotLabel.frame = CGRect(x: margin, 
                                    y: CGRectGetMaxY(dateLabel.frame) + margin, 
                                  width: viewWidth - 2*margin, 
                                  height: standardControlHeight)
        
        doneButton.frame = CGRect(x: (viewWidth - standardControlWidth)/2, 
                                  y: viewHeight - standardControlHeight - margin, 
                                  width: standardControlWidth, 
                                  height: standardControlHeight)
    }
    
    /*
     * doneButtonTapped()
     *
     * Respond to the tapping of the done button
     * Checks all settings are saved and removes the view
     */
    func doneButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
     * formatDate
     *
     * formats a date string
     *
     * some help from http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
     * and http://nsdateformatter.com/
     *
     * @param: dateStr: String - the date string to format
     * @return: formattedDate : String - the formatted date string
     */
    func formatDate (dateStr: String) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let intermediateDate : NSDate = dateFormatter.dateFromString(dateStr) {
            dateFormatter.dateStyle = .MediumStyle
            dateFormatter.timeStyle = .ShortStyle
            return dateFormatter.stringFromDate(intermediateDate)
        } else {
            DLog("Couldn't format date: \(dateStr)")
        }
        return dateStr
    }
    
    /*
     * formatJackpot
     *
     * formats a jackpot integer as a currency
     *
     * some ideas taken from:
     * http://supereasyapps.com/blog/2016/2/8/how-to-use-nsnumberformatter-in-swift-to-make-currency-numbers-easy-to-read
     * and http://stackoverflow.com/questions/31999748/get-currency-symbols-from-currency-code-with-swift
     *
     * @param: rawJackpot: Int - the jackpot integer to format
     * @return: jackpot : String - the formatted jackpot string
     */
    func formatJackpot (rawJackpot: Int) -> String {
        
        guard let currencyCode = userDefaults.stringForKey(kCurrency) else {
            DLog("Unable to fetch currency code from user defaults")
            return String(rawJackpot)
        }
        
        let localeComponents = [NSLocaleCurrencyCode: currencyCode]
        let localeIdentifier = NSLocale.localeIdentifierFromComponents(localeComponents)
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.locale = NSLocale(localeIdentifier: localeIdentifier)
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .CurrencyStyle
        
        if let jackpotStr = currencyFormatter.stringFromNumber(NSNumber(integer: rawJackpot)) {
            return jackpotStr
        } else {
            DLog("Unable to convert jackpot \\(\(rawJackpot)\\) to currency string")
            return String(rawJackpot)
        }
    }
}
