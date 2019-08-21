//
//  GalleryViewCell.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 31/01/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit




class GalleryViewCell: UICollectionViewCell {
  
  @IBOutlet weak var galleryImage: UIImageView!
  
  public func configure(with url: String) {
    galleryImage.kf.setImage(with: URL(string: url))
  }
  
  
}
