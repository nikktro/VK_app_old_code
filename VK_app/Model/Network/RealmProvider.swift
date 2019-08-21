//
//  RealmProvider.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 27/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import RealmSwift

class RealmProvider {
  
  static func save<T: Object>(items: [T], config: Realm.Configuration = Realm.Configuration.defaultConfiguration, update: Bool = true) {
    guard let fileRealm = config.fileURL else { return }
    print(fileRealm) // TODO: Debuging
    print(Session.shared.token) // TODO: Debuging
    
    do {
      let realm = try Realm(configuration: config)
      try realm.write {
        realm.add(items, update: update)
      }
      
    } catch {
      print(error.localizedDescription)
    }
  
  }
}
