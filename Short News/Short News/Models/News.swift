//
//  News.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 25/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit

class News: NSObject
{
    private var _newdId           : String!
    private var _title            : String!
    private var _subTitle         : String!
    private var _text             : String!
    private var _imageUrl         : String!
    private var _comments         : [String] = [String]()
    private var _numberOfLikes    : NSNumber!
    private var _numberOfDislikes : NSNumber!
    
    
    var newsId: String {
        return _newdId
    }
    
    var title: String {
        return _title
    }
    
    var subTitle: String {
        return _subTitle
    }
    
    var text: String {
        return _text
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var comments: [String] {
        return _comments
    }
    
    var numberOfLikes: NSNumber {
        return _numberOfLikes
    }
    
    var numberOfDislikes: NSNumber {
        return _numberOfDislikes
    }
    
    init(newsId: String,newsDict: Dictionary<String, AnyObject>)
    {
        self._newdId = newsId
        
        if let tempTitle = newsDict["title"] as? String {
            self._title  = tempTitle
        }
        
        if let tempSubTitle = newsDict["subTitle"] as? String {
            self._subTitle  = tempSubTitle
        }
        
        if let tempText = newsDict["text"] as? String {
            self._text  = tempText
        }
        
        if let  tempImageUrl = newsDict["imageUrl"] as? String {
            self._imageUrl   = tempImageUrl
        }
        
        if let tempNumberOfLikes = newsDict["number_of_likes"] as? NSNumber {
            self._numberOfLikes  = tempNumberOfLikes
        }
        
        if let  tempNumberOfDislikes = newsDict["number_of_dislikes"] as? NSNumber {
            self._numberOfDislikes   = tempNumberOfDislikes
        }
    }
    
    func setComments(arrayComments:[String])
    {
        if arrayComments.count > 0
        {
            self._comments = arrayComments
        }
    }
}
