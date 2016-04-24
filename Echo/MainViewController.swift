//
//  MainViewController.swift
//  Echo
//
//  Created by Ying Qi on 4/24/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let echoLblImageView = UIImageView(image: UIImage(named: "echo_logo"))
    
    let settingBtn = UIButton(type: .Custom)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.style()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Style
    
    func style(){
        print("calling style")
        
        self.view.backgroundColor = UIColor(red: 241/255, green: 89/255, blue: 90/255, alpha: 1)
        
        if let btnImage = UIImage(named: "setting_icon"){
            settingBtn.setImage(btnImage, forState: .Normal)
        }
        
        
        // Must be added first before binding constraints to it
        
        self.view.addSubview(self.echoLblImageView)
        self.view.addSubview(self.settingBtn)
        
        settingBtn.translatesAutoresizingMaskIntoConstraints = false
        echoLblImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsToEchoLabel()
        addConstraintsToSettingBtn()
        

        
        
    }
    
    // MARK: - Constraints
    func addConstraintsToSettingBtn(){
        print("----------------------------------------adding constraints")
        let centerX = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: -10)
        
        let centerY = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 50)
        
        let width = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.06, constant: 0)
        self.view.addConstraint(width)
        
        let height = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.settingBtn, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        self.view.addConstraint(height)
        
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)
        
    }
    
    func addConstraintsToEchoLabel(){
        let centerX = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerY = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 50)
        
        let width = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.35, constant: 0)
        
        let height = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.echoLblImageView, attribute: NSLayoutAttribute.Width, multiplier: 0.4, constant: 0)
        
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)
        self.view.addConstraint(width)
        self.view.addConstraint(height)
        
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
