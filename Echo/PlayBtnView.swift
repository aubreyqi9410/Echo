//
//  PlayBtnView.swift
//  Echo
//
//  Created by Ying Qi on 4/4/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit

class PlayBtnView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var isPlaying: Bool = false
    
    var duration: Double?
    
    
    let playImage: UIImage = UIImage(named: "playBtn")!
    
    var btnImageView: UIImageView?
    var progressView: CircularLoaderView?
    
   // var gestureDelegate: UIViewController?
    
    init(frame: CGRect, duration: Double){
        super.init(frame: frame)
        self.duration = duration
        btnImageView = UIImageView(image: playImage)
        self.addSubview(btnImageView!)
        
        let gesture = UITapGestureRecognizer(target: self, action: "changeView:")
        addConstraints()
        gesture.addTarget(self, action: "changeView:")
        self.addGestureRecognizer(gesture)
        self.userInteractionEnabled = true
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func changeView(sender: UIGestureRecognizer? = nil){
        print("0")
        
        if (!isPlaying){
            // not playing -> playing
            print("1")
            isPlaying = true
            btnImageView?.removeFromSuperview()
            print("2")
            progressView = CircularLoaderView(frame: self.frame, createPauseBtn: true)
            self.addConstraints()
            self.addSubview(progressView!)
            progressView!.animateProgressView(duration!)
            print("view loaded")
            
            
            
        } else {
            // playing -> not playing
            print("3")
            isPlaying = false
            progressView?.removeFromSuperview()
            print("4")
            self.addConstraints()
            self.addSubview(btnImageView!) 
            
        }
        
    }
    
    // Mark: Add Constraints
    func addConstraints(){
        self.btnImageView?.center = CGPointMake(self.frame.width/2, self.frame.height/2)
        self.progressView?.center = CGPointMake(self.frame.width/2, self.frame.height/2)
    }

}
