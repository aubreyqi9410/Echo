//
//  ProfileScrollView.swift
//  Echo
//
//  Created by Ying Qi on 4/24/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileScrollView: UIScrollView, AVAudioPlayerDelegate  {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var myData = [Echo]()
    
    
    init(frame: CGRect, data: [Echo]){
        super.init(frame: frame)
        myData = data
        self.backgroundColor = UIColor.whiteColor()
        displayData()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func displayData(){
        let height = self.frame.height/6
        let width = self.frame.width - 40
        let size = CGSize(width: width, height: height)
        var origin = CGPoint(x: 20, y: 20)
        let increment = height + 20
        
        for e in myData {
            let subView = ProfileSubView(frame: CGRect(origin: origin, size: size), data: e, playerDelegate: self)
            self.addSubview(subView)
            origin.y += increment
        }
        
    }
    
    
    

}
