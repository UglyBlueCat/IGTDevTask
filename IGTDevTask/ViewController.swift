//
//  ViewController.swift
//  IGTDevTask
//
//  Created by Robin Spinks on 06/09/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel: IGTLabel!
    var resultsTable: UITableView!
    var activityIndicator: UIActivityIndicatorView!

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
        
        titleLabel = IGTLabel(textStr: "IGT Games")
        view.addSubview(titleLabel)
        
        resultsTable = UITableView()
        configureTable()
        view.addSubview(resultsTable)
        
        activityIndicator = UIActivityIndicatorView()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        }
        view.addSubview(activityIndicator)
        if DataHandler.sharedInstance.games.count <= 0 {
            activityIndicator.startAnimating()
        }
    }
    
    /*
     * configureTable
     *
     * Configures the table
     */
    func configureTable () {
        
        resultsTable.delegate = self
        resultsTable.dataSource = self
        resultsTable.separatorStyle = .None
        resultsTable.backgroundColor = UIColor.clearColor()
        resultsTable.registerClass(IGTTableViewCell.self, forCellReuseIdentifier: "IGTTableViewCell")
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
                                  height: viewHeight - CGRectGetMaxY(titleLabel.frame) - 2*margin)
        
        activityIndicator.frame = CGRect(x: (viewWidth - standardControlHeight)/2,
                                         y: (viewHeight - standardControlHeight)/2,
                                         width: standardControlHeight,
                                         height: standardControlHeight)
    }
    
    /*
     * newDataReceived()
     *
     * Called when notification of new data download completion is received
     * Reloads the table
     */
    func newDataRecieved () {
        
        // Make sure UI changes happen on the main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.resultsTable.reloadData()
            self.activityIndicator.stopAnimating()
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataHandler.sharedInstance.games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell : IGTTableViewCell = tableView.dequeueReusableCellWithIdentifier("IGTTableViewCell") as? IGTTableViewCell else {
            DLog("Could not dequeue cell")
            return UITableViewCell()
        }
        if DataHandler.sharedInstance.games.count > 0 {
            cell.detailLabel!.text = DataHandler.sharedInstance.games[indexPath.row].name
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let gameVC : GameViewController = GameViewController()
        if DataHandler.sharedInstance.games.count > 0 {
            gameVC.game = DataHandler.sharedInstance.games[indexPath.row]
        }
        presentViewController(gameVC, animated: true, completion: nil)
    }
}
