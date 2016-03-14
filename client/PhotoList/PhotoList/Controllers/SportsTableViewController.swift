//
//  SportsTableViewController.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit
import RealmSwift

class SportsTableViewController: UITableViewController {

    private let _operationQueue = OperationQueue()
    private let _realmQueue = dispatch_queue_create("db", DISPATCH_QUEUE_SERIAL);
    private var _sports: [[Sport]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Credentials.sharedInstance.isLogged() {
            let getSportsOperation = GetSportsOperation { _ in
                self.getSportsFromDB()
            }
            _operationQueue.addOperation(getSportsOperation)
        } else {
            if let login = UIStoryboard.initialize(String(LoginViewController), storyboardName: "Main") {
                self.navigationController?.presentViewController(login, animated: false, completion: nil)
            }
        }
    }
    
    private func getSportsFromDB() {
        dispatch_async(dispatch_get_main_queue()) {
            do {
                let _db = try Realm()
                let sports = _db.objects(Sport.self)
                
                let ski = sports.filter { $0.category.lowercaseString == "ski" }
                let kite = sports.filter { $0.category.lowercaseString == "kite" }
                
                self._sports = [ski, kite]
                self.tableView.reloadData()
                
            } catch let error as NSError {
                print("Couldn't create the DB instance: \(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self._sports.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._sports[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SportCell", forIndexPath: indexPath)

        let sport = self._sports[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = sport.name

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sport = self._sports[section].first {
            return sport.category
        }
        return nil
    }

}
