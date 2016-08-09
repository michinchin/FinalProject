//
//  PhotoTimelineViewController.swift
//  Squawk
//
//  Created by Abigail Chin on 8/4/16.
//  Copyright © 2016 Abigail Chin. All rights reserved.
//

import UIKit
import Parse

class PhotoTimelineViewController: UIViewController{
  
    
    var photoTakingHelper: PhotoTakingHelper?
    var imagePicker: UIImagePickerController!
    var posts: [Post] = []

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addPhotoToTimeline(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            let post = Post()
            post.image.value = image!
            post.uploadPost()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        let post = posts[indexPath.row]
        post.downloadImage()
        post.fetchLikes()
        cell.post = post
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        ParseHelper.timelineRequestForCurrentUser { (result: [PFObject]?, error: NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            
            self.tableView.reloadData()
        }
    }
    
    
   
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
