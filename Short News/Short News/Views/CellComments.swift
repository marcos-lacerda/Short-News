//
//  CellComments.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 27/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit
import SnapKit

class CellComments: UITableViewCell
{
    // Declaration of UI Objects
    
    //<------------------- UIView ------------------------->
      let contentViewComment  = UIView(frame : CGRectZero)
    
    //<------------------- UILabel ------------------------->
      let lbComment           = UILabel(frame : CGRectZero)
    
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customizeUIObjects()
        setupConstrainsUIObjects()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    //<---------------------------- Method that Sets to the Appearance of the UI Objects ------------------------------>
    
    func customizeUIObjects()
    {
        self.contentViewComment.backgroundColor      = UIColor(white: 0.95, alpha: 1)
        self.contentViewComment.layer.cornerRadius   = 15
        self.contentViewComment.layer.masksToBounds  = true
        
        self.lbComment.numberOfLines    = 0
        self.lbComment.textAlignment    = NSTextAlignment.Natural
        self.lbComment.lineBreakMode    = NSLineBreakMode.ByClipping
        self.lbComment.font             = UIFont(name: "Avenir-Book", size: 17)
        
        self.contentViewComment.addSubview(self.lbComment)
               self.contentView.addSubview(self.contentViewComment)
    }
    
    //<---------------------------- Method That Sets Constrains to the UI Objects ------------------------------>
    
    func setupConstrainsUIObjects()
    {
        self.lbComment.snp_makeConstraints
        { (make) in
           
             make.top.equalTo(self.contentViewComment.snp_top).offset(10)
            make.left.equalTo(self.contentViewComment.snp_left).offset(10)
          make.bottom.equalTo(self.contentViewComment.snp_bottom).offset(-10)
           make.right.equalTo(self.contentViewComment.snp_right).offset(-10)
        }
        
        self.contentViewComment.snp_makeConstraints
        { (make) in
            
             make.top.equalTo(self.contentView.snp_top).offset(10)
            make.left.equalTo(self.contentView.snp_left).offset(10)
          make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
           make.width.equalTo(self.contentView.snp_width).multipliedBy(0.75)
        }
    }

}
