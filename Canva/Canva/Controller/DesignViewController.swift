//
//  DesignViewController.swift
//  Canva
//
//  Created by Thien Nguyen on 5/14/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import UIKit

class DesignViewController: UIViewController {
    
    var stickers = [Sticker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
        
        let imageFileNames = Helper.getImageFileNamesFromBundle(bundle: Constants.galleryBundleName)
        if (imageFileNames.count > 0) {
            let sticker = Sticker(image: UIImage(named: "\(Constants.galleryBundleName)/\(imageFileNames[0])")!)
            stickers.append(sticker)
        }
        
        for sticker in stickers {
            if (!sticker.loadedIntoView) {
                let imageSubView = UIImageView(image: sticker.image)
                
                imageSubView.frame.origin = CGPoint(x: 50, y: 50)
                imageSubView.frame.size = CGSize(width: 100, height: 100)
                
                self.view.addSubview(imageSubView)
                
                sticker.loadedIntoView = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.performSegue(withIdentifier: "segueDesignToSideMenu", sender: self)
        }
    }
    
    @IBAction func unwindToDesignScreen(unwindSegue: UIStoryboardSegue) {
    }
    
}

