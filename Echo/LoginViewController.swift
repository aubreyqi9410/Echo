//
//  LoginViewController.swift
//  Echo
//
//  Created by Ying Qi on 2/17/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import Firebase



class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createNewLoginBtn: UIButton!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    
    let ref = Firebase(url: "https://burning-fire-8901.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addConstraintsForEmailTxt()
        
        addConstraintsForLoginBtn()
        
        addConstraintsForNewAccountBtn()
        
        addConstraintsForPasswordTxt()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"loginscreen_background")!)
        
        // Gesture recognizer to show intro screen
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        recognizer.direction = .Left
        self.view.addGestureRecognizer(recognizer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    @IBAction func createNewAccount(sender: UIButton) {
       self.performSegueWithIdentifier("showCreateNewAccountPage", sender: self)
        
    }
    
    @IBAction func Login(sender: UIButton) {
        //todo: user validation segue not working
        
        let email = emailTextField.text
        let password = passwordTextField.text
        ref.authUser(email, password: password,
            withCompletionBlock: {
                error, authData in
                if error != nil{
                    print("no segue")
                   // self.performSegueWithIdentifier("showExplorationPage", sender: self)
                    
                } else {
                    print("segue")
                    self.performSegueWithIdentifier("showExplorationPage", sender: self)

                }
                
        })

  }
    
    func swipeLeft(recognizer: UISwipeGestureRecognizer){
 
        self.performSegueWithIdentifier("showInfoPage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepare")
        if (segue.identifier == "showExplorationPage") {
            print("here")

            
            let barViewControllers = segue.destinationViewController as! UITabBarController
            let destinationViewController = barViewControllers.viewControllers![1] as! RecordViewController
        }
    }
    
    /* Register Keyboard */
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -200
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }

    
    /* Constraints for UI Elements */
    
    func addConstraintsForEmailTxt(){
        // emailTextField
        let centerX = NSLayoutConstraint(item: self.emailTextField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerY = NSLayoutConstraint(item: self.emailTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.5, constant: 0)
        let width = NSLayoutConstraint(item: self.emailTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.75, constant: 0)
        
        
        self.view.addConstraint(width)
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)
        
    }
    
    func addConstraintsForPasswordTxt(){
        
        let centerX = NSLayoutConstraint(item: self.passwordTextField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerY = NSLayoutConstraint(item: self.passwordTextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.emailTextField, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 30)
        
        let width = NSLayoutConstraint(item: self.passwordTextField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.75, constant: 0)
        
        self.view.addConstraint(width)
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)

        
    }
    
    func addConstraintsForLoginBtn(){
        // login
        let centerX = NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.passwordTextField, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 30)
        let width = NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.75, constant: 0)

        self.view.addConstraint(width);
        self.view.addConstraint(centerX);
        self.view.addConstraint(centerY);
        
        
    }
    
    func addConstraintsForNewAccountBtn() {
        let centerX = NSLayoutConstraint(item: createNewLoginBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: createNewLoginBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: -20)
      
        self.view.addConstraint(centerX);
        self.view.addConstraint(centerY);
    }
    

    
    
    


}
