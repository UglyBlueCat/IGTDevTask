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
        titleLabel = UILabel()
        titleLabel.text = "IGT Games"
        titleLabel.textAlignment = .Center
        view.addSubview(titleLabel)
        
        resultsTable = UITableView()
        resultsTable.delegate = self
        resultsTable.dataSource = self
        resultsTable.registerClass(IGTTableViewCell.self, forCellReuseIdentifier: "IGTTableViewCell")
        view.addSubview(resultsTable)
    }
    
    /*
     * positionObjectsWithinSize
     *
     * Place and size objects relative to the size object they are placed in
     * Done in a seperate method so it can be called from different places
     */
    func positionObjectsWithinSize (size: CGSize) {
        let viewHeight : CGFloat = size.height
        let viewWidth : CGFloat = size.width
        let margin: CGFloat = (viewWidth + viewHeight)/100
        
        titleLabel.frame = CGRect(x: margin, 
                                  y: topMargin, 
                                  width: viewWidth - 2*margin, 
                                  height: standardControlHeight)
        
        resultsTable.frame = CGRect(x: margin, 
                                  y: CGRectGetMaxY(titleLabel.frame) + margin, 
                                  width: viewWidth - 2*margin, 
                                  height: viewHeight - CGRectGetHeight(titleLabel.frame) - 3*margin)
    }
    
    /*
     * newDataReceived()
     *
     * Called when notification of new data download completion is received
     * Reloads the table
     */
    func newDataRecieved () {
        resultsTable.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataHandler.sharedInstance.games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : IGTTableViewCell = tableView.dequeueReusableCellWithIdentifier("IGTTableViewCell", forIndexPath: indexPath) as! IGTTableViewCell
        cell.detailLabel!.text = DataHandler.sharedInstance.games[indexPath.row].name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let gameVC : GameViewController = GameViewController()
        gameVC.game = DataHandler.sharedInstance.games[indexPath.row]
        presentViewController(gameVC, animated: true, completion: nil)
    }
}
