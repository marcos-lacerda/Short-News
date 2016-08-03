//
//  SynchronizeComments.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 01/08/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

protocol SynchronizeCommentsDelegate : class
{
    func dataSource(comments : [String])
}

class SynchronizeComments: NSObject
{
    
         var rootRef    : FIRDatabaseReference?
    weak var delegate   : SynchronizeCommentsDelegate?
    
    static let sharedInstance = SynchronizeComments()
    
    //This prevents others from using the default '()' initializer for this class.
    
    private override init(){}
   
    func retrieveComments(idNews : String)
    {
        rootRef = FIRDatabase.database().reference()
        
        if let unwrappedRef = rootRef
        {
            unwrappedRef.child("comments/"+idNews).observeEventType(FIRDataEventType.Value, withBlock:
                { (snapshot) in
                    
                    if let objectsDict = snapshot.value
                    {
                        //Collection with all Comments of all news
                        let collectionComments = JSON(objectsDict)
                        
                        var commentsTheNews    = [String]()
                        
                        for (_,comment):(String,JSON) in collectionComments
                        {
                            commentsTheNews.append(comment.string!)
                        }
                        
                        if let unwrappedDelegate = self.delegate
                        {
                            unwrappedDelegate.dataSource(commentsTheNews)
                        }
                    }
            })
        }
    }
    
    func saveData(pathString: String,value: AnyObject)
    {
        if let unwrappedRef = rootRef
        {
            unwrappedRef.child(pathString).setValue(value)
        }
    }
}
