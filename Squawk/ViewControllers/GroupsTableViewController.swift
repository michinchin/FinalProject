//
//  GroupsTableTableViewController.swift
//  Squawk
//
//  Created by Abigail Chin on 8/4/16.
//  Copyright © 2016 Abigail Chin. All rights reserved.
//

import UIKit
import Parse

class GroupsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 3
        let cell = tableView.dequeueReusableCellWithIdentifier("listGroupsCell", forIndexPath: indexPath)
        
        // 4
        cell.textLabel?.text = "It's finally working!"
        
        // 5
        return cell
    }
   



}
