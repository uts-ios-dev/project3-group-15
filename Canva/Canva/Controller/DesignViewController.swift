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
    @IBOutlet weak var canvaBackground: UIImageView!
    
    var stickers = [Sticker]()
    var generator = UINotificationFeedbackGenerator()
    var selectedStickerToDelete = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        Helper.preloadGallery()
        
        canvaView.backgroundColor = Global.Constants.canvaBackgroundColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let viewWithTag = self.view.viewWithTag(23) {
            viewWithTag.removeFromSuperview()
            stopShakeAll()
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
        sticker.delegate = self
        for sticker in stickers {
            if (!sticker.loadedIntoView) {
                self.canvaView.addSubview(sticker)
                sticker.loadedIntoView = true
            }
        }
    }
    
    func stopShakeAll() {
        for sticker in stickers {
            sticker.stopShake()
        }
    }
    
    func selectedSticker(id: String) {
        selectedStickerToDelete = id
    }
    
    func deleteSticker() {
        for sticker in stickers {
            if sticker.id == selectedStickerToDelete {
                sticker.removeFromSuperview()
            }
        }
        
        if let viewWithTag = self.view.viewWithTag(23) {
            viewWithTag.removeFromSuperview()
        }
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
    
    @IBAction func buttonImportPhotoTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
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
    
}

