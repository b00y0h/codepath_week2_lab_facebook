//
//  LoginViewController.swift
//  week2_lab-facebook
//
//  Created by Bobby Smith on 2/5/16.
//  Copyright © 2016 Bobby Smith. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var labelParentView: UIView!
    @IBOutlet weak var fbLogo: UIImageView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var initialY: CGFloat!
    var initialLabelY: CGFloat!
    var initialLogoY: CGFloat!
    var offset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.enabled = false
        spinner.hidden = true
        initialY = fieldParentView.frame.origin.y
        initialLabelY = labelParentView.frame.origin.y
        initialLogoY = fbLogo.frame.origin.y
        offset = -50

        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(dismiss)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)

    
    }
    
    @IBAction func checkIFEmpty(sender: AnyObject) {
        
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in

            self.signUpLabel.hidden = true
            self.fieldParentView.frame.origin.y = self.initialY + self.offset
            self.labelParentView.frame.origin.y = self.initialLabelY + self.offset - 190
            self.fbLogo.frame.origin.y = self.initialLogoY + self.offset + 20
            })
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.signUpLabel.hidden = false
        self.fieldParentView.frame.origin.y = self.initialY
        self.labelParentView.frame.origin.y = self.initialLabelY
        self.fbLogo.frame.origin.y = self.initialLogoY
    }
    
    func DismissKeyboard() {
        view.endEditing(true)
    }


    @IBAction func didPressLoginButton(sender: AnyObject) {
        spinner.hidden = false
        loginButton.enabled = false
        spinner.startAnimating()
        delay(1.5) { () -> () in
            self.validateCredentials()
            self.spinner.stopAnimating()
            self.loginButton.enabled = true
            self.spinner.hidden = true
        }

    }
    
    func validateCredentials() {
        if userNameTextField.text == "Adey" && passwordTextField.text == "rocks!" {
            performSegueWithIdentifier("loginSeque", sender: self)
        } else {
            showAlert()
        }
    }

    @IBAction func showAlert() {
        let alertController = UIAlertController(title: "Access Denied", message: "Wrong username or password", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            
        }
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    
}
