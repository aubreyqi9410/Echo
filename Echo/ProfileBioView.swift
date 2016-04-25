
//
//  ProfileBioView.swift
//  Echo
//
//  Created by Ying Qi on 4/24/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileBioView: ProfileSubView{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect, data: Echo, playerDelegate: AVAudioPlayerDelegate) {
        super.init(frame: frame, data: data, playerDelegate: playerDelegate)
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
