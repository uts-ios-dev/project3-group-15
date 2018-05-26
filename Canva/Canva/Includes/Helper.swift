//
//  Bubble.swift
//  BubblePop
//
//  Created by Thien Nguyen on 4/15/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import Foundation
import UIKit

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
    
    static func preloadGallery() {
        // Load images in background thread
        DispatchQueue.global(qos: .userInitiated).async {
            if (Global.Constants.galleryImageFileNames.count > 0) {
                for filename in Global.Constants.galleryImageFileNames {
                    guard let imageRef = UIImage(named: "\(Global.Constants.galleryBundleName)/\(filename)")?.cgImage else {
                        print("Image loading failed")
                        continue
                    }
                    let width = imageRef.width
                    let height = imageRef.height
                    let colourSpace = CGColorSpaceCreateDeviceRGB()
                    let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
                    
                    guard let imageContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colourSpace, bitmapInfo: bitmapInfo) else {
                        print("Image rendering failed")
                        continue
                    }
                    let rect = CGRect(x: 0, y: 0, width: width, height: height)
                    imageContext.draw(imageRef, in: rect)
                    _ = imageContext.makeImage()
                }
            }
        }
    }
    
}
