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
    func selectedSticker(index: Int)
    func deleteSticker()
}

class Sticker: UIImageView, UIGestureRecognizerDelegate {
    // Properties
    let id: String = UUID().uuidString
    var loadedIntoView: Bool = false
    var startCenter: CGPoint?
    var startTouch: CGPoint?
    var delegate: StickerDelegate?

    
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startCenter = self.center
        if let viewWithTag = self.superview?.viewWithTag(23) {
            viewWithTag.removeFromSuperview()
        }
        for touch in touches {
            startTouch = touch.location(in: self.superview)
            //            let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
            //            self.buttonAction(sender: button!)
            //            button?.backgroundColor = .red
            //            button?.setTitle("Delete Button", for: .normal)
            //            button?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            //            button?.isHidden = true
            //            self.addSubview((button)!)
            //            self.init(button: button)
            //            button.isHidden = false
            //
            
            
        }
        print(self.tag)
        let button2 = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button2.backgroundColor = .red
        button2.setTitle("Test Button", for: .normal)
        button2.tag = 23
//        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.superview?.addSubview(button2)
        delegate?.selectedSticker(index: 1)

    }
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")

        delegate?.deleteSticker()

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let loc = touch.location(in: self.superview)
            self.center.x = startCenter!.x + loc.x - startTouch!.x
            self.center.y = startCenter!.y + loc.y - startTouch!.y
        }
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
