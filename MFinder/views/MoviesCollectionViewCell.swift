//
//  MoviesCollectionViewCell.swift
//  MFinder
//
//  Created by Saadhurya on 23/06/22.
//

import UIKit


class MoviesCollectionViewCell: UICollectionViewCell {
    static let placeholderImage = UIImage(named: "image-preview.png")

    @IBOutlet private var imgPreview : UIImageView?
    @IBOutlet private var lblTitle : UILabel?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var viewContainer : UIView?

    var isLoading: Bool {
      get { return activityIndicator.isAnimating }
      set {
        if newValue {
          activityIndicator.startAnimating()
        } else {
          activityIndicator.stopAnimating()
        }
      }
    }
    
    func setTitle(title: String?) {
        if let title = title {
            lblTitle?.text = title
            lblTitle?.sizeToFit()
        }
        viewContainer?.layer.cornerRadius = 10
        viewContainer?.layer.borderColor = UIColor.darkGray.cgColor
        viewContainer?.layer.borderWidth = 2
    }
    
    func display(url: String?) {
        
        self.isLoading = true
        if let url = url {
            imgPreview?.setImage(from: url, completion: { image in
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    if let image = image {
                       self?.imgPreview?.image = image
                    } else {
                        self?.imgPreview?.image = MoviesCollectionViewCell.placeholderImage
                    }
                }
            })
        }
    }
    
    func cancelImageRequest() {
        imgPreview?.image = MoviesCollectionViewCell.placeholderImage
    }
}
