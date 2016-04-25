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
    
    
    var tableData: [Echo] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var echoLblImageView: UIImageView!
    
    var ref = Firebase(url: "https://burning-fire-8901.firebaseio.com/voice")
    
    
    
    override func viewDidLoad() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .None
        
        super.viewDidLoad()
        loadData()
        self.tableView.reloadData()
        addConstraintsForEchoLbl()
        addConstraintsForSettingsBtn()
        addConstraintsForTableView()

        

        // Do any additional setup after loading the view.
    }
 
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
   
    func loadData(){
        

       
        
        
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            //print("value: " , snapshot.value)

            for rest in snapshot.children.allObjects as! [FDataSnapshot]{
                print("loading echo")
                
                let username = rest.value.objectForKey("user") as! String
                let base64String = rest.value.objectForKey("voiceBase64") as! String
                let quote = rest.value.objectForKey("quote") as! String
                let decodeData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                let echo = Echo(name: username, location: quote, voiceData: decodeData)
                
                self.tableData.append(echo)
                print("data appended")
                self.tableView.reloadData()
                
                
                
            }
            
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(tableData.count)
        return tableData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       // let cell = tableView.dequeueReusableCellWithIdentifier("echoCell") as! EchoFeedTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("echoCell", forIndexPath: indexPath) as! EchoFeedTableViewCell
        print("row: ", indexPath.row)
        
        cell.nameLbl.text = self.tableData[indexPath.row].name
        cell.locationLbl.text = self.tableData[indexPath.row].location
        cell.voiceData = self.tableData[indexPath.row].voiceData
        return cell;
    }
    
    func addConstraintsForTableView(){
        
        let height = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 0.85, constant: 0)
        
        let bottomY = NSLayoutConstraint(item: self.tableView, attribute: .BottomMargin, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: .BottomMargin, multiplier: 1, constant: 0)
        self.view.addConstraint(height)
        self.view.addConstraint(bottomY)
        
    }
    
    func addConstraintsForEchoLbl(){
        
        let centerX = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let centerY = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 50)
        
        let width = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.35, constant: 0)
        
        let height = NSLayoutConstraint(item: self.echoLblImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.echoLblImageView, attribute: NSLayoutAttribute.Width, multiplier: 0.4, constant: 0)
        
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)
        self.view.addConstraint(width)
        self.view.addConstraint(height)
        
    }
    
    func addConstraintsForSettingsBtn(){
        let centerX = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: -10)
        
        let centerY = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 50)
        
        let width = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0.06, constant: 0)
        self.view.addConstraint(width)
        
        let height = NSLayoutConstraint(item: self.settingBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.settingBtn, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        self.view.addConstraint(height)
        
        self.view.addConstraint(centerX)
        self.view.addConstraint(centerY)
        
        
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
