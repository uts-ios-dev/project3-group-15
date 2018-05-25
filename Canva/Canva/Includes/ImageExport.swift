    import UIKit
    
    // The view to be saved
    /*@IBOutlet*/ weak var mainCanvas: UIView!
    
    // Accepts a UIView as an argument and exports it as a PNG
    func exportImg(_ viewToExport: UIView?) {
        // Image exporting code adapted from from:
        // 1. https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
        // 2. https://www.hackingwithswift.com/example-code/media/how-to-save-a-uiimage-to-a-file-using-uiimagepngrepresentation
        
        // Convert UIView to UIImage and save to gallery
        let imageRenderer = UIGraphicsImageRenderer(size: (viewToExport?.bounds.size)!)
        let image = imageRenderer.image { ctx in viewToExport?.drawHierarchy(in: (viewToExport?.bounds)!, afterScreenUpdates: true)}
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // Incase we need it...
        // To save as a PNG in the app directory, use the following code:
        //
        // let imageData = UIImagePNGRepresentation(image)
        // let imageFilename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("copy.png")
        // try? imageData?.write(to: imageFilename)
    }
    
    // The action to give the export image to gallery button
    /*@IBAction*/ func saveImagePress(_ sender: UIButton) {
        exportImg(mainCanvas)
    }
