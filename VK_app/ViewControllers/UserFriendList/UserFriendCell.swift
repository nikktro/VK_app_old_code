//
//  UserFriendCell.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 28/12/2018.
//  Copyright © 2018 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import Kingfisher

class UserFriendCell: UITableViewCell {
  
  @IBOutlet weak var userFriendImage: UIImageView! {
    didSet {
      userFriendImage.layer.cornerRadius = userFriendImage.frame.size.height / 2
      userFriendImage.layer.masksToBounds = true
      // TODO: добавить тень для аватарки
    }
  }
  
  @IBOutlet weak var userFriendLabel: UILabel! {
    didSet {
      userFriendLabel.textColor = UIColor.black
    }
  }
  
  
  // очистка перед переиспользованием
  override func prepareForReuse() {
    super.prepareForReuse()
    userFriendImage.image = nil
    userFriendLabel.text = nil
  }
  
  
  //  override func layoutSubviews() {
  //    super.layoutSubviews()
  //
  //  }
  
  
  // заполнение аватарки и имени
  // TODO: добавить отдельный label для фамилии / имени
  public func configure(with friendList: Friend) {
    userFriendLabel.text = friendList.first_name + " " + friendList.last_name
    userFriendImage.kf.setImage(with: URL(string: friendList.photo))
  }
  
}
