//
//  NewsTableViewCell.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 22/01/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

  @IBOutlet weak var titleImage: UIImageView!
  @IBOutlet weak var titleName: UILabel!
  @IBOutlet weak var titleTime: UILabel!
  
  @IBOutlet weak var contentText: UILabel!
  @IBOutlet weak var contentImage: UIImageView!
  
  @IBOutlet weak var commentCount: UILabel!
  @IBOutlet weak var shareCount: UILabel!
  @IBOutlet weak var viewCount: UILabel!
  
  
  
}
