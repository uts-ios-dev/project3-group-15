//
//  Orientation.swift
//  Canva
//
//  Created by Maggie Liuzzi on 1/6/18.
//  Copyright © 2018 Maggie Liuzzi. All rights reserved.
//

import Foundation

/* // Giving lots of errors. Undeclared type 'UIInterfaceOrientationMark', 'UIApplication', 'UIDevice'.

struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}

*/
