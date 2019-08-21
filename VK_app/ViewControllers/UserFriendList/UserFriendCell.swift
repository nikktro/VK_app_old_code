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
  
  @IBOutlet weak var friendImageAvatar: UIImageView! {
    didSet {
      friendImageAvatar.layer.cornerRadius = friendImageAvatar.frame.size.height / 2
      friendImageAvatar.layer.masksToBounds = true
      // TODO: добавить тень для аватарки
    }
  }
  
  @IBOutlet weak var friendNameLabel: UILabel! {
    didSet {
      friendNameLabel.textColor = UIColor.black
      friendNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
  }

  @IBOutlet weak var friendSurnameLabel: UILabel! {
    didSet {
      friendSurnameLabel.textColor = UIColor.black
      friendSurnameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
  }
  
  
  // очистка перед переиспользованием
  override func prepareForReuse() {
    super.prepareForReuse()
    friendImageAvatar.image = nil
    friendNameLabel.text = nil
    friendSurnameLabel.text = nil
  }
  
  
  // заполнение аватарки и имени
  public func configure(with friendList: Friend) {
    friendNameLabel.text = friendList.first_name
    friendSurnameLabel.text = friendList.last_name
    friendImageAvatar.kf.setImage(with: URL(string: friendList.photo))
  }
  
}
