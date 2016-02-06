//
//  RequestsViewController.swift
//  week1_lab-facebook
//
//  Created by Bobby Smith on 2/1/16.
//  Copyright © 2016 Bobby Smith. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var navView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // grab image
        imageView = UIImageView(image: UIImage(named: "people"))
        navView = UIImageView(image: UIImage(named: "nav"))
 
        imageView.frame = CGRect(x: 0, y: navView.frame.height - 20, width: imageView.frame.size.width, height: imageView.frame.size.height)

        
        // setup the scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = imageView.bounds.size
        
        
        // add the scrollview
        view.addSubview(scrollView)
        view.addSubview(navView)
        
        // add the image to the scrollview
        scrollView.addSubview(imageView)

    }
    
}
