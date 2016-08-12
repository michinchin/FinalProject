//
//  GroupTableViewCell.swift
//  Squawk
//
//  Created by Abigail Chin on 8/11/16.
//  Copyright © 2016 Abigail Chin. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupTableLabel: UILabel!
    

    func circularImage(photoImageView: UIImageView?)
    {
        photoImageView!.layer.frame = CGRectInset(photoImageView!.layer.frame, 0, 0)
        photoImageView!.layer.borderColor = UIColor.grayColor().CGColor
        photoImageView!.layer.cornerRadius = photoImageView!.frame.height/2
        photoImageView!.layer.masksToBounds = false
        photoImageView!.clipsToBounds = true
        photoImageView!.layer.borderWidth = 0.5
        photoImageView!.contentMode = UIViewContentMode.ScaleAspectFill
    }
    @IBOutlet weak var groupImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        circularImage(groupImageView)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
