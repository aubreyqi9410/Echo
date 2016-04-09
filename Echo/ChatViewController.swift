//
//  ChatViewController.swift
//  Echo
//
//  Created by Ying Qi on 4/4/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let progressView = CircularLoaderView(frame: CGRectMake(100, 100, 100, 100))
        //self.view.addSubview(progressView)
        //progressView.animateProgressView(10.0)
        
        let playBtn = PlayBtnView(frame: CGRectMake(100, 100, 100, 100), duration: 20)
        self.view.addSubview(playBtn)
        print("view loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
