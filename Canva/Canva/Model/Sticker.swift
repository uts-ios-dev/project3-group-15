//
//  Bubble.swift
//  BubblePop
//
//  Created by Thien Nguyen on 4/15/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class Sticker {
    // Properties
    var image: UIImage
    var loadedIntoView: Bool
    
    init(image: UIImage) {
        self.image = image
        self.loadedIntoView = false
    }
    
}
