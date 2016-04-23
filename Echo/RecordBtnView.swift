//
//  recordBtnView.swift
//  Echo
//
//  Created by Ying Qi on 4/8/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit

class RecordBtnView: UIView {
    
    
    var currentState = ButtonState.Ready
    
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
        
        // initialize Images and ImageViews
        recordingImg = UIImage(named: "recording")!
        recordingImgView = UIImageView(image: recordingImg)
        
        playImg = UIImage(named: "play")!
        playImgView = UIImageView(image: playImg)
        
        pauseImg = UIImage(named: "pauseBtn")!
        pauseImageView = UIImageView(image: pauseImg)
        
        addConstraints()

        self.userInteractionEnabled = true
    
        
        
        // set up initial state
        self.addSubview(recordingImgView!)
        let color = UIColor(red: 241/255, green: 89/255, blue: 90/255, alpha: 1.0)
        progressView = CircularLoaderView(frame: self.frame, color: color)
        self.addSubview(progressView!)
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func beginRecording(){
        addConstraints()
        self.progressView?.animateProgressView(duration)
        currentState = .Recording
        
    }
    
    func stopRecording(){
        addConstraints()
        self.recordingImgView?.removeFromSuperview()
        self.addSubview(self.playImgView!)
        self.progressView?.stopAnimation()
        currentState = .Done
        
    }
    
    func stopPlaying(){
        addConstraints()
        self.pauseImageView?.removeFromSuperview()
        self.recordingImgView?.removeFromSuperview()
        self.addSubview(playImgView!)
        self.progressView?.stopAnimation()
        
        currentState = .Done
        
    }
    
    func play(){
        addConstraints()
        self.playImgView?.removeFromSuperview()
        self.recordingImgView?.removeFromSuperview()
        self.addSubview(pauseImageView!)
        self.progressView?.animateProgressView(self.voiceDuration)
        currentState = .Playing
        
        
    }
    
    func recordAgain(){
        addConstraints()
        self.progressView?.stopAnimation()
        self.playImgView?.removeFromSuperview()
        self.pauseImageView?.removeFromSuperview()
        //self.recordingImgView?.removeFromSuperview()
        self.addSubview(recordingImgView!)
        currentState = .Ready
        
    }

    

    
    func addConstraints(){
        let origin = self.frame.origin
        let center = CGPointMake(self.frame.width/2, self.frame.height/2 )
        
        print("origin: ", origin.x,  " ", origin.y)
        
        print("center: ", center.x,  " ", center.y)
        let itemFrame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        
        let innerFrame = CGRectMake(0.3*self.frame.width, 0.3*self.frame.height, 0.35*self.frame.width, 0.35*self.frame.height)
        
 
        
        
        self.recordingImgView?.frame = innerFrame
        self.recordingImgView!.center = center
        print("center: ", recordingImgView?.center.x,  " ", recordingImgView?.center.y)
        
        
       
        self.playImgView?.frame = innerFrame
        self.playImgView?.center = center
        self.playImgView?.center.x += 5
        
        self.pauseImageView?.frame = innerFrame
        self.pauseImageView?.center = center
        
        self.progressView?.center = center
        self.progressView?.frame = itemFrame

        
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
