//
//  UploadViewController.swift
//  Echo
//
//  Created by Ying Qi on 4/3/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController {
    
    var voiceData: NSData!

    @IBOutlet weak var quoteTextField: UITextView!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func shareEcho(sender: UIButton) {
        var myRootRef = Firebase(url: "https://burning-fire-8901.firebaseio.com")
        //myRootRef.setValue("Hi");
        
        let name = "test"
        
        
        let base64String = voiceData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let recording: NSDictionary = ["name": name, "quote": quoteTextField.text ,"voiceBase64":base64String]
        
        let voice = myRootRef.ref.childByAppendingPath(name)
        
        voice.setValue(recording)
    self.performSegueWithIdentifier("returnToExploreVC", sender: self)
           
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
            
            
    }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    

}
