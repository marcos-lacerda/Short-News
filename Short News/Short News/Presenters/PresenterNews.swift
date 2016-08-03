//
//  PresenterNews.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 27/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit

protocol PresenterNewsDelegate: class
{
    func changeUIView(newsId : String?)
    func share(shareText shareText:String?)
}

class PresenterNews: NSObject,CellNewsDelegate,SynchronizeNewsDelegate
{
    weak var delegate          : PresenterNewsDelegate?
         var view              : ViewNews?
         var collectionNews    : [News]!
         var dataSync          : SynchronizeNews?
    
    override init()
    {
        super.init()
        
            self.view           = ViewNews()
            self.dataSync       = SynchronizeNews.sharedInstance
            
            self.view!.delegate = self
        self.dataSync!.delegate = self
    }
    
    func actionLike(index : Int?)
    {
        if let unwrappedIndex = index
        {
            if let unwrappedCollection = collectionNews
            {
                let objectNews    : News     = unwrappedCollection[unwrappedIndex]
                let numberOfLikes : NSNumber = Int(objectNews.numberOfLikes) + 1
                
                dataSync!.saveData("news/\(objectNews.newsId)/number_of_likes", value: numberOfLikes)
            }
        }
    }
    
    func actionDislike(index : Int?)
    {
        if let unwrappedIndex = index
        {
            if (collectionNews.count > 0)
            {
                let objectNews       : News     = collectionNews[unwrappedIndex]
                let numberOfDislikes : NSNumber = Int(objectNews.numberOfDislikes) + 1
                
                dataSync!.saveData("news/\(objectNews.newsId)/number_of_dislikes", value: numberOfDislikes)
            }
        }
    }
    
    func actionComment(index : Int?)
    {
        if let unwrappedIndex = index
        {
            var objectNews : News?
            
            if (collectionNews.count > 0)
            {
                objectNews = collectionNews[unwrappedIndex]
            }
            
            if let unwrappedDelegate = delegate
            {
                if let unwrappedObject = objectNews
                {
                   unwrappedDelegate.changeUIView(unwrappedObject.newsId)
                }
            }
        }
    }
    
    func actionShare(index : Int?)
    {
        if let unwrappedIndex = index
        {
            var objectNews : News?
            
            if(collectionNews.count > 0)
            {
                objectNews = collectionNews[unwrappedIndex]
            }
            
            if let unwrappedDelegate = delegate
            {
                if let unwrappedObject = objectNews
                {
                   unwrappedDelegate.share(shareText: unwrappedObject.text)
                }
            }
        }
    }
    
    func dataSource(news: [News]?)
    {
        if let unwrappedArrayNews = news
        {
            if(unwrappedArrayNews.count > 0)
            {
                collectionNews = unwrappedArrayNews
                view!.data(unwrappedArrayNews)
            }
        }
    }
}
