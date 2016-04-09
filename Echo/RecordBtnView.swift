//
//  recordBtnView.swift
//  Echo
//
//  Created by Ying Qi on 4/8/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit

class RecordBtnView: UIView {
    
    enum State {
        case Ready
        case Recording
        case Done
        case Playing
    }
    
    var currentState = State.Ready
    
    let duration: Double = 45
    
    var voiceDuration: Double = 10 // will be changed
    
    var recordingImg: UIImage = UIImage()
    
    var playImg: UIImage = UIImage()
    
    var pauseImg: UIImage = UIImage()
    
    var recordingImgView: UIImageView?
    
    var playImgView: UIImageView?
    
    var pauseImageView: UIImageView?
    
    var progressView: CircularLoaderView?
    
    
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blueColor()
        
        // initialize Images and ImageViews
        recordingImg = UIImage(named: "recording")!
        recordingImgView = UIImageView(image: recordingImg)
        
        playImg = UIImage(named: "play")!
        playImgView = UIImageView(image: playImg)
        
        pauseImg = UIImage(named: "pause")!
        pauseImageView = UIImageView(image: pauseImg)
        
        addConstraints()
        
        // add touch gesture
        
        let gesture = UITapGestureRecognizer(target: self, action: "changeView:")
        gesture.addTarget(self, action: "changeView:")
        self.addGestureRecognizer(gesture)
        self.userInteractionEnabled = true
    
        
        
        // set up initial state
        self.addSubview(recordingImgView!)
        progressView = CircularLoaderView(frame: self.frame, createPauseBtn: false)
        self.addSubview(progressView!)
        
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func changeView(sender: UIGestureRecognizer? = nil){
        addConstraints()
        
        switch currentState {
        case .Ready:
            self.progressView?.animateProgressView(duration)
            currentState = .Recording
            break
            
        case .Recording:
            self.recordingImgView?.removeFromSuperview()
            self.addSubview(self.playImgView!)
            currentState = .Done
            break
        case .Playing:
            self.pauseImageView?.removeFromSuperview()
            self.addSubview(playImgView!)
            currentState = .Done
            break
            
        case.Done:
            self.playImgView?.removeFromSuperview()
            self.addSubview(pauseImageView!)
            currentState = .Playing
            break
            
        default:
            break
            
        }
        
    }
    
    func addConstraints(){
        let origin = self.frame.origin
        let center = CGPointMake(self.frame.width/2, self.frame.height/2 )
        
        print("origin: ", origin.x,  " ", origin.y)
        
        print("center: ", center.x,  " ", center.y)
        let itemFrame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        
        let innerFrame = CGRectMake(0.3*self.frame.width, 0.3*self.frame.height, 0.5*self.frame.width, 0.5*self.frame.height)
        
        self.recordingImgView!.center = center
        self.recordingImgView?.frame = innerFrame
        print("center: ", recordingImgView?.center.x,  " ", recordingImgView?.center.y)
        
        
        self.playImgView?.center = center
        self.playImgView?.frame = innerFrame
        self.pauseImageView?.center = center
        // self.pauseImageView?.frame = itemFrame
        
        self.progressView?.center = center
        //self.progressView?.frame = itemFrame
    }
    
    func setRecordedVoiceDuration(duration: Double){
        self.voiceDuration = duration
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
