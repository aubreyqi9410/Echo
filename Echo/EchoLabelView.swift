//
//  EchoLabelView.swift
//  Echo
//
//  Created by Ying Qi on 4/4/16.
//  Copyright © 2016 Duke University. All rights reserved.
//

import UIKit

class EchoLabelView: UIView {
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var numReplyLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        
    }
    
    
    
    init(width: CGFloat, height: CGFloat){
       // self.numReplyLbl.text = "2"
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))


        
    }
    
    func addConstraints(){
        print("adding constraints")
        self.addConstraintsForLikeBtn()
        self.addConstraintsForNumReply()
        self.addConstraintsForTimeLbl()
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
 
    /* Add Constraints */
    func addConstraintsForTimeLbl(){
        let centerX = NSLayoutConstraint(item: self.timeLbl, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: 10)
    
        let centerY = NSLayoutConstraint(item: self.timeLbl, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
    
        let width = NSLayoutConstraint(item: self.timeLbl, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.2, constant: 0)
    
        self.viewForFirstBaselineLayout.addConstraint(centerX)
        self.viewForFirstBaselineLayout.addConstraint(centerY)
    
        self.viewForFirstBaselineLayout.addConstraint(width)

    }
    
    func addConstraintsForNumReply(){
        let centerX = NSLayoutConstraint(item: self.numReplyLbl, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        
        
        
            print(self.frame.width)
        
        let centerY = NSLayoutConstraint(item: self.numReplyLbl, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.viewForFirstBaselineLayout, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
       

        self.numReplyLbl.text = " 2 replies"
        
        self.addConstraint(centerX)
        self.addConstraint(centerY)
        
        //self.addConstraint(width)
        
    }
    
    func addConstraintsForLikeBtn(){
        let centerX = NSLayoutConstraint(item: self.likeBtn, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: -10)
        
        let centerY = NSLayoutConstraint(item: self.likeBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        let width = NSLayoutConstraint(item: self.likeBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.7, constant: 0)
        
        
        self.addConstraint(width)
        
        
        let height = NSLayoutConstraint(item: self.likeBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.likeBtn, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        
        self.addConstraint(height)
        
        self.addConstraint(centerX)
        self.addConstraint(centerY)

        
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
