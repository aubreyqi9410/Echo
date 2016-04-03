//
//  EchoFeedTableViewCell.swift
//  Echo
//
//  Created by Ying Qi on 4/2/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit
import AVFoundation

class EchoFeedTableViewCell: UITableViewCell, AVAudioPlayerDelegate  {

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var quoteLbl: UILabel!
    
    
    var player: AVAudioPlayer!
    var voiceData: NSData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addConstraintsForPlayBtn()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func playEcho(sender: UIButton) {
        
        do {
            // var player = AVAudioPlayer()
            player = try AVAudioPlayer(data: self.voiceData)
            player.prepareToPlay()
            player.volume = 1.0
            player.delegate = self
            player.play()
            
            
            
        } catch {
            print ("Error getting the audio file")
        }

        
        
    }
    
    /* Constraints for UI Elements */
    
    func addConstraintsForPlayBtn(){
        let centerX = NSLayoutConstraint(item: self.playBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.LeftMargin, multiplier: 1, constant: 40)
        
        let centerY = NSLayoutConstraint(item: self.playBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 40)
        
        let width = NSLayoutConstraint(item: self.playBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.viewForFirstBaselineLayout, attribute: NSLayoutAttribute.Width, multiplier: 0.1, constant: 0)
        
        self.viewForFirstBaselineLayout.addConstraint(centerX)
        self.viewForFirstBaselineLayout.addConstraint(centerY)
        
        self.viewForFirstBaselineLayout.addConstraint(width)

    }
    
    func addConstraintsForNameLbl () {
    
    }
    
    
    func addConstraintsForLocationLbl() {
        
    }
    
    func addConstraintForQuoteLbl() {
        
    }
}
