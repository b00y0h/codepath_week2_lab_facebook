//
//  UpdateStatusViewController.swift
//  week1_lab-facebook
//
//  Created by Bobby Smith on 2/1/16.
//  Copyright © 2016 Bobby Smith. All rights reserved.
//

import UIKit

class UpdateStatusViewController: UIViewController {

    var imageView: UIImageView!
    var navView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // grab image
        imageView = UIImageView(image: UIImage(named: "create_status"))
        
        
        // create the button and add it to main view
        let backButton = UIButton(type: UIButtonType.System) as UIButton
        backButton.frame = CGRectMake(0, 0, 64, 64)
        backButton.backgroundColor = UIColor.clearColor()
        backButton.addTarget(self, action: Selector("backButtonClicked:"), forControlEvents: .TouchUpInside)
        
        
        // add the image to the scrollview
        view.addSubview(imageView)
        
        // add button to subview
        view.addSubview(backButton)
    
        
    }

    //        back button
    func backButtonClicked(sender: UIButton!) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
}
