//
//  GalleryCollectionViewCell.swift
//  my_ImageGallery
//
//  Created by user145418 on 12/11/18.
//  Copyright © 2018 user145418. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    
        var imageURL: URL? {
            didSet {
                if imageURL != nil && (oldValue != imageURL) {
                    fetchImage()
                }
            }
        }
        
        private(set) var image: UIImage? {
            get {
                return imageView?.image
            }
            set {
                imageView.image = newValue
            }
        }
        
        private func fetchImage() {
            if let url = imageURL {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let urlContents = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let imageData = urlContents {
                            self?.image = UIImage(data: imageData)
                            print("ImageView set the data")
                        }
                    }
                }
            }
        }
        
        // MARK: - storyboard
        
        @IBOutlet weak var imageView: UIImageView!
        
        
        
        
    }


