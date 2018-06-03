//
//  Bubble.swift
//  BubblePop
//
//  Created by Thien Nguyen on 4/15/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//
import Foundation
import UIKit

protocol StickerDelegate {
    func selectedSticker(id: String)
    func deleteSticker()
    func stopShakeAll()
    
//    func buttonTapped(button: UIButton)
}

class Sticker: UIImageView, UIGestureRecognizerDelegate {
    
    // Properties
    let id: String = UUID().uuidString
    var loadedIntoView: Bool = false
    var startCenter: CGPoint?
    var startTouch: CGPoint?
    var delegate: StickerDelegate?
    var button2: UIButton?
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//    let animation = CAKeyframeAnimation(keyPath: "transform")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init (image: UIImage?) {
        super.init(image: image)
        
        self.isUserInteractionEnabled = true
        //        self.clipsToBounds = true
        self.frame.origin = CGPoint(x: 50, y: 50)
        self.frame.size = CGSize(width: 100, height: 100)
        
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotate))
        let pinchRecogizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
        
        pinchRecogizer.delegate = self
        
        self.addGestureRecognizer(rotationRecognizer)
        self.addGestureRecognizer(pinchRecogizer)
        //        self.isUserInteractionEnabled = true
        
        //        let buttonTest = DeleteButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        //        self.addSubview(buttonTest)
        
        //        let pressed:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        //        pressed.delegate = self
        //        pressed.minimumPressDuration = 0.2
        //        self.addGestureRecognizer(pressed)
        
    }
    
    //    @objc func longPress(sender: UILongPressGestureRecognizer) {
    //
    ////        if sender.state == .began { print("LongPress BEGAN detected") }
    ////        if sender.state == .ended { print("LongPress ENDED detected") }
    //
    //        if let viewWithTag = self.superview?.viewWithTag(23) {
    //            viewWithTag.removeFromSuperview()
    //        }
    //
    //        let button2 = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    //        button2.backgroundColor = .red
    //        button2.setTitle("Delete", for: .normal)
    //        button2.tag = 23
    //        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    //
    //        //        self.superview?.addSubview(button2)
    //        self.addSubview(button2)
    //        delegate?.selectedSticker(id: self.id)
    //
    //
    //    }
    
    
    //    lazy var button2: UIButton = {
    //        let button2 = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    //        button2.backgroundColor = .red
    //        button2.setTitle("Delete", for: .normal)
    //        button2.tag = 23
    //        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    //        return button2
    //    }()
    
    
    func randomInterval(_ interval: TimeInterval, variance: Double) -> TimeInterval {
        return interval + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
    }
    
    func shake() {
        guard layer.animation(forKey: "wiggle") == nil else { return }
        guard layer.animation(forKey: "bounce") == nil else { return }
        
        let angle = 0.06
        
        let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        wiggle.values = [-angle, angle]
        wiggle.autoreverses = true
        wiggle.duration = randomInterval(0.1, variance: 0.025)
        wiggle.repeatCount = Float.infinity
        layer.add(wiggle, forKey: "wiggle")
        
        let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounce.values = [4.0, 0.0]
        bounce.autoreverses = true
        bounce.duration = randomInterval(0.12, variance: 0.025)
        bounce.repeatCount = Float.infinity
        layer.add(bounce, forKey: "bounce")
    }
    
//    func shake2() {
//
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        animation.duration = 0.6
//        animation.repeatCount = 1000
//        animation.autoreverses = true
//        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
//        layer.add(animation, forKey: "shake")
//    }
//
    func stopShake() {
       layer.removeAllAnimations()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startCenter = self.center
        if let viewWithTag = self.superview?.viewWithTag(23) {
            viewWithTag.removeFromSuperview()
            delegate?.stopShakeAll()
//            self.stopShake()
        }
        for touch in touches {
            startTouch = touch.location(in: self.superview)
            //            if let viewWithTag =  self.viewWithTag(23) {
            //                print("self.viewWithTag(23) {")
            //                //                        viewWithTag.removeFromSuperview()
            //            }
        }
        //        let button2 = UIButton(frame: CGRect(x: startCenter!.x + 100, y: startCenter!.y + 100, width: 100, height: 50))
        button2 = UIButton(frame: CGRect(x: startCenter!.x + 20 , y: startCenter!.y + 20, width: 25, height: 25))
        self.applyRoundCorner(button2!)
        self.shake()
        
        //        button2 = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 50))
        //        let button2 = DeleteButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button2?.backgroundColor = UIColor.gray
        button2?.setTitle("X", for: .normal)
        button2?.tag = 23
        //        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button2?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.superview?.addSubview(button2!)
        //        self.layer.zPosition = 1
        //                self.addSubview(button2!)
        delegate?.selectedSticker(id: self.id)
        
    }
    //    @objc func buttonAction(sender: UIButton!) {
    //        print("Button tapped")
    //
    //        //        delegate?.deleteSticker()
    //
    //    }
    
    @objc func buttonAction(sender: UIButton) {
        print("Button tapped")
        //        guard let delegate = delegate else { return }
        //        delegate.buttonTapped(button: sender)
        delegate?.deleteSticker()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var deltax  = self.center.x
        var deltay  = self.center.y
        for touch in touches {
            let loc = touch.location(in: self.superview)
            self.center.x = startCenter!.x + loc.x - startTouch!.x
            self.center.y = startCenter!.y + loc.y - startTouch!.y
            deltax = self.center.x - deltax
            deltay = self.center.y - deltay
            button2?.center.x = (button2?.center.x)! + deltax
            button2?.center.y = (button2?.center.y)! + deltay
        }
    }
    func applyRoundCorner(_ object:AnyObject) {
        
        object.layer.cornerRadius = object.frame.size.width / 2
        object.layer.masksToBounds = true
    }
    @objc func didRotate(sender: UIRotationGestureRecognizer) {
        let rotation = sender.rotation
        self.transform = self.transform.rotated(by: rotation)
        sender.rotation = 0
    }
    
    @objc func didPinch(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        sender.scale = 1
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
}
