//
//  ImageDownloader.swift
//  MFinder
//
//  Created by Saadhurya on 22/06/22.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func setImage(from url : String, completion : @escaping (UIImage?) -> ()) {
        sd_setImage(with: URL(string: url)) { (image, error, cache, urls) in
            completion(image)
        }
    }
    
    func cancelCurrentImageLoad() {
        sd_cancelCurrentImageLoad()
    }
}
