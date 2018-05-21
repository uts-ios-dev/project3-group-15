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
    
    // MAGGIE START
    @IBOutlet weak var sticker1: UIButton!
    @IBOutlet weak var sticker2: UIButton!
    @IBOutlet weak var sticker3: UIButton!
    
    /*
     var location = CGPoint(x: 0, y: 0)
     
     override func touchesBegan(_ touches: Set<UITouch>!, with event: UIEvent!) {
     let touch : UITouch! = touches.anyObject() as UITouch // or touches.first // Try this
     location = touch.location(in: self.view)
     sticker3.center = location
     }
     
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     let touch : UITouch! = touches.anyObject() as UITouch
     location = touch.location(in: self.view)
     sticker3.center = location
     }
     */
    // MAGGIE END
    
    public var screenWidth: Double {
        return Double(UIScreen.main.bounds.width)
    }
    public var screenHeight: Double {
        return Double(UIScreen.main.bounds.height)
    }
    
    
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
    
    // MAGGIE START
    func draggedSticker(selectedSticker: String) {
        let stickerTemplate = UIButton(frame: CGRect(x: (screenWidth * 0.4 + Double(arc4random_uniform(UInt32(screenWidth * 0.4)))), y: (screenWidth * 0.2 + Double(arc4random_uniform(UInt32(screenHeight * 0.7)))), width: 72.0, height: 72.0))
        
        if selectedSticker == "1" {
            let image = UIImage(named: "sticker1") as UIImage?
            stickerTemplate.setImage(image, for: UIControlState.normal)
            stickerTemplate.addTarget(self, action: #selector(editSticker1(_: )), for: UIControlEvents.touchUpInside) // allTouchEvents
        }
        if selectedSticker == "2" {
            let image = UIImage(named: "sticker2") as UIImage?
            stickerTemplate.setImage(image, for: UIControlState.normal)
            stickerTemplate.addTarget(self, action: #selector(editSticker2(_: )), for: UIControlEvents.touchUpInside)
        }
        if selectedSticker == "3" {
            let image = UIImage(named: "sticker3") as UIImage?
            stickerTemplate.setImage(image, for: UIControlState.normal)
            stickerTemplate.addTarget(self, action: #selector(editSticker3(_: )), for: UIControlEvents.touchUpInside)
        }
        self.view.addSubview(stickerTemplate)
    }
    
    @IBAction func sticker1(_ sender: Any) {
        // sticker1.isHidden = true
        draggedSticker(selectedSticker: "1")
    }
    @IBAction func sticker2(_ sender: Any) {
        // sticker2.isHidden = true
        draggedSticker(selectedSticker: "2")
    }
    @IBAction func sticker3(_ sender: Any) {
        draggedSticker(selectedSticker: "3")
    }
    
    @objc func editSticker1(_ sender: Any) {
        // (sender as! UIButton).transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2) // rotates 90 degrees to the left
        (sender as! UIButton).transform = CGAffineTransform(rotationAngle: CGFloat.pi / 3)
    }
    
    @objc func editSticker2(_ sender: Any) {
        let image = UIImage(named: "sticker1") as UIImage?
        (sender as AnyObject).setImage(image, for: UIControlState.normal)
    }
    
    @objc func editSticker3(_ sender: Any) {
        /*
         (sender as! UIButton).animate(withDuration: 1, animations: {
         (sender as! UIButton).transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
         }) { (finished) in
         UIView.animate(withDuration: 1, animations: {
         (sender as! UIButton).transform = CGAffineTransform.identity
         })
         }
         */
    }
    
    /*
     func viewForZoomingInScrollView(scrollView: UIScrollVIew) -> UIView? {
     return self.sticker3
     }
     */
    // MAGGIE END
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}

