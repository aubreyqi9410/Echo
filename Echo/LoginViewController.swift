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
    @IBOutlet weak var createNewLogin: UIButton!
    
    let ref = Firebase(url: "https://burning-fire-8901.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture recognizer to show intro screen
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        recognizer.direction = .Left
        self.view.addGestureRecognizer(recognizer)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    @IBAction func createNewAccount(sender: UIButton) {
       self.performSegueWithIdentifier("showCreateNewAccountPage", sender: self)
        
    }
    
    @IBAction func Login(sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        ref.authUser(email, password: password,
            withCompletionBlock: {
                error, authData in
                if error != nil{
                    print("segue")
                    self.performSegueWithIdentifier("showExplorationPage", sender: self)
                    
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
    
    
    


}
