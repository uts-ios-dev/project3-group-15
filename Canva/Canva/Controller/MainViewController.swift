//
//  FirstViewController.swift
//  Canva
//
//  Created by Thien Nguyen on 5/14/18.
//  Further developed by Mitchell Clarke.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    
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
    
    // The view within the FirstViewController
    @IBOutlet weak var mainCanvas: UIView!
    
    
    // Accepts a UIView as an argument and exports it as a PNG
    func exportImg(_ viewToExport: UIView?) {
        // Image exporting code adapted from from:
        // 1. https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
        // 2. https://www.hackingwithswift.com/example-code/media/how-to-save-a-uiimage-to-a-file-using-uiimagepngrepresentation
        
        // Convert UIView to UIImage
        let imageRenderer = UIGraphicsImageRenderer(size: (viewToExport?.bounds.size)!)
        let image = imageRenderer.image { ctx in viewToExport?.drawHierarchy(in: (viewToExport?.bounds)!, afterScreenUpdates: true)}
        
        // Convert UIImage to a PNG data stream; can be changed to JPEG using UIImageJPEGRepresentation(image, 0.9)
        let imageData = UIImagePNGRepresentation(image)
        
        // Write PNG data stream to file; note that imageFilename can be changed
        let imageFilename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("copy.png")
        try? imageData?.write(to: imageFilename)
        
        // Reports in console where the image is saved to
        print(imageFilename)
    }
    
    // Saves an image of the canvas when the "Save Image" button is pressed
    @IBAction func saveImagePress(_ sender: UIButton) {
        exportImg(mainCanvas)
    }
    let imageView = UIImageView()
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}

