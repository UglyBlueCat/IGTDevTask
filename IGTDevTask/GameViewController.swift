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
    var nameLabel: UILabel!
    var dateLabel: UILabel!
    var jackpotLabel: UILabel!
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
        addObjects()
        positionObjectsWithinSize(view.bounds.size)
    }
    
    /*
     * addObjects()
     *
     * Add objects to the view
     */
    func addObjects () {

        nameLabel = UILabel()
        nameLabel.text = game.name
        nameLabel.textAlignment = .Center
        view.addSubview(nameLabel)
        
        dateLabel = UILabel()
        dateLabel.text = game.date
        dateLabel.textAlignment = .Center
        view.addSubview(dateLabel)
        
        jackpotLabel = UILabel()
        jackpotLabel.text = String(game.jackpot)
        jackpotLabel.textAlignment = .Center
        view.addSubview(jackpotLabel)
        
        doneButton = UIButton()
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), forControlEvents: .TouchUpInside)
        view.addSubview(doneButton)
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
}
