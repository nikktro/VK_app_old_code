//
//  Session.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 06/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import Foundation

class Session {
  
  private init() {}
  
  public static let shared = Session()
  
  var token: String = ""
  var userId: Int = 0
  
}
