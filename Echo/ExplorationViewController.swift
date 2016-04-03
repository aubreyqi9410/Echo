//
//  ExplorationViewController.swift
//  Echo
//
//  Created by Ying Qi on 3/29/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit

class ExplorationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    struct Echo {
        var name: String
        var location: String
    }
    
    var tableData: [Echo] = []

    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var echoLblImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraintsForEchoLbl()
        addConstraintsForSettingsBtn()
        tableData = [
            Echo(name: "test", location: "test"),
            Echo(name: "test", location: "test")

        ]
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("echoCell") as! EchoFeedTableViewCell
        
        cell.nameLbl.text = "test"
        cell.locationLbl.text = "test"
    
        return cell;
    }
    
    func addConstraintsForEchoLbl(){
        
        let centerX = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerY = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 50)
        
        let width = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.25, constant: 0)
        
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)
        self.view.addConstraint(width)
        
    }
    
    func addConstraintsForSettingsBtn(){
        let centerX = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: -20)
        
        let centerY = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 50)
        
        let width = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.1, constant: 0)
        
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)
        self.view.addConstraint(width)
        
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
