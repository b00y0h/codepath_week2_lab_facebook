//
//  SettingsViewController.swift
//  week1_lab-facebook
//
//  Created by Bobby Smith on 1/29/16.
//  Copyright © 2016 Bobby Smith. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var navView: UIImageView!
    var scrollFrame: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // grab image
        imageView = UIImageView(image: UIImage(named: "settings"))
        navView = UIImageView(image: UIImage(named: "nav"))
        
        imageView.frame = CGRect(x: 0, y: navView.frame.height, width: imageView.frame.size.width, height: imageView.frame.size.height)
                
        // setup the scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = imageView.bounds.size
        
        // add the scrollview
        view.addSubview(scrollView)
        view.addSubview(navView)
        
        // add the image to the scrollview
        scrollView.addSubview(imageView)
        
        // create the button and add it to scrollview
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 1810, 320, 50)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: Selector("showAlert"), forControlEvents: .TouchUpInside)
        
        scrollView.addSubview(button)
        
    }

    func logoutBtnClicked() {
        performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Are you sure you want to log out?", message: "Message", preferredStyle: .ActionSheet)
        
        let okAction = UIAlertAction(title: "Log Out", style: .Destructive) { action -> Void in
            self.performSegueWithIdentifier("logoutSegue", sender: nil)
        }
        
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { action -> Void in}

        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)

    }
    
}
