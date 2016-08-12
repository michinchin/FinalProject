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
    
    var groups: [Group] = []{
        didSet {
            tableView.reloadData()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        ParseHelper.listRequestforCurrentGroup { (result: [PFObject]?, error: NSError?) -> Void in
            self.groups = result as? [Group] ?? []
            
            
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(groups.count)
        return groups.count
        
    }
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listGroupsCell", forIndexPath: indexPath) as! GroupTableViewCell
        
        let row = indexPath.row
        // 4
        let group = self.groups[row]
        
        cell.groupTableLabel.text = group.name
        let userImageFile = group["groupPic"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) in
            if (error == nil) {
                let image = UIImage(data:imageData!)
                cell.groupImageView.image = image
            }
        }

//        cell.groupImageView.image = group.image.value
        
        
        // 5
        return cell
    }
    


    //for some reason need these actions...
    @IBAction func unwindtoGroupTableView(segue: UIStoryboardSegue){
        
    }
    @IBAction func saveAndReturn(segue: UIStoryboardSegue){
        
    }
    /*Try to implement delete function*/
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            var groupClass = PFObject(className: "Group")
//            groupClass.deleteInBackgroundWithBlock {(success, error) -> Void in
//                if error == nil {
//                    self.groups.removeAtIndex(indexPath.row)
//                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
//                    print("successfully deleted!")
//                } else {
//                    print("something wrong, please try again")
//                }
//                //            groupClass = groups[indexPath.row] as PFObject
//                //            groups.removeAtIndex(indexPath.row)
//                //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//                
//            }
//        }
//    }
}
