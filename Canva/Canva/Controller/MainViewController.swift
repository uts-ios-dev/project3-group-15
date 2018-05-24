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
    
    // >>>> MAGGIE START
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
    // >>>> MAGGIE END
    
    public var screenWidth: Double {
        return Double(UIScreen.main.bounds.width)
    }
    public var screenHeight: Double {
        return Double(UIScreen.main.bounds.height)
    }
    
   
    override func viewDidLoad() {
     
    
    }
    // >>>> SAMANEH END
    
    // >>>> MAGGIE START
    func draggedSticker(selectedSticker: String) {
        let stickerTemplate = UIButton(frame: CGRect(x: (screenWidth * 0.4 + Double(arc4random_uniform(UInt32(screenWidth * 0.4)))), y: (screenWidth * 0.2 + Double(arc4random_uniform(UInt32(screenHeight * 0.7)))), width: 72.0, height: 72.0))
        
        stickerTemplate.tag = 1
        
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
        
        let btn = (sender as! UIButton)
        btn.tag = btn.tag + 1
        btn.transform = CGAffineTransform(rotationAngle:  0.2 * CGFloat(btn.tag))
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
    // >>>> MAGGIE END
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

