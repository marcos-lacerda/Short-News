//
//  PresenterComments.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 27/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit

protocol PresenterCommentsDelegate: class
{
    func removeUIView()
}

class PresenterComments: NSObject,ViewCommentDelegate,SynchronizeCommentsDelegate
{
    weak var delegate           :  PresenterCommentsDelegate?
         var view               :  ViewComments?
         var dataSync           :  SynchronizeComments?
         var newsKey            :  String?
         var collectionComments = [String]()
    
   init(newsId : String?)
   {
        super.init()
    
         view           = ViewComments()
         dataSync       = SynchronizeComments.sharedInstance
    
        view!.delegate  = self
    dataSync!.delegate  = self
    
        if let unwrappedId = newsId
        {
            newsKey = unwrappedId
            dataSync!.retrieveComments(unwrappedId)
        }
    }
    
    // Methods Delegate of ViewComments
    
    func actionBack()
    {
        if let unwrappedDelegate = delegate
        {
            unwrappedDelegate.removeUIView()
        }
    }

    func newComment(comment: String)
    {
        if (comment.characters.count > 0)
        {
            if let unwrappedKey = newsKey
            {
                 let keyComment = "comment" + String(collectionComments.count + 1)
                
                 dataSync!.saveData("comments/\(unwrappedKey)/\(keyComment)", value: comment)
            }
        }
    }
    
    func dataSource(comments : [String])
    {
        if let unwrappedView = view
        {
            if (comments.count > 0)
            {
               collectionComments = comments
               unwrappedView.data(comments)
            }
        }
    }
}
