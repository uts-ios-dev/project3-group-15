//
//  menuPane.swift
//  Canva
//
//  Created by Brenda Brown on 21/5/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import UIKit

class menuPane: UIView {

    var startCenter: CGPoint?
    var startTouch: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startCenter = self.center
        for touch in touches {
            startTouch = touch.location(in: self.superview)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let currentTouch = touch.location(in: self.superview)
            self.center.x = startCenter!.x + (currentTouch.x - startTouch!.x)
        }
    }
}

class menuPaneLeft: menuPane {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if self.center.x > (superview?.frame.minX)!+40 {
            self.center.x = (superview?.frame.minX)!+40
        }
        if self.center.x < (superview?.frame.minX)!-20 {
            self.center.x = (superview?.frame.minX)!-20
        }
    }
}

class menuPaneRight: menuPane {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if self.center.x < (superview?.frame.maxX)!-40 {
            self.center.x = (superview?.frame.maxX)!-40
        }
        if self.center.x > (superview?.frame.maxX)!+20 {
            self.center.x = (superview?.frame.maxX)!+20
        }
    }
}
