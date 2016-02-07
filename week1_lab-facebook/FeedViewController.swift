//
//  FeedViewController.swift
//  week1_lab-facebook
//
//  Created by Bobby Smith on 1/29/16.
//  Copyright © 2016 Bobby Smith. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate {

    var numberOfImageViews: CGFloat = 1
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var navView: UIImageView!
    var composeView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var infiniteLoadingIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl! = UIRefreshControl()

    override func viewWillAppear(animated: Bool) {
        scrollView.hidden = true
        spinner.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        // Delay for 2 seconds before...
        delay(1) { () -> () in
            self.scrollView.hidden = false
            self.spinner.stopAnimating()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refresh
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: .ValueChanged)
        
        
        // grab image
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.objectForKey("user") as! String
        
        // if the key returns "new user", then...
        if user == "new user" {
            imageView = UIImageView(image: UIImage(named: "empty_feed"))
        } else {
            imageView = UIImageView(image: UIImage(named: "home_feed"))
        }
        
//        imageView = UIImageView(image: UIImage(named: "home_feed"))
        navView = UIImageView(image: UIImage(named: "nav"))
        composeView = UIImageView(image: UIImage(named: "compose"))
    

        imageView.frame = CGRect(x: 0, y: navView.frame.height + composeView.frame.height, width: imageView.frame.size.width, height: imageView.frame.size.height)
        composeView.frame = CGRect(x:0, y: navView.frame.height, width: composeView.frame.size.width, height: composeView.frame.size.height)
        
        // setup the scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = imageView.bounds.size

        scrollView.contentInset.bottom = 130

        // add the scrollview
        view.addSubview(scrollView)
        view.addSubview(navView)

        // add images to the scrollview
        scrollView.addSubview(imageView)
        scrollView.addSubview(composeView)
        
        scrollView.addSubview(refreshControl)
     
        infiniteLoadingIndicator.center.y = imageView.bounds.height + 20

        // create the button and add it to scrollview
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(10, 230, 300, 370)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: Selector("detailsBtnClicked:"), forControlEvents: .TouchUpInside)
        scrollView.addSubview(button)
        
        // create the status/photo/checking buttons and add them to scrollview
        let statusButton = UIButton(type: UIButtonType.System) as UIButton
        statusButton.frame = CGRectMake(0, navView.frame.height - 20, 212/2, 92/2)
        statusButton.backgroundColor = UIColor.clearColor()
        statusButton.addTarget(self, action: Selector("statusBtnClicked:"), forControlEvents: .TouchUpInside)
        scrollView.addSubview(statusButton)

        let photoButton = UIButton(type: UIButtonType.System) as UIButton
        photoButton.frame = CGRectMake(statusButton.frame.width, navView.frame.height - 20, 212/2, 92/2)
        photoButton.backgroundColor = UIColor.clearColor()
        photoButton.addTarget(self, action: Selector("photoBtnClicked"), forControlEvents: .TouchUpInside)
        scrollView.addSubview(photoButton)

        
        let checkinButton = UIButton(type: UIButtonType.System) as UIButton
        checkinButton.frame = CGRectMake(statusButton.frame.width + photoButton.frame.width, navView.frame.height - 20, 212/2, 92/2)
        checkinButton.backgroundColor = UIColor.clearColor()
        checkinButton.addTarget(self, action: Selector("checkinBtnClicked:"), forControlEvents: .TouchUpInside)
        scrollView.addSubview(checkinButton)

        scrollView.delegate = self

        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
    }
    
    // The scrollView has come to a complete stop, so do the following...
    func scrollViewDidEndDecelerating(feedScrollView: UIScrollView) {
        print("Scrolling Stopped")
        // If the scrollView offset + the scrollview height is greater than or equal to the height of the scrollView content,
        // We have reached the bottom, so...
        if feedScrollView.contentOffset.y + feedScrollView.frame.size.height >= feedScrollView.contentSize.height {
            print("You reached the bottom")
            // Delay for 1 second then...
            delay(1, closure: { () -> () in
                // Create frame for new imageView, same as feed ImageView
                let newFrame = self.imageView.frame
                // Create new ImageView with newFrame
                let newImageView = UIImageView(frame: newFrame)
                // Create new image, same as feed Image
                let newImage = UIImage(named: "home_feed")
                // Set new ImageView image to newImage
                newImageView.image = newImage
                // Position the new imageView below the previous image view
                newImageView.frame.origin.y = self.imageView.frame.origin.y + self.numberOfImageViews * self.imageView.frame.size.height
                // Add imageView to scrollView
                feedScrollView.addSubview(newImageView)
                // Move Activity Indicator down below new ImageView
                self.infiniteLoadingIndicator.center.y = self.imageView.image!.size.height + 20 + self.numberOfImageViews * newImageView.image!.size.height
                // Increase the feedScrollView contentSize with each additional imageView added using
                feedScrollView.contentSize = CGSize(width: self.imageView.frame.size.width,
                    height: self.imageView.frame.size.height + self.numberOfImageViews * newImageView.frame.size.height)
                // add 1 to scrollViewCount
                self.numberOfImageViews += 1
            })
        }
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }

    func detailsBtnClicked(sender: UIButton!) {
        performSegueWithIdentifier("detailView", sender: self)
    }
    
    func statusBtnClicked(sender: UIButton!) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("statusVC")
        self.presentViewController(controller, animated: true, completion: nil)
    }

    func checkinBtnClicked(sender: UIButton!) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("checkinVC")
        self.presentViewController(controller, animated: true, completion: nil)
    }

    
    
    func photoBtnClicked() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        // do something interesting here!
        print(newImage.size)
        
        dismissViewControllerAnimated(true, completion: nil)
    }


}
