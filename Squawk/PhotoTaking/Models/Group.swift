//
//  GroupPhoto.swift
//  Squawk
//
//  Created by Abigail Chin on 8/10/16.
//  Copyright © 2016 Abigail Chin. All rights reserved.
//

import UIKit
import Bond
import Parse

class Group: PFObject, PFSubclassing{
    
    var image: Observable<UIImage?> = Observable(nil)
    var name: Observable<String?> = Observable(nil)
    var photoUploadTask: UIBackgroundTaskIdentifier?

    
    @NSManaged var groupPic: PFFile?
    @NSManaged var user: PFUser?
    
    static func parseClassName() -> String {
        return "Group"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    func uploadPhoto(){
        
        if let image = image.value{//if image has value
            
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else {return} //return as jpeg
            guard let imageFile = PFFile(name: "groupPic.jpg", data: imageData) else {return} //store in parse
            
            user = PFUser.currentUser()//initialize
            self.groupPic = imageFile //initialize
        
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
        }
      
    }
    func uploadName(){
    if let newName = name.value{
        saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
            newName
        })
}
    }
}
