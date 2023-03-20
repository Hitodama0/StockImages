//
//  UIImageExtension.swift
//  FreeImages
//
//  Created by Biagio Ricci on 20/03/23.
//

import Foundation
import UIKit

// Create an UIImage from url so we can save it with ImageSaver
extension UIImage {
    
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        
        self.init(data: imageData)
    }
}
