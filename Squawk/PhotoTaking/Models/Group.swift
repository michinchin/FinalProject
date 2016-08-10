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

class Group: PFObject {
    
    var image: Observable<UIImage?> = Observable(nil)
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    @NSManaged var imageFile: PFFile?
    
    static func parseClassName() -> String {
        return "Group"
    }

    func uploadPic() {
        if let image = image.value {//if image has value
            
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else {return} //return as jpeg
            guard let imageFile = PFFile(name: "image.jpg", data: imageData) else {return} //store in parse
            
            self.imageFile = imageFile//initialize
            
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
        }
    }
    func downloadImage() {
        // if image is not downloaded yet, get it
        if (image.value == nil) {
            // 2
            imageFile?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    let image = UIImage(data: data, scale:1.0)!
                    // 3
                    self.image.value = image
                }
            }
        }
    }
}
