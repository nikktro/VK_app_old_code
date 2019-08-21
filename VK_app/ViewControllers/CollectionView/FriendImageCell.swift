//
//  FriendImageCell.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 28/12/2018.
//  Copyright © 2018 Nikolay.Trofimov. All rights reserved.
//

import UIKit

class FriendImageCell: UICollectionViewCell {
  
  @IBOutlet weak var friendImage: UIImageView!
  
  public func configure(with url: String) {
    friendImage.kf.setImage(with: URL(string: url))
  }
  
  
}
