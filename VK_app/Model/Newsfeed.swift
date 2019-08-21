//
//  Newsfeed.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 25/03/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class Newsfeed: Object {
  @objc dynamic var type: String = ""
  @objc dynamic var sourceId: Int = 0
  @objc dynamic var date: Int = 0
  @objc dynamic var postId: Int = 0
  @objc dynamic var postType: String = ""
  @objc dynamic var text: String = ""
  @objc dynamic var markedAsAds: Int = 0
  @objc dynamic var isFavorite: Bool = false
  
  
  convenience init(json: JSON) {
    self.init()
    self.type = json["type"].stringValue
    self.sourceId = json["source_id"].intValue
    self.date = json["date"].intValue
    self.postId = json["post_id"].intValue
    self.postType = json["post_type"].stringValue
    self.text = json["text"].stringValue
    self.markedAsAds = json["marked_as_ads"].intValue
    self.isFavorite = json["is_favorite"].boolValue
  }
  
  override static func primaryKey() -> String? {
    return "postId"
  }
  
}


//    self.attachments = attachments
//    self.postSource = postSource
//    self.comments = comments
//    self.likes = likes
//    self.reposts = reposts
//    self.views = views
