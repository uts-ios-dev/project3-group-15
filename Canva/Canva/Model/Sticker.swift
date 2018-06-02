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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startCenter = self.center
        if let viewWithTag = self.superview?.viewWithTag(23) {
            viewWithTag.removeFromSuperview()
        }
        for touch in touches {
            startTouch = touch.location(in: self.superview)
            //            if let viewWithTag =  self.viewWithTag(23) {
            //                print("self.viewWithTag(23) {")
            //                //                        viewWithTag.removeFromSuperview()
            //            }
        }
        //        let button2 = UIButton(frame: CGRect(x: startCenter!.x + 100, y: startCenter!.y + 100, width: 100, height: 50))
        button2 = UIButton(frame: CGRect(x: startCenter!.x + 50 , y: startCenter!.y + 50, width: 100, height: 50))
        //        button2 = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 50))
        //        let button2 = DeleteButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button2?.backgroundColor = .red
        button2?.setTitle("Delete", for: .normal)
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
