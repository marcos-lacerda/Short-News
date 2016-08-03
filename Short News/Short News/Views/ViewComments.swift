//
//  ViewComments.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 27/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit
import SnapKit

protocol ViewCommentDelegate: class
{
    func newComment(comment: String)
    func actionBack()
}

class ViewComments: UIView,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
     // Declaration of UI Objects
    //<--------------------- UIButton ---------------------->
      let btnSend            = UIButton(frame : CGRectZero)
      let btnBack            = UIButton(frame : CGRectZero)
    
    //<--------------------- UILabel ------------------------>
      let lbTitle            = UILabel(frame: CGRectZero)
    
    //<-------------------- UITableView --------------------->
      let tableViewComments  = UITableView(frame : CGRectZero)
    
    //<--------------------- UIView ------------------------->
      let contentView        = UIView(frame : CGRectZero)
    
    //<------------------- UITextField ---------------------->
      let textFieldComment   = UITextField(frame : CGRectZero)
    
    //<------------------- Auxiliary Variables -------------->
           var bottomConstraint    : Constraint? = nil
           var collectionsComments : [String]    = [String]()
      weak var delegate            : ViewCommentDelegate?
    
   
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        customizeHeader()
        customizeTableView()
        customizeContentView()
        setupConstrainsHeader()
        setupConstrainsTableView()
        setupContrainsContentView()
        setupKeyboardObservers()
        
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
       self.tableViewComments.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func setupKeyboardObservers()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func customizeHeader()
    {
        self.btnBack.setImage(UIImage(named:"btnBack.png"),forState: .Normal)
        self.btnBack.addTarget(self, action: #selector(actionBtnBack(_:)),   forControlEvents: .TouchUpInside)
        
        self.lbTitle.text  = "Comments"
        self.lbTitle.font  = UIFont(name: "Avenir-Black", size:17)
        
        self.addSubview(self.btnBack)
        self.addSubview(self.lbTitle)
    }
   
    func customizeTableView()
    {
        self.tableViewComments.delegate           = self
        self.tableViewComments.dataSource         = self
        self.tableViewComments.rowHeight          = UITableViewAutomaticDimension
        self.tableViewComments.estimatedRowHeight = 80
        self.tableViewComments.allowsSelection    = false
        
        
        self.tableViewComments.registerClass(CellComments.self, forCellReuseIdentifier: "cell")
        
        self.addSubview(self.tableViewComments)
    }
    
    func customizeContentView()
    {
       self.contentView.backgroundColor = UIColor.whiteColor()
        
       self.textFieldComment.delegate      = self
       self.textFieldComment.placeholder   = "Enter comment..."
       self.textFieldComment.returnKeyType = UIReturnKeyType.Done
       
       self.btnSend.setImage(UIImage(named:"btnSend.png"),forState: .Normal)
       self.btnSend.addTarget(self, action: #selector(actionBtnSend(_:)),   forControlEvents: .TouchUpInside)
        
        self.contentView.addSubview(self.textFieldComment)
        self.contentView.addSubview(self.btnSend)
                    self.addSubview(self.contentView)
        
    }
    
    func setupConstrainsHeader()
    {
        self.btnBack.snp_makeConstraints
        { (make) in
                make.top.equalTo(self).offset(25)
                make.left.equalTo(self).offset(15)
                make.bottom.equalTo(self.tableViewComments.snp_top).offset(-20)
                make.height.width.equalTo(25)
        }
        
        self.lbTitle.snp_makeConstraints
        { (make) in
                
                make.top.equalTo(self).offset(25)
                make.left.equalTo(self.btnBack.snp_right).offset(15)
                make.bottom.equalTo(self.tableViewComments.snp_top).offset(-20)
        }
    }
    
    
    func setupConstrainsTableView()
    {
        self.tableViewComments.snp_makeConstraints
        {(make) in
          
          make.top.equalTo(self.btnBack.snp_bottom).offset(20)
          make.left.right.equalTo(self)
          make.bottom.equalTo(self.contentView.snp_top).offset(0)
            
        }
    }
    
    func setupContrainsContentView()
    {
        self.contentView.snp_makeConstraints
        { (make) in
            
            make.top.equalTo(self.tableViewComments.snp_bottom).offset(0)
            make.left.right.equalTo(self)
            self.bottomConstraint = make.bottom.equalTo(self).constraint
            make.height.equalTo(50)
        }
        
        self.textFieldComment.snp_makeConstraints
        { (make) in
            
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.btnSend.snp_left).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        self.btnSend.snp_makeConstraints
        { (make) in
            
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.textFieldComment.snp_right).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    // --------------------- Methods Delegate of UITableView Comments ----------------------------------->
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.collectionsComments.count;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CellComments = self.tableViewComments.dequeueReusableCellWithIdentifier("cell") as! CellComments
        
         cell.lbComment.text   = self.collectionsComments[indexPath.row]
        
        return cell
    }
    
    func handleKeyboardWillShow(notification: NSNotification)
    {
        let keyboardFrame    = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        
        UIView.animateWithDuration(keyboardDuration!)
        {
            self.bottomConstraint!.updateOffset(-keyboardFrame!.height)
        }
    }
    
    
    func handleKeyboardWillHide(notification: NSNotification)
    {
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        
        UIView.animateWithDuration(keyboardDuration!)
        {
            self.bottomConstraint?.updateOffset(0)
        }
    }
    
    // --------------------- Methods of Action UIButtons ----------------------------------->
    
    func actionBtnSend(sender: UIButton!)
    {
        self.textFieldComment.resignFirstResponder()
        delegate?.newComment(self.textFieldComment.text!)
        self.textFieldComment.text = ""
    }
    
    func actionBtnBack(sender: UIButton!)
    {
        delegate?.actionBack()
    }
    
    func data(comments : [String])
    {
        self.collectionsComments = comments
        self.tableViewComments.reloadData()
    }
}
