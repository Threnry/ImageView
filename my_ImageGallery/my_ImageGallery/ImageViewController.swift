//
//  ImageViewController.swift
//  my_ImageGallery
//
//  Created by user145418 on 12/11/18.
//  Copyright © 2018 user145418. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
   
        
        
        @IBOutlet weak var scrollView: UIScrollView! {
            didSet {
                scrollView.minimumZoomScale = 0.1
                scrollView.maximumZoomScale = 5.0
                scrollView.delegate = self
                scrollView.contentSize = imageView.frame.size
                scrollView.addSubview(imageView)
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            if imageView.image == nil {
                fetchImage()
            }
        }
        
        var imageURL: URL? {
            didSet {
                image = nil
                if view.window != nil {
                    fetchImage()
                }
            }
        }
        
        private(set) var image: UIImage? {
            get {
                return imageView.image
            }
            set {
                imageView.image = newValue
                imageView.sizeToFit()
                scrollView?.contentSize = imageView.frame.size
            }
        }
        
        private var imageView = UIImageView()
        
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
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imageView
        }
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }


