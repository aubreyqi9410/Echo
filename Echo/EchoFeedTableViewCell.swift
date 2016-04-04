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
    @IBOutlet weak var echoLabelView: EchoLabelView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var player: AVAudioPlayer!
    var voiceData: NSData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //bottomLblView = EchoLabelView(width: self.frame.width, height: self.frame.height)
        //self.addSubview(bottomLblView)
        addConstraintsForBottomLbl()
        
        addConstraintsForPlayBtn()
        addConstraintsForNameLbl ()
        addConstraintsForLocationLbl()
        addConstraintForQuoteLbl()
        addConstraintsForNextBtn()
        
        echoLabelView.addConstraints()
        
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
    
    func addConstraintsForBottomLbl(){
        
        let centerX = NSLayoutConstraint(item: self.echoLabelView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        let bottomY = NSLayoutConstraint(item: self.echoLabelView, attribute: NSLayoutAttribute.BottomMargin, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 0)
        
        let width = NSLayoutConstraint(item: self.echoLabelView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1 , constant: 0)
        
        let height = NSLayoutConstraint(item: self.echoLabelView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.2 , constant: 0)
        self.viewForFirstBaselineLayout.addConstraint(centerX)
        self.viewForFirstBaselineLayout.addConstraint(bottomY)
        
        self.viewForFirstBaselineLayout.addConstraint(width)
        self.viewForFirstBaselineLayout.addConstraint(height)
    
        
    }
    
    func addConstraintsForPlayBtn(){
        let centerX = NSLayoutConstraint(item: self.playBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.LeftMargin, multiplier: 1, constant: 40)
        
        let centerY = NSLayoutConstraint(item: self.playBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 40)
        
        let width = NSLayoutConstraint(item: self.playBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.viewForFirstBaselineLayout, attribute: NSLayoutAttribute.Width, multiplier: 0.1, constant: 0)
        
        self.viewForFirstBaselineLayout.addConstraint(centerX)
        self.viewForFirstBaselineLayout.addConstraint(centerY)
        
        self.viewForFirstBaselineLayout.addConstraint(width)

    }
    
    func addConstraintsForNameLbl () {
        let centerX = NSLayoutConstraint(item: self.nameLbl, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 0.75, constant: 0)
        
        let centerY = NSLayoutConstraint(item: self.nameLbl, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 15)
        
        let width = NSLayoutConstraint(item: self.nameLbl, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.viewForFirstBaselineLayout, attribute: NSLayoutAttribute.Width, multiplier: 0.2, constant: 0)
        
        self.viewForFirstBaselineLayout.addConstraint(centerX)
        self.viewForFirstBaselineLayout.addConstraint(centerY)
        
        self.viewForFirstBaselineLayout.addConstraint(width)
    
    }
    
    
    func addConstraintsForLocationLbl() {
        let centerX = NSLayoutConstraint(item: self.locationLbl, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.nameLbl, attribute: NSLayoutAttribute.RightMargin, multiplier: 1, constant: 20)
        let centerY = NSLayoutConstraint(item: self.locationLbl, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 15)
        let width = NSLayoutConstraint(item: self.locationLbl, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.viewForFirstBaselineLayout, attribute: NSLayoutAttribute.Width, multiplier: 0.2, constant: 0)
        self.viewForFirstBaselineLayout.addConstraint(centerX)
        self.viewForFirstBaselineLayout.addConstraint(centerY)
        
        self.viewForFirstBaselineLayout.addConstraint(width)
        
    }
    
    func addConstraintForQuoteLbl() {
        let leadingX = NSLayoutConstraint(item: self.quoteLbl, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: self.nameLbl, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: 0)
        let leadingY = NSLayoutConstraint(item: self.quoteLbl, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: self.nameLbl, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 20)
        let width = NSLayoutConstraint(item: self.quoteLbl, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.viewForFirstBaselineLayout, attribute: NSLayoutAttribute.Width, multiplier: 0.75, constant: 0)
        self.viewForFirstBaselineLayout.addConstraint(leadingX)
        self.viewForFirstBaselineLayout.addConstraint(leadingY)
        self.viewForFirstBaselineLayout.addConstraint(width)
        
        
    }
    
    func addConstraintsForNextBtn(){
        let trailingX = NSLayoutConstraint(item: self.nextBtn, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: -10)
        
        let centerY = NSLayoutConstraint(item: self.nextBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 40)
        
        let width = NSLayoutConstraint(item: self.nextBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.viewForFirstBaselineLayout, attribute: NSLayoutAttribute.Width, multiplier: 0.1, constant: 0)
        
        self.viewForFirstBaselineLayout.addConstraint(trailingX)
        self.viewForFirstBaselineLayout.addConstraint(centerY)
        
        self.viewForFirstBaselineLayout.addConstraint(width)
        
    }
}
