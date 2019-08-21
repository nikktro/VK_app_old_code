//
//  Friend.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 13/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


@objcMembers
class Friend: Object {
  dynamic var id: Int = 0
  dynamic var first_name: String = ""
  dynamic var last_name: String = ""
  dynamic var photo: String = ""
  var friendPhoto = List<FriendPhoto>()
  
  convenience init(json: JSON, friendPhoto: [FriendPhoto] = []) {
    self.init()
    self.id = json["id"].intValue
    self.first_name = json["first_name"].stringValue
    self.last_name = json["last_name"].stringValue
    self.photo = json["photo_100"].stringValue
    self.friendPhoto.append(objectsIn: friendPhoto)
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
}
