//
//  FeedDetailViewController.swift
//  week1_lab-facebook
//
//  Created by Bobby Smith on 1/29/16.
//  Copyright © 2016 Bobby Smith. All rights reserved.
//

import UIKit


class FeedDetailViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var imageComment: UIImageView!
    var imageNavBack: UIImageView!
    var commentTextField: UITextField!
    var commentTextFieldTwo: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(dismiss)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)

        
        
        // grab image
        imageView = UIImageView(image: UIImage(named: "thrillist_detail"))
        imageComment = UIImageView(image: UIImage(named: "comment_bar"))
        imageNavBack = UIImageView(image: UIImage(named: "nav_back"))

//        position images
        imageComment.frame = CGRectMake(1, 477, 320, 44)

        imageView.frame = CGRect(x: 0, y: imageNavBack.frame.height - 20, width: imageView.frame.size.width, height: imageView.frame.size.height)

        
        // setup the scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = imageView.bounds.size
        
        
        // add the scrollview
        
        // add the images to the view and scrollview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)

        view.addSubview(imageComment)
        view.addSubview(imageNavBack)
        

        
//        create the text field
        commentTextField = UITextField(frame: CGRectMake(40, 483, 217, 33))
        commentTextField.placeholder = "Write a comments..."
        commentTextField.font = UIFont.systemFontOfSize(15)
        commentTextField.borderStyle = UITextBorderStyle.RoundedRect
        commentTextField.backgroundColor = UIColor.whiteColor()
        
//        add it to main view
        view.addSubview(commentTextField)

        
        // create the button and add it to main view
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, 46, 64)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: Selector("back:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)

        
        // create the like button and add it to main view
        let likebutton = UIButton(type: .Custom)
        likebutton.setTitle("Like", forState: .Normal)
        likebutton.titleLabel!.font = UIFont.systemFontOfSize(13, weight: UIFontWeightSemibold)
        
        if let btn_image = UIImage(named: "like_btn") {
            likebutton.setImage(btn_image, forState: .Normal)
        }
        if let btn_image_selected = UIImage(named: "like_btn_selected") {
            likebutton.setImage(btn_image_selected, forState: .Selected)
        }
        
        likebutton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        likebutton.setTitleColor(UIColor(netHex: 0x227FBB), forState: .Selected)


        likebutton.frame = CGRectMake(38, 402, 52, 40)

        likebutton.addTarget(self, action: Selector("likeButton:"), forControlEvents: UIControlEvents.TouchUpInside)

        scrollView.addSubview(likebutton)
        
        
        // create the button and add it to main view
        let commentButton = UIButton(type: UIButtonType.System) as UIButton
        commentButton.backgroundColor = UIColor.clearColor()
        commentButton.frame = CGRectMake(100, 402, 110, 40)
        
        commentButton.addTarget(self, action: Selector("commentButtonClicked"), forControlEvents: UIControlEvents.TouchUpInside)

        
        scrollView.addSubview(commentButton)



    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        if keyboardSize.height == offset.height {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
//                start moving stuff
                self.commentTextField.frame.origin.y -= keyboardSize.height - 48
                self.imageComment.frame.origin.y -= keyboardSize.height - 48
            })
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.commentTextField.frame.origin.y += keyboardSize.height - offset.height
                self.imageComment.frame.origin.y += keyboardSize.height - offset.height
            })
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
//                start moving stuff back
        self.commentTextField.frame.origin.y += keyboardSize.height - 48
        self.imageComment.frame.origin.y += keyboardSize.height - 48
    }
    
    func DismissKeyboard() {
        view.endEditing(true)
    }
    
    func back(sender: UIButton!) {
        navigationController?.popViewControllerAnimated(true)
    }

//    set like button
    func likeButton(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    func commentButtonClicked() {
        commentTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
