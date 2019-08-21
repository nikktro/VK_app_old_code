//
//  UserGroupCell.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 28/12/2018.
//  Copyright © 2018 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import Kingfisher

class UserGroupCell: UITableViewCell {

  @IBOutlet weak var userGroupImage: UIImageView! {
    didSet{
      userGroupImage.layer.cornerRadius = userGroupImage.frame.size.height / 2
      userGroupImage.layer.masksToBounds = true
      // TODO: добавить тень для аватарки
    }
  }
  @IBOutlet weak var userGroupLabel: UILabel!
  
  public func configure(with groupList: Group) {
    userGroupLabel.text = groupList.name
    userGroupImage.kf.setImage(with: URL(string: groupList.photo))
  }
  
}
