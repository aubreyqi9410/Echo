//
//  ExplorationViewController.swift
//  Echo
//
//  Created by Ying Qi on 3/29/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import Firebase

class ExplorationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    struct Echo {
        var name: String!
        var location: String!
        var voiceData: NSData!
    }
    
    var tableData: [Echo] = []

    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var echoLblImageView: UIImageView!
    
    var ref = Firebase(url: "https://burning-fire-8901.firebaseio.com/test")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraintsForEchoLbl()
        addConstraintsForSettingsBtn()
        
        ref.observeEventType(.Value, withBlock: { snapshot in
                let name = snapshot.value.objectForKey("name") as! String
                let base64String = snapshot.value.objectForKey("voiceBase64")
                let quote = snapshot.value.objectForKey("quote")
                let decodeData = NSData(base64EncodedString: snapshot.value as! String, options: NSDataBase64DecodingOptions())
                let echo = Echo(name: name, location: "here", voiceData: decodeData)
                self.tableData.append(echo)
            
            
            })
        

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
        cell.voiceData = self.tableData.first?.voiceData
    
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
