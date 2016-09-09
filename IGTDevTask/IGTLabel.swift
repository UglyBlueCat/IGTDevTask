//
//  IGTLabel.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 09/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import UIKit

class IGTLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStandards()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStandards()
    }
    
    convenience init(textStr: String) {
        self.init()
        text = textStr
    }
    
    /*
     * setupStandards
     *
     * Sets up label attributes considered standard or default for this application
     */
    func setupStandards() {
        backgroundColor = secondaryColor
        textColor = primaryTextColor
        textAlignment = .Center
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
}
