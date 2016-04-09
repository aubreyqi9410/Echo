//
//  CircularLoaderView.swift
//  Echo
//
//  Created by Ying Qi on 4/4/16.
//  Copyright © 2016 Duke University. All rights reserved.
//
// http://zappdesigntemplates.com/cashapelayer-to-create-a-custom-progressbar/
import UIKit

class CircularLoaderView: UIView {
    
    private let progressLayer: CAShapeLayer = CAShapeLayer()
    
    private var progressLabel: UILabel
    
    private var pauseBtn: UIImageView
    
    required init?(coder aDecoder: NSCoder) {
        progressLabel = UILabel()
        pauseBtn = UIImageView()
        super.init(coder: aDecoder)
        createProgressLayer()
        createPauseBtn()
        //createLabel()
    }
    
    override init(frame: CGRect) {
        progressLabel = UILabel()
        pauseBtn = UIImageView()
        super.init(frame: frame)
        createProgressLayer()
        createPauseBtn()
        //createLabel()
    }
    
    func createPauseBtn(){
        let pauseImage: UIImage = UIImage(named: "pause")!
        pauseBtn = UIImageView(image: pauseImage)
        addSubview(pauseBtn)
        pauseBtn.center = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
 

        
    }
    
    func createLabel() {
        progressLabel = UILabel(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 60.0))
        progressLabel.textColor = .whiteColor()
        progressLabel.textAlignment = .Center
        progressLabel.text = "Load content"
        progressLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 40.0)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        
        
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    private func createProgressLayer() {
        let startAngle = CGFloat(M_PI_2)
        let endAngle = CGFloat(M_PI * 2 + M_PI_2)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        
    
        
    
        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.blackColor().CGColor
        progressLayer.lineWidth = 4.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.0, 1.0]
        
        let blueColor: AnyObject = UIColor(red: 194.0/255.0, green: 230.0/255.0, blue: 237.0/255.0, alpha: 1.0).CGColor
        
        //let colorTop: AnyObject = UIColor(red: 255.0/255.0, green: 213.0/255.0, blue: 63.0/255.0, alpha: 1.0).CGColor
        //let colorBottom: AnyObject = UIColor(red: 255.0/255.0, green: 198.0/255.0, blue: 5.0/255.0, alpha: 1.0).CGColor
        let arrayOfColors: [AnyObject] = [blueColor, blueColor]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    func hideProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
        progressLabel.text = "Load content"
    }
    
    func animateProgressView(duration: Double) {
        progressLabel.text = "Loading..."
        progressLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = duration
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = true
        animation.fillMode = kCAFillModeForwards
        progressLayer.addAnimation(animation, forKey: "strokeEnd")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        progressLabel.text = "Done"
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}