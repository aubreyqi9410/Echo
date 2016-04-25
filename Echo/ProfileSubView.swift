//
//  ProfileSubView.swift
//  Echo
//
//  Created by Ying Qi on 4/24/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileSubView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var quoteTextField: UITextField?
    
    var playButton: PlayBtnView?
    
    var player: AVAudioPlayer?
    
    var data: Echo?
    
    var playerDelegate: AVAudioPlayerDelegate?
    
    var duration = 0.0
    
    init(frame: CGRect, data: Echo, playerDelegate: AVAudioPlayerDelegate){
        super.init(frame:frame)
        
        displayBackground()
        
        self.quoteTextField = UITextField()
        self.quoteTextField?.translatesAutoresizingMaskIntoConstraints = false
        
        self.data = data
        self.playerDelegate = playerDelegate
        
        loadContent()
        
        setUpAudio()
        displayPlayButton()
        displayTextField()
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func loadContent(){
        self.quoteTextField?.text = self.data?.location
        
        
    }
    
    func displayBackground(){
        self.backgroundColor = UIColor(patternImage: UIImage(named:"mountains")!)
    }
    
    func displayPlayButton(){
        let len = self.frame.width/6
        let size = CGSize(width: len, height: len)
        let origin = CGPoint(x: 10, y: 10)
        let frame: CGRect = CGRect(origin: origin, size: size)
        self.playButton = PlayBtnView(frame: frame, duration: duration)
        //playButton?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playButton!)
    }
    
    
    func displayTextField(){
        let originX = NSLayoutConstraint(item: self.quoteTextField!, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: .Equal, toItem: self.playButton, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant:  10)
        let originY = NSLayoutConstraint(item: self.quoteTextField!, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.playButton, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.quoteTextField!, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 4/6, constant: 0)
        let height = NSLayoutConstraint(item: self.quoteTextField!, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: -50)
        
        self.addSubview(self.quoteTextField!)
        self.addConstraint(originX)
        self.addConstraint(originY)
        self.addConstraint(width)
        self.addConstraint(height)
        
    }
    
    func playAudio(){
        player!.play()
    }
    

    
    func setUpAudio(){
        //TODO: Set as action for button touched
        do {
            player = try AVAudioPlayer(data: (self.data?.voiceData)!)
            player!.prepareToPlay()
            player!.volume = 1.0
            player!.delegate = self.playerDelegate
            duration = player!.duration
            
        } catch{
            print("Error getting audio file")
        }
    }

}
