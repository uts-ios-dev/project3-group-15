//
//  dragging.swift
//  thisisthetestofcanva
//
//  Created by Samaneh Fathieh on 21/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//



import UIKit

class Sticker: UIImageView {
    
    var startCenter: CGPoint?
    var startTouch: CGPoint?
    var idNumber: Int?
    
    init(image: UIImage?, id: Int) {
        super.init(image: image)
        idNumber = id
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startCenter = self.center
        for touch in touches {
            startTouch = touch.location(in: self.superview)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let loc = touch.location(in: self.superview)
            self.center.x = startCenter!.x + loc.x - startTouch!.x
            self.center.y = startCenter!.y + loc.y - startTouch!.y
            //            self.center = startCenter + (loc - startTouch)
        }
    }
    
}
