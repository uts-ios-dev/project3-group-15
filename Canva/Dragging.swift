//
//  Dragging.swift
//  Canva
//
//  Created by Samaneh Fathieh on 21/5/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import UIKit

    //
    //  ViewController.swift
    //  Zooming
    //
    //  Created by Samaneh Fathieh on 21/5/18.
    //  Copyright © 2018 Samaneh Fathieh. All rights reserved.
    //

    
    class ViewController: UIViewController, UIScrollViewDelegate {
        
        let imageView = UIImageView()
        
        @IBOutlet weak var scrollView: UIScrollView!
        override func viewDidLoad() {
            super.viewDidLoad()
            self.scrollView.minimumZoomScale = 1.0
            self.scrollView.maximumZoomScale = 6.0
            scrollView.delegate = self
            
            let image = UIImage(named: "monster.jpg")
            imageView.image = image
            //        imageView.frame = CGRect(origin: CGPoint, size: image!.size)
            scrollView.addSubview(imageView)
            scrollView.contentSize = image!.size
            scrollView.clipsToBounds = false
            //        scrollView.layer.borderColor = UIColor.yellow.cgColor
            scrollView.layer.borderWidth = 4.0
            
            let scrollViewFrame = scrollView.frame
            let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
            let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
            let minScale = min(scaleWidth, scaleHeight);
            scrollView.minimumZoomScale = minScale;
            
            scrollView.maximumZoomScale = 10.0
            scrollView.zoomScale = minScale;
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
            return self.imageView
        }
        
        
    }
    
    
    
