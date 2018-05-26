//
//  Bubble.swift
//  BubblePop
//
//  Created by Thien Nguyen on 4/15/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class Global {
    
    struct Constants {
        static let galleryBundleName = "gallery.bundle"
        static let galleryImageFileNames = Helper.getImageFileNamesFromBundle(bundle: Global.Constants.galleryBundleName)
        static let canvaBackgroundColor = UIColor(displayP3Red: 0.933333, green: 0.964706, blue: 0.992157, alpha: 1)
    }
    
}
