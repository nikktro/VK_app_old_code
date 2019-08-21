//
//  topology.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 28/12/2018.
//  Copyright © 2018 Nikolay.Trofimov. All rights reserved.
//

import UIKit


//struct Group {
//  let name: String
//  let image: UIImage?
//}

//struct Friend {
//  let id: Int
//  let name: String
//  let surname: String
//  let image: UIImage?
//}

struct News {
  let owner_id: Int
  let titleImage: UIImage?
  let titleName: String
  let titleTime: String
  
  let contentText: String
  let contentImage: UIImage?
  
  let commentCount: Int
  let shareCount: Int
  let viewCount: Int
  let likeCount: Int
  
    init(owner_id: Int, titleImage: UIImage?, titleName: String, titleTime: String, contentText: String, contentImage: UIImage?, commentCount: Int, shareCount: Int, viewCount: Int, likeCount: Int) {
    self.owner_id = owner_id
    self.titleImage = titleImage
    self.titleName = titleName
    self.titleTime = titleTime
    self.contentText = contentText
    self.contentImage = contentImage
    self.commentCount = commentCount
    self.shareCount = shareCount
    self.viewCount = viewCount
    self.likeCount = likeCount
  }
  
}
