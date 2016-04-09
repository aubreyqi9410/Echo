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
    let pauseImage: UIImage = UIImage(named: "pause")!
    
    var playImageView: UIImageView?
    var pauseImageView: UIImageView?
    var progressView: CircularLoaderView?
    
   // var gestureDelegate: UIViewController?
    
    init(frame: CGRect, duration: Double){
        super.init(frame: frame)
        self.duration = duration
        playImageView = UIImageView(image: playImage)
        pauseImageView = UIImageView(image: pauseImage)
        
        self.addSubview(playImageView!)
        
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
            //btnImageView? = UIImageView(image: pauseImage)
            playImageView?.removeFromSuperview()
            self.addSubview(pauseImageView!)
            print("2")
            let myColor  = UIColor(red: 194.0/255.0, green: 230.0/255.0, blue: 237.0/255.0, alpha: 1.0)
            progressView = CircularLoaderView(frame: self.frame, color: myColor)
            self.addConstraints()
            self.addSubview(progressView!)
            progressView!.animateProgressView(duration!)
            print("view loaded")
            
            
            
        } else {
            // playing -> not playing
            print("3")
            isPlaying = false
            pauseImageView?.removeFromSuperview()
            self.addSubview(playImageView!)

            progressView?.removeFromSuperview()
            print("4")
            self.addConstraints()
            
        }
        
    }
    
    // Mark: Add Constraints
    func addConstraints(){
        let center = CGPointMake(self.frame.width/2, self.frame.height/2)
        let innerframe = CGRectMake(0.3*self.frame.width, 0.3*self.frame.height, 0.35*self.frame.width, 0.35*self.frame.height)
        
        
        self.pauseImageView?.frame = innerframe
        self.pauseImageView?.center = center
        
        
        self.playImageView?.frame = innerframe
        self.playImageView?.center = center
        
        self.progressView?.center = center
        //self.progressView?.frame = innerframe
    }

}
