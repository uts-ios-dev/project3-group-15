//
//  Bubble.swift
//  BubblePop
//
//  Created by Thien Nguyen on 4/15/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import Foundation

class Helper {
    
    static func getImageFileNamesFromBundle(bundle: String) -> [String] {
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent(bundle)
        let contents = try! fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.localizedNameKey, URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey], options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
        
        var images = [String]()
        for item in contents {
            images.append(item.lastPathComponent)
        }
        
        return images
    }
    
}
