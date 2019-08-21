//
//  GroupStruct.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 13/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class Group: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var photo: String = ""
  
  convenience init(json: JSON) {
    self.init()
    self.id = json["id"].intValue
    self.name = json["name"].stringValue
    self.photo = json["photo_100"].stringValue
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
