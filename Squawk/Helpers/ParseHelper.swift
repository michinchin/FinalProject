//
//  ParseHelper.swift
//  Makestagram
//
//  Created by Abigail Chin on 8/8/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

// 1
class ParseHelper {
    
    //Following Relation
    static let ParseFollowClass  = "Follow"
    static let ParseFollowFromUser    = "fromUser"
    static let ParseFollowToGroup      = "toGroup"
    
    // Like Relation
    static let ParseLikeClass         = "Like"
    static let ParseLikeToPost        = "toPost"
    static let ParseLikeFromUser      = "fromUser"
    
    // Post Relation
    static let ParsePostUser          = "user"//pointer in post to user
    static let ParsePostCreatedAt     = "createdAt"
    
    // Flagged Content Relation
    static let ParseFlaggedContentClass    = "FlaggedContent"
    static let ParseFlaggedContentFromUser = "fromUser"
    static let ParseFlaggedContentToPost   = "toPost"
    
    // User Relation
    static let ParseUserUsername      = "username"
    static let ParseGroupName = "name"

    //Group Relation
    static let ParseGroupClass = "Group"
    static let ParseGroupFollowFromUser = "fromUser"
    static let ParseGroupFollowToUser = "toUser"
    
    // 2
    static func timelineRequestForCurrentUser(completionBlock: PFQueryArrayResultBlock) {
        let followingGroupQuery = PFQuery(className: ParseGroupClass)
        followingGroupQuery.whereKey(ParseGroupFollowFromUser, equalTo:PFUser.currentUser()!)
        
        let postsFromGroup = Post.query()
        postsFromGroup!.whereKey(ParsePostUser, matchesKey: ParseGroupFollowToUser, inQuery: followingGroupQuery)
        
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey(ParsePostUser, equalTo: PFUser.currentUser()!)
        
        let query = PFQuery.orQueryWithSubqueries([postsFromGroup!, postsFromThisUser!])
        query.includeKey(ParsePostUser)
        query.orderByDescending(ParsePostCreatedAt)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    static func likePost(user: PFUser, post: Post) {
        let likeObject = PFObject(className: ParseLikeClass)//create object to link to parse for user
        likeObject[ParseLikeFromUser] = user
        likeObject[ParseLikeToPost] = post
        
        likeObject.saveInBackgroundWithBlock(nil)
    }
    
    static func unlikePost(user: PFUser, post: Post) {
        // Put your code here
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeFromUser, equalTo: user)
        query.whereKey(ParseLikeToPost, equalTo: post)
        
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, eror: NSError?)->Void in
            if let results = results {
                for like in results {
                    like.deleteInBackgroundWithBlock(nil)
                }
            }
        }
        
    }
    
    static func likesForPost(post: Post, completionBlock: PFQueryArrayResultBlock) {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeToPost, equalTo: post)
        query.includeKey(ParseLikeFromUser)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    static func joinGroup(user: PFUser, group: Group){
        let joinObject = PFObject(className: ParseFollowClass)
        joinObject[ParseFollowFromUser] = user
        joinObject[ParseFollowToGroup] = group
        
        joinObject.saveInBackgroundWithBlock(nil)
        
    }
    static func listRequestforCurrentGroup(completionBlock: PFQueryArrayResultBlock) {
        let query = PFQuery(className: ParseGroupClass)
        query.orderByAscending(ParseGroupName)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    
    }
}
extension PFObject {
    
    public override func isEqual(object: AnyObject?) -> Bool {
        if (object as? PFObject)?.objectId == self.objectId {
            return true
        } else {
            return super.isEqual(object)
        }
    }
    
}