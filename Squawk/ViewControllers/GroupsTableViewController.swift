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
    
    var groups: [Group] = [] {
        didSet {
            tableView.reloadData()
            }
        }
    
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
        return groups.count
    }
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 3
        let cell = tableView.dequeueReusableCellWithIdentifier("listGroupsCell", forIndexPath: indexPath) as! GroupTableViewCell
        let row = indexPath.row
        // 4
        let group = groups[row]
        
        cell.groupTableLabel.text = group.name.value
        cell.groupImageView.image = group.image.value
        
        // 5
        return cell
    }


    



}
