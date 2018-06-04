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
}

class Sticker: UIImageView, UIGestureRecognizerDelegate {
    
    // Properties
    let id: String = UUID().uuidString
    var loadedIntoView: Bool = false
    var startCenter: CGPoint?
    var startTouch: CGPoint?
    var delegate: StickerDelegate?
    var closeIcon: UIButton?
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init (image: UIImage?) {
        super.init(image: image)
        
        self.isUserInteractionEnabled = true
        self.frame.origin = CGPoint(x: 50, y: 50)
        self.frame.size = CGSize(width: 100, height: 100)
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotate))
        let pinchRecogizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
        
        pinchRecogizer.delegate = self
        
        self.addGestureRecognizer(rotationRecognizer)
        self.addGestureRecognizer(pinchRecogizer)
    }
    
    func randomInterval(_ interval: TimeInterval, variance: Double) -> TimeInterval {
        return interval + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
    }
    
    func shake() {
        guard layer.animation(forKey: "bounce") == nil else { return }
        
        let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounce.values = [8.0, 0.0]
        bounce.autoreverses = true
        bounce.duration = randomInterval(0.12, variance: 0.025)
        bounce.repeatCount = Float.infinity
        layer.add(bounce, forKey: "bounce")
    }
    
    func stopShake() {
        layer.removeAllAnimations()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startCenter = self.center
        if let viewWithTag = self.superview?.viewWithTag(23) {
            viewWithTag.removeFromSuperview()
            delegate?.stopShakeAll()
        }
        
        for touch in touches {
            startTouch = touch.location(in: self.superview)
        }
        
        closeIcon = UIButton(frame: CGRect(x: startCenter!.x + 20 , y: startCenter!.y + 20, width: 25, height: 25))
        self.applyRoundCorner(closeIcon!)
        self.shake()
        closeIcon?.backgroundColor = UIColor.gray
        closeIcon?.setTitle("X", for: .normal)
        closeIcon?.tag = 23
        closeIcon?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.superview?.addSubview(closeIcon!)
        delegate?.selectedSticker(id: self.id)
    }
    
    @objc func buttonAction(sender: UIButton) {
        print("Button tapped")
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
            self.closeIcon?.center.x = (closeIcon?.center.x)! + deltax
            self.closeIcon?.center.y = (closeIcon?.center.y)! + deltay
            // self.delegate?.stopShakeAll()
            // self.closeIcon?.isHidden = true
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
