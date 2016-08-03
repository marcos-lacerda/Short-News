//
//  CellNews.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 26/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

protocol CellNewsDelegate: class
{
    func actionComment(index : Int?)
    func actionLike(index    : Int?)
    func actionDislike(index : Int?)
    func actionShare(index   : Int?)
}

class CellNews: UITableViewCell
{
    
    // Declaration of UI Objects
    //<------------------- UIImageView --------------------->
    
    let customImageView     = UIImageView(frame : CGRectZero)
    
    //<------------------- UILabel ------------------------->
    
    let  lbText             = UILabel(frame : CGRectZero)
    let  lbNumberOfLikes    = UILabel(frame : CGRectZero)
    let  lbNumberOfDislikes = UILabel(frame : CGRectZero)
    
    //<------------------- UIButton ------------------------->
    
    let  btnLike            = UIButton(frame : CGRectZero)
    let  btnDislike         = UIButton(frame : CGRectZero)
    let  btnComment         = UIButton(frame : CGRectZero)
    let  btnShare           = UIButton(frame : CGRectZero)
    
    //<------------------- Auxiliary Variables -------------->
    
    weak var delegate : CellNewsDelegate?
         var index    : Int?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.customImageView)
        self.customizeUIlabels()
        self.customizeUIButtons()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
         super.init(coder: aDecoder)
    }

    override func layoutIfNeeded()
    {
       self.setupConstrainsImageView()
       self.setupConstrainsLabel()
       self.setupConstrainsButtons()
    }
    
    //<---------------------------- Method that Sets to the Appearance of the UILabels ------------------------------>
    
    func customizeUIlabels()
    {
        self.lbText.numberOfLines             = 0
        self.lbText.textAlignment             = NSTextAlignment.Natural
        self.lbText.lineBreakMode             = NSLineBreakMode.ByClipping
        self.lbText.font                      = UIFont(name: "Avenir-Book", size: 17)
        
        
        self.lbNumberOfLikes.textAlignment    = NSTextAlignment.Natural
        self.lbNumberOfLikes.font             = UIFont(name: "Avenir-Book", size: 17)
        
        self.lbNumberOfDislikes.textAlignment = NSTextAlignment.Natural
        self.lbNumberOfDislikes.font          = UIFont(name: "Avenir-Book", size: 17)
        
        self.contentView.addSubview(self.lbText)
        self.contentView.addSubview(self.lbNumberOfLikes)
        self.contentView.addSubview(self.lbNumberOfDislikes)
    }
    
    //<---------------------------- Method that Sets to the Appearance of the Buttons ------------------------------>
    
    func customizeUIButtons()
    {
            btnLike.setImage(UIImage(named:"btnLike.png"),    forState: .Normal)
         btnDislike.setImage(UIImage(named:"btnDislike.png"), forState: .Normal)
         btnComment.setImage(UIImage(named:"btnComment.png"), forState: .Normal)
           btnShare.setImage(UIImage(named:"btnShare.png"),   forState: .Normal)
        
            btnLike.addTarget(self, action: #selector(actionBtnLike(_:)),     forControlEvents: .TouchUpInside)
         btnDislike.addTarget(self, action: #selector(actionBtnDislike(_:)),  forControlEvents: .TouchUpInside)
         btnComment.addTarget(self, action: #selector(actionBtnComment(_:)),  forControlEvents: .TouchUpInside)
           btnShare.addTarget(self, action: #selector(actionBtnShare(_:)),    forControlEvents: .TouchUpInside)
        
        self.contentView.addSubview(self.btnLike)
        self.contentView.addSubview(self.btnDislike)
        self.contentView.addSubview(self.btnComment)
        self.contentView.addSubview(self.btnShare)
    }
    
    //<---------------------------- Method That Sets Constrains to the UIImageView ------------------------------>
    
    func setupConstrainsImageView()
    {
       self.customImageView.snp_makeConstraints
       { (make) in
        
           make.top.equalTo(self.contentView.snp_top).offset(15)
           make.left.equalTo(self.contentView.snp_left).offset(15)
           make.right.equalTo(self.contentView.snp_right).offset(-15)
           make.bottom.equalTo(self.lbText.snp_top).offset(-15)
           make.height.equalTo(self.contentView.snp_width).multipliedBy(0.5)
        }
    }
    
    //<---------------------------- Method That Sets Constrains to the UILabels ------------------------------>
    
    func setupConstrainsLabel()
    {
       self.lbText.snp_makeConstraints
        { (make) in
            
            make.top.equalTo(self.customImageView.snp_bottom).offset(15)
            make.left.equalTo(self.contentView.snp_left).offset(15)
            make.right.equalTo(self.contentView.snp_right).offset(-15)
            make.bottom.equalTo(self.btnLike.snp_top).offset(-15)
        }
        
        self.lbNumberOfLikes.snp_makeConstraints
        { (make) in
           make.top.equalTo(self.lbText.snp_bottom).offset(18)
           make.left.equalTo(self.btnLike.snp_right).offset(10)
           make.bottom.equalTo(self.contentView.snp_bottom).offset(-12)
        }
        
        self.lbNumberOfDislikes.snp_makeConstraints
        { (make) in
                make.top.equalTo(self.lbText.snp_bottom).offset(18)
                make.left.equalTo(self.btnDislike.snp_right).offset(10)
                make.bottom.equalTo(self.contentView.snp_bottom).offset(-12)
        }
    }
    
    //<---------------------------- Method That Sets Constrains to the Buttons ------------------------------>
    
    
    func setupConstrainsButtons()
    {
            self.btnLike.snp_makeConstraints
            { (make) in
                    
                     make.top.equalTo(self.lbText.snp_bottom).offset(15)
                    make.left.equalTo(self.contentView.snp_left).offset(20)
                    make.height.equalTo(self.contentView.snp_width).multipliedBy(0.1)
                   make.width.equalTo(self.contentView.snp_width).multipliedBy(0.1)
            }
            
            self.btnDislike.snp_makeConstraints
            {(make) in
               
                 make.top.equalTo(self.lbText.snp_bottom).offset(15)
                make.left.equalTo(self.lbNumberOfLikes.snp_right).offset(15)
                make.height.equalTo(self.contentView.snp_width).multipliedBy(0.1)
               make.width.equalTo(self.contentView.snp_width).multipliedBy(0.1)
            }
            
            self.btnComment.snp_makeConstraints
            {(make) in
                    
                    make.top.equalTo(self.lbText.snp_bottom).offset(16)
                    make.left.equalTo(self.lbNumberOfDislikes.snp_right).offset(15)
                    make.height.equalTo(self.contentView.snp_width).multipliedBy(0.1)
                    make.width.equalTo(self.contentView.snp_width).multipliedBy(0.1)
            }
        
            self.btnShare.snp_makeConstraints
            { (make) in
                
                make.top.equalTo(self.lbText.snp_bottom).offset(14)
                make.right.equalTo(self.contentView.snp_right).offset(-25)
                make.height.equalTo(self.contentView.snp_width).multipliedBy(0.1)
                make.width.equalTo(self.contentView.snp_width).multipliedBy(0.1)
            
            }
    }
    
    //<---------------------------- Action Methods to the Buttons ---------------------------->
    
    func actionBtnLike(sender: UIButton!)
    {
        if let unwrappedIndex = index
        {
            if let unwrappedDelegate = delegate
            {
                unwrappedDelegate.actionLike(unwrappedIndex)
            }
        }
    }
    
    func actionBtnDislike(sender: UIButton!)
    {
        if let unwrappedIndex = index
        {
            if let unwrappedDelegate = delegate
            {
                unwrappedDelegate.actionDislike(unwrappedIndex)
            }
        }
    }
    
    func actionBtnComment(sender: UIButton!)
    {
        if let unwrappedIndex = index
        {
            if let unwrappedDelegate = delegate
            {
                unwrappedDelegate.actionComment(unwrappedIndex)
            }
        }
    }
    
    func actionBtnShare(sender: UIButton!)
    {
        if let unwrappedIndex = index
        {
            if let unwrappedDelegate = delegate
            {
                unwrappedDelegate.actionShare(unwrappedIndex)
            }
        }
    }
}
