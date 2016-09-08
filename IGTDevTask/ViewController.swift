//
//  ViewController.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 06/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel: UILabel!
    var resultsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(newDataRecieved), name: kNewData, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        positionObjectsWithinSize(size)
        resultsTable.reloadData()
    }
    
    func setupView () {
        addObjects()
        positionObjectsWithinSize(view.bounds.size)
    }
    
    func addObjects () {
        
    }
    
    func positionObjectsWithinSize (size: CGSize) {
        
    }
    
    func newDataRecieved () {
        resultsTable.reloadData()
    }
}

