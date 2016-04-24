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
    
    @IBOutlet weak var topLabel: UIView!
    
    @IBOutlet weak var numCharRemainingLabel: UILabel!
    
    @IBOutlet weak var quoteTextField: UITextView!
    
    @IBOutlet weak var addQuoteLabel: UIImageView!
    
    var voiceData: NSData!
    
    var voiceUID: String!

    
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleShareButton()
        self.addConstraintsToCharRemainingLabel()
        self.addConstraintsToQuoteBox()
        self.addConstraintsToTopLabel()
        self.addConstraintsToAddQuoteLabel()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func shareEcho(sender: UIButton) {
        let myRootRef = Firebase(url: "https://burning-fire-8901.firebaseio.com")
        let voiceRef = Firebase(url: "https://burning-fire-8901.firebaseio.com/voice")

        //myRootRef.setValue("Hi");
        
        let base64String = voiceData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmm"
        let uploadTime = formatter.stringFromDate(currentDateTime)
        
        let recording: NSDictionary = ["user": myRootRef.authData.uid,
                                       "quote": quoteTextField.text ,
                                       "voiceBase64":base64String,
                                       "location": "Durham, NC",
                                       "time": uploadTime,
                                       "tags": "",
                                       "likes": "",
                                       "replies": ""]
        
        let voice = voiceRef.childByAutoId()
        
        voice.setValue(recording)
        self.performSegueWithIdentifier("returnToExploreVC", sender: self)
           
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
            
       
    }
    
    //MARK: - Constraints
    
    func styleShareButton(){
        self.shareBtn.backgroundColor = UIColor(red: 241/255, green: 90/255, blue: 90/255, alpha: 1)
        self.shareBtn.tintColor = UIColor.whiteColor()
        self.shareBtn.layer.cornerRadius = 20
        let width = NSLayoutConstraint(item: self.shareBtn, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.3, constant: 0)
        self.view.addConstraint(width)
    }
    
    func addConstraintsToTopLabel(){
        let heightFraction:CGFloat = 1/6
        let top = NSLayoutConstraint(item: self.topLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self.topLabel, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: heightFraction, constant: 0)
        
        self.view.addConstraint(top)
        self.view.addConstraint(height)
    }
    
    func addConstraintsToQuoteBox(){
        self.quoteTextField.backgroundColor = UIColor.whiteColor()
        let heightFraction:CGFloat = 3/6
        let height = NSLayoutConstraint(item: self.quoteTextField, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: heightFraction, constant: 0)
        let top = NSLayoutConstraint(item: self.quoteTextField, attribute: .Top, relatedBy: .Equal, toItem: self.topLabel, attribute: .Bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(top)
        self.view.addConstraint(height)
        
    }
    func addConstraintsToAddQuoteLabel(){
        let width = NSLayoutConstraint(item: self.addQuoteLabel, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.4, constant: 0)
        let height = NSLayoutConstraint(item: self.addQuoteLabel, attribute: .Height, relatedBy: .Equal, toItem: self.topLabel, attribute: .Height , multiplier: 0.15, constant: 0)
        self.view.addConstraint(width)
        self.view.addConstraint(height)
    }
    
    func addConstraintsToCharRemainingLabel(){
        
    }
    
    
    
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    

}
