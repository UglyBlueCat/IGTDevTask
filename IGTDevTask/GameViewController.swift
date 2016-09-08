//
//  GameViewController.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 08/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        positionObjectsWithinSize(size)
    }
    
    func setupView () {
        addObjects()
        positionObjectsWithinSize(view.bounds.size)
    }
    
    func addObjects () {
        
    }
    
    func positionObjectsWithinSize (size: CGSize) {
        
    }
}
