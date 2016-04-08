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
    let pauseImage: UIImage = UIImage(named: "pauseBtn")!
    
    var btnImageView: UIImageView?
    var progressView: CircularLoaderView?
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btnImageView = UIImageView(image: playImage)
        self.addSubview(btnImageView!)
        let gesture = UITapGestureRecognizer(target: self, action: "changeView:")
        
       
    }
    

    
    
    
    
    //let gesture = UITapGestureRecognizer(target: self, action: "changeView:")
    
    
    func changeView(){
        
        if (!isPlaying){
            isPlaying = true
            btnImageView?.removeFromSuperview()
            
            progressView = CircularLoaderView(frame: CGRectMake(100, 100, 100, 100))
            self.addSubview(progressView!)
            progressView!.animateProgressView(duration!)
            print("view loaded")
            
            
            
        } else {
            isPlaying = false
            
            
        }
        
    }

}
