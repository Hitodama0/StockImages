//
//  ImageSaver.swift
//  FreeImages
//
//  Created by Biagio Ricci on 20/03/23.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
}
