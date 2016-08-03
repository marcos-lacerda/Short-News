//
//  ViewNews.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 26/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMobileAds

class ViewNews: UIView,UITableViewDelegate,UITableViewDataSource
{
    //<--------------- UITableView --------------->
    
     let tableView  = UITableView(frame : CGRectZero)
    
    //<--------------- UIView ------------------>
    
     let  viewHeader = UIView(frame : CGRectZero)
    
    //<--------------- UILabel ------------------>
    
     let  lbTitle    = UILabel(frame : CGRectZero)
    
    //<------------------- Auxiliary Variables -------------->
    
         var collectionsNews : [News] = [News]()
    weak var delegate        : CellNewsDelegate?
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.customizeTableView()
        self.setupConstrainsTableView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
    }
    
    func customizeTableView()
    {
        self.tableView.delegate           = self
        self.tableView.dataSource         = self
        self.tableView.rowHeight          = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.allowsSelection    = false
        
        self.tableView.registerClass(CellNews.self, forCellReuseIdentifier: "cell")
        
        self.addSubview(self.tableView)
    }
    
    func setupConstrainsTableView()
    {
       self.tableView.snp_makeConstraints
        { (make) in
          make.top.left.right.equalTo(self)
          make.bottom.equalTo(self.snp_bottom).offset(-50)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return collectionsNews.count;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        self.lbTitle.text  = "App Name"
        self.lbTitle.font  = UIFont(name: "Avenir-Book", size:17.0)
        
        self.viewHeader.backgroundColor = UIColor.whiteColor()
        
        self.viewHeader.addSubview(self.lbTitle)
        
        self.lbTitle.snp_makeConstraints
        { (make) in
            make.top.equalTo(self.viewHeader.snp_top).offset(25)
            make.centerX.equalTo(self.viewHeader)
        }
        
        return self.viewHeader
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return self.frame.height * 0.1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CellNews = self.tableView.dequeueReusableCellWithIdentifier("cell") as! CellNews
        let news: News     = collectionsNews[indexPath.row]
        
        cell.delegate = self.delegate
        cell.index    = indexPath.row
        cell.customImageView.sd_setImageWithURL(NSURL(string: news.imageUrl))
                 cell.lbText.text   = news.text
        cell.lbNumberOfLikes.text   = String(news.numberOfLikes)
     cell.lbNumberOfDislikes.text   = String(news.numberOfDislikes)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func data(news : [News])
    {
        self.collectionsNews = news
        self.tableView.reloadData()
    }
}
