//
//  IGTTableViewCell.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 09/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import UIKit

class IGTTableViewCell: UITableViewCell {
    
    var detailLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sizeObjects()
    }
    
    /*
     * setupView()
     *
     * Set up objects in the cell.
     * Seperate from sizeObjects() so it can be called from initialisers
     */
    func setupView() {
        detailLabel = UILabel()
        detailLabel.textAlignment = .Center
        self.addSubview(detailLabel!)
    }
    
    /*
     * sizeObjects()
     *
     * Change the size of objects in the cell
     * These are in a seperate function so they can be called from layoutSubviews()
     */
    func sizeObjects() {
        let margin: CGFloat = 1.0
        let cellHeight : CGFloat = bounds.size.height
        let cellWidth : CGFloat = bounds.size.width
        
        detailLabel.frame = CGRect(x: margin,
                                   y: margin,
                                   width: cellWidth - 2*margin,
                                   height: cellHeight - 2*margin)
    }

}
