
//
//  PhotoViewController.swift
//  Squawk
//
//  Created by Abigail Chin on 8/5/16.
//  Copyright © 2016 Abigail Chin. All rights reserved.
//

import UIKit
import Parse

class PhotoViewController: UIViewController {//view controller for adding group photo
    

    var photoTakingHelper: PhotoTakingHelper?
    @IBAction func cancelToGroupsTableViewController(sender: AnyObject) {
        
    }
    @IBAction func saveNewGroup(sender: AnyObject) {

    }
  
    var imagePicker: UIImagePickerController!
    var groups: [Group] = []
    
    @IBOutlet weak var groupPhotoImageView: UIImageView!
    @IBOutlet weak var groupNameText: UITextField!
    
    
    @IBAction func addGroupPhoto(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            self.groupPhotoImageView.image = image
            let group = Group()
            group.image.value = image!
            group.name = self.groupNameText.text!
            group.uploadPhoto()
            group.uploadName()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
