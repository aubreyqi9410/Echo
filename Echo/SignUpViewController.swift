//
//  SignUpViewController.swift
//  Echo
//
//  Created by Ying Qi on 3/29/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var createBtn: UIButton!
    
    let ref = Firebase(url: "https://burning-fire-8901.firebaseio.com")

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.addConstraintsForUsernameTxt()
        self.addConstraintsForPasswordTxt()
        self.addConstraintsForCreateBtn()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: UIButton) {
        
        print("hello")
        
        self.ref.createUser(username.text, password: password.text) { (error: NSError!) in
            if error == nil {
                self.ref.authUser(self.username.text, password: self.password.text, withCompletionBlock: {
                    (error, auth) -> Void in
                    
                    self.performSegueWithIdentifier("showExplorationForNewUser", sender: self)
                    
                    
                    
                })
            } else {
                print("failed to create new user")
            }
            
            }
        
    

    
//        self.ref.createUser("hello", password: "hello",
//            withValueCompletionBlock: { (error: NSError!) in
//                
//                if error != nil {
//                    // There was an error creating the account
//       
//       
//                    
//                } else {
//                    //let uid = result["uid"] as? String
//                    print("Successfully created user account with uid: \(uid)")
//                }
//        })
    
    }
    
    // Mark: - Adding Constraints
    
    func addConstraintsForUsernameTxt(){
        
        let centerX = NSLayoutConstraint(item: self.username, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.username, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.7, constant: 0)
        let topY = NSLayoutConstraint(item: self.username, attribute: .TopMargin, relatedBy: .Equal, toItem: self.view, attribute: .TopMargin, multiplier: 1, constant: 50)
        self.username.layer.cornerRadius = 15
        
        self.view.addConstraint(topY)
        self.view.addConstraint(centerX)
        self.view.addConstraint(width)
        
    }
    
    func addConstraintsForPasswordTxt(){
        let centerX = NSLayoutConstraint(item: self.password, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.password, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.7, constant: 0)
        let topY = NSLayoutConstraint(item: self.password, attribute: .TopMargin, relatedBy: .Equal, toItem: self.username, attribute: .BottomMargin, multiplier: 1, constant: 30)
        self.password.layer.cornerRadius = 15
        self.view.addConstraint(centerX)
        self.view.addConstraint(width)
        self.view.addConstraint(topY)
        
    }
    
    func addConstraintsForCreateBtn(){
        let centerX = NSLayoutConstraint(item: self.createBtn, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.createBtn, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.7, constant: 0)
        let topY = NSLayoutConstraint(item: self.createBtn, attribute: .TopMargin, relatedBy: .Equal, toItem: self.password, attribute: .BottomMargin, multiplier: 1, constant: 30)
        self.createBtn.layer.cornerRadius = 15
        self.view.addConstraint(centerX)
        self.view.addConstraint(width)
        self.view.addConstraint(topY)

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

