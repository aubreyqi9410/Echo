//
//  LoginViewController.swift
//  Echo
//
//  Created by Ying Qi on 2/17/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    @IBAction func Login(sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        
    }
    
    
    


}
