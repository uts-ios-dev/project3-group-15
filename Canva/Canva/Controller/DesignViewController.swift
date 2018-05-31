//
//  DesignViewController.swift
//  Canva
//
//  Created by Thien Nguyen on 5/14/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import UIKit
import SideMenu

class DesignViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GalleryControllerDelegate, StickerDelegate {
 
    
    
    @IBOutlet weak var canvaView: UIView!
    @IBOutlet weak var buttonSaveToAlbum: UIButton!
    @IBOutlet weak var canvaBackground: UIImageView!
    
    var stickers = [Sticker]()
    var generator = UINotificationFeedbackGenerator()
    var selectedtoDeleteSticker = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .red
        button.setTitle("Delete Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.isHidden = true
        self.view.addSubview(button)
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        Helper.preloadGallery()
        
        canvaView.backgroundColor = Global.Constants.canvaBackgroundColor
        
        //        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        //        button.backgroundColor = .red
        //        button.setTitle("Delete Button", for: .normal)
        //        self.addSubview((button)!)
//        let button2 = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button2.backgroundColor = .red
//        button2.setTitle("Test Button", for: .normal)
//        button2.tag = 23
//        self.view.addSubview(button2)
    }
    
    // SAMANEH
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let viewWithTag = self.view.viewWithTag(23) {
            viewWithTag.removeFromSuperview()
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
    
    func updateVisibleStickers(sticker: Sticker) {
        stickers.append(sticker)
        
        for sticker in stickers {
            if (!sticker.loadedIntoView) {
                self.canvaView.addSubview(sticker)
                
                sticker.loadedIntoView = true
            }
        }
    }
    
    func selectedSticker(index: Int) {
        selectedtoDeleteSticker = index
    }
    
    func deleteSticker() {
        print("here")
        let sticker = stickers[selectedtoDeleteSticker]
        sticker.removeFromSuperview()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        canvaBackground.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated:true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UISideMenuNavigationController, let galleryController = nav.topViewController as? GalleryController {
            galleryController.delegate = self
        }
    }
    
    @IBAction func buttonTakePhotoTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonSaveToAlbumTouchDown(_ sender: Any) {
        self.generator.prepare()
    }
    
    @IBAction func buttonSaveToAlbumTouchUp(_ sender: Any) {
        self.generator.notificationOccurred(.success)
        self.exportImage(self.canvaView)
    }
    
    private func exportImage(_ viewToExport: UIView?) {
        let imageRenderer = UIGraphicsImageRenderer(size: (viewToExport?.bounds.size)!)
        let image = imageRenderer.image { ctx in viewToExport?.drawHierarchy(in: (viewToExport?.bounds)!, afterScreenUpdates: true)}
        
        let imageData = UIImagePNGRepresentation(image)
        let pngImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(pngImage!, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Great", message: "Canva has been saved to your photos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            alert.addAction(UIAlertAction(title: "Goto Camera Roll", style: .default) {(UIAlertAction) in {
                UIApplication.shared.open(URL(string:"photos-redirect://")!)
                }()})
            present(alert, animated: true)
        }
    }
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    func showSubviewButtonTapped(sender: AnyObject) {
        
    }
}

