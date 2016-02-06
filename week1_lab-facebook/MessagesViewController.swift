//
//  MessagesViewController.swift
//  week1_lab-facebook
//
//  Created by Bobby Smith on 1/29/16.
//  Copyright © 2016 Bobby Smith. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var navView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // grab image
        imageView = UIImageView(image: UIImage(named: "messages"))
        navView = UIImageView(image: UIImage(named: "nav"))
        
        imageView.frame = CGRect(x: 0, y: navView.frame.height - 30, width: imageView.frame.size.width, height: imageView.frame.size.height)
       
        
        // setup the scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = imageView.bounds.size
        
        
        // add the scrollview
        view.addSubview(scrollView)
        view.addSubview(navView)
        
        // add the image to the scrollview
        scrollView.addSubview(imageView)
        
        
        //        // create the button and add it to scrollview
        //        let button = UIButton(type: UIButtonType.System) as UIButton
        //        button.frame = CGRectMake(10, 230, 300, 370)
        //        button.backgroundColor = UIColor.clearColor()
        //        button.addTarget(self, action: Selector("btnClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
        //        scrollView.addSubview(button)
        
    }
    
    func btnClicked(sender: UIButton!) {
        performSegueWithIdentifier("detailView", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
