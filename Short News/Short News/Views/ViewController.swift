//
//  ViewController.swift
//  Short News
//
//  Created by Marcos Vinicius Souza Lacerda on 25/07/16.
//  Copyright © 2016 Luigi Salemme. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SnapKit
import FirebaseDatabase

class ViewController: UIViewController,PresenterNewsDelegate,PresenterCommentsDelegate,GADBannerViewDelegate
{
    
    let presenterNews     = PresenterNews()
    var presenterComments : PresenterComments?
    let viewAds           = GADBannerView(frame : CGRectZero)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
           self.presenterNews.delegate = self
       
       self.view = self.presenterNews.view
    }
    
    override func viewWillAppear(animated: Bool)
    {
        customizeAds()
        setupContrainsAds()
    }

    override func didReceiveMemoryWarning()
    {
       super.didReceiveMemoryWarning()
    }
    
    func changeUIView(newsId: String?)
    {
       self.presenterComments = PresenterComments(newsId: newsId)
       self.presenterComments!.delegate = self
      
       self.view = self.presenterComments!.view
    }
    
    func removeUIView()
    {
       self.view = self.presenterNews.view
    }
    
    //<---------------------------- Method that Sets to the Configuration of the UIActivityViewController ------------------------------>
    
    func share(shareText shareText:String?)
    {
        
        var objectsToShare = [AnyObject]()
        
        if let shareTextObj = shareText{
            objectsToShare.append(shareTextObj)
            }
        
      
        if (objectsToShare.count > 0)
        {
            let activityShare = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityShare.excludedActivityTypes = [UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeSaveToCameraRoll]
            
            presentViewController(activityShare, animated: true, completion: nil)
        }
    }
    
    //<---------------------------- Method that Sets to the Configuration of the ViewAdMob ------------------------------>
    
    func customizeAds()
    {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        viewAds.delegate    = self
        viewAds.adUnitID    = "ca-app-pub-3940256099942544/2934735716"
        viewAds.rootViewController = self
        viewAds.loadRequest(request)
        
        self.view.addSubview(self.viewAds)
    }
    
    //<---------------------------- Method That Sets Constrains to the ViewAdMob ------------------------------>
    
    func setupContrainsAds()
    {
        self.viewAds.snp_makeConstraints
        { (make) in
            make.height.equalTo(50)
            make.width.equalTo(320)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.snp_bottom).offset(1)
        }
    }
}

