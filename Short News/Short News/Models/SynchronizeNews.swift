//
//  DataSync.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 27/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

protocol SynchronizeNewsDelegate: class
{
    func dataSource(news : [News]?)
}

class SynchronizeNews: NSObject
{
         var rootRef   : FIRDatabaseReference?
    weak var delegate  : SynchronizeNewsDelegate?
    
    static let sharedInstance = SynchronizeNews()
    
    //This prevents others from using the default '()' initializer for this class.
    
    private override init()
    {
       super.init()
       retrieveNews()
    }
  
    func retrieveNews()
    {
        rootRef = FIRDatabase.database().reference()
        
           if let unwrappedRef = rootRef
           {
                    unwrappedRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
                        
                        if let objectsDict = snapshot.value
                        { 
                                let json      = JSON(objectsDict)
                                var arrayNews = [News]()
                                
                                //Collection with all news
                                let collectionNews      : Dictionary<String, JSON> = json["news"].dictionaryValue
                            
                                for keyNews in collectionNews.keys
                                {
                                    // Dictionary with Properties/Details of News
                                    let news       : Dictionary<String, AnyObject> = collectionNews[keyNews]!.dictionaryObject!
                                    let objectNews : News                          = News(newsId: keyNews, newsDict: news)
                                    
                                    arrayNews.append(objectNews)
                                 }
                                
                                if let unwrappedDelegate = self.delegate
                                {
                                    unwrappedDelegate.dataSource(arrayNews)
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
