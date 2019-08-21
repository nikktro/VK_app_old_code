//
//  UserGroupController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 28/12/2018.
//  Copyright © 2018 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import RealmSwift

class UserGroupController: UITableViewController, UISearchBarDelegate {
  
  @IBOutlet weak var groupSearchBar: UISearchBar!
  
  private var groupList: Results<Group>?
  private var groupSearchList: Results<Group>? // массив для поиска
  
  var notificationToken: NotificationToken?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    groupSearchBar.delegate = self
    tableView.keyboardDismissMode = .onDrag
    
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    if let realm = try? Realm(configuration: config) {
      groupList = realm.objects(Group.self)
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Realm Notification Group List
    notificationToken = groupList?.observe{ changes in
      switch changes {
      case .initial(_):
        break
      case .update( _, _, _, _):
        self.tableView.reloadData()
      case .error(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    notificationToken?.invalidate()
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    
    // Запрос к API Group
    let vkService = VKService()
    vkService.apiUserGroupList() { [weak self] groupListJSON, error in
      
      if let error = error {
        // TODO: правильно через extenssion выдавать пользователю alert
        print(error.localizedDescription)
        return
      } else if let groups = groupListJSON, let self = self {
        RealmProvider.save(items: groups)
        
        // обновление интерфейса переводим в главный поток
        DispatchQueue.main.async {
          self.groupSearchList = self.groupList
          self.tableView.reloadData()
        }
      }
    }
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groupSearchList?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroup", for: indexPath) as? UserGroupCell,
      let group = groupSearchList?[indexPath.row] else { return UITableViewCell() }
    cell.configure(with: group)
    return cell
  }
}

// // TODO: fix Searchbar
//extension UserGroupController {
//
//  // SearchBar
//  func searchBar(_ groupSearchBar: UISearchBar, textDidChange searchText: String) {
//
//    // очищаем фильтр, если запрос пустой
//    guard !searchText.isEmpty else {
//      groupSearchList = groupList
//      tableView.reloadData()
//      return
//    }
//
//    // фильтр по lowercase
//    groupSearchList = groupList.filter({ group -> Bool in
//      return group.name.lowercased().contains(searchText.lowercased())
//    })
//    tableView.reloadData()
//
//  }
//
//}
