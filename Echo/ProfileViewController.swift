//
//  ProfileViewController.swift
//  Echo
//
//  Created by Ying Qi on 4/24/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ProfileViewController: MainViewController, AVAudioPlayerDelegate {
    
    var ref = Firebase(url: "https://burning-fire-8901.firebaseio.com/voice")
    
    var myEcho = [Echo]()
    
    var bioView: ProfileBioView?
    
    let bioHeight = 100.0
    
    var profileScrollView: ProfileScrollView?


    override func viewDidLoad() {
        super.viewDidLoad()
        //super.style()
        loadData()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadData() {
        
        ref.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
            snapshot in
            if let userID = snapshot.value["user"] as? String {
                if (userID == self.ref.authData.uid) {
                    print(snapshot.value["quote"])
                    
                    let username = snapshot.value.objectForKey("user") as! String
                    let base64String = snapshot.value.objectForKey("voiceBase64") as! String
                    let quote = snapshot.value.objectForKey("quote") as! String
                    let decodeData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                    let echo = Echo(name: username, location: quote, voiceData: decodeData)
                    self.myEcho.append(echo)
                }
            }
            self.displayBio()
            self.displayData()
            }

        )
    }
    
    func displayBio(){
        let origin = CGPoint(x: 0, y: 0.15 * self.view.frame.height)
        let size = CGSize(width: self.view.frame.width, height: CGFloat(bioHeight))
        let e = myEcho[0]
        self.bioView = ProfileBioView(frame: CGRect(origin: origin, size: size), data: e, playerDelegate: self)
        self.view.addSubview(self.bioView!)
    }
    
    func displayData() {
        let origin = CGPoint(x: 0, y: (0.15 * Double(self.view.frame.height) + bioHeight))
        let height = (0.85 * Double(self.view.frame.height) - bioHeight)
        let width = self.view.frame.width
        self.profileScrollView = ProfileScrollView(frame: CGRect(origin: origin, size: CGSize(width: width, height: CGFloat(height))), data: myEcho)
        self.view.addSubview(self.profileScrollView!)
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
