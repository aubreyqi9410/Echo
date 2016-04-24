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
    private var color: UIColor?
    
    private var replayPressed: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
        createProgressLayer()
    }
    
   init(frame: CGRect, color: UIColor) {
        self.color = color
    
        super.init(frame: frame)
        createProgressLayer()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sendBtnState", name: "com.yingqi.Echo.RecordButtonState", object: nil)
    
    }
    
    func sendBtnState(){
        
    }
    
    private func createProgressLayer() {
        let startAngle = CGFloat(M_PI_2)
        let endAngle = CGFloat(M_PI * 2 + M_PI_2)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2  , CGRectGetHeight(frame)/2)

        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 5, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
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
        
        let myColor: AnyObject = self.color!.CGColor
        let arrayOfColors: [AnyObject] = [myColor, myColor]
        
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    func hideProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
       
    }
    
    func animateProgressView(duration: Double) {
       
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
    
    func stopAnimation(){
        print("stop animation called")
        replayPressed = true

        progressLayer.removeAllAnimations()
        progressLayer.strokeEnd = 1
    }
    
    func animationDidStop() -> Bool {
        
        if (!replayPressed){
            print("sending notification")
            stopAnimation()
            NSNotificationCenter.defaultCenter().postNotificationName(myNotificationKey , object: self)
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName(myNotificationKey , object: self)
        }
            return true
    }
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {

        print("animation stopped")
        animationDidStop()

    }
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
