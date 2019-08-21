//
//  UserFriendController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 28/12/2018.
//  Copyright © 2018 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import RealmSwift


class UserFriendController: UITableViewController, UISearchBarDelegate {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  var friendList: Results<Friend>?
  var searchFriendList: Results<Friend>? // Массив для поиска
  
  var notificationToken: NotificationToken?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // for SearchBar
    searchBar.delegate = self
    
    // VKService User FriendList
    let vkService = VKService()
    
    vkService.apiUserFriendList() { [weak self] friendListJSON, error in
      if let error = error {
        // TODO: правильно через extenssion выдавать пользователю alert
        print(error.localizedDescription)
        return
      } else if let friends = friendListJSON, let self = self {
        RealmProvider.save(items: friends)
        
        // сортировка и обновление интерфейса в главном потоке
        DispatchQueue.main.async {
          //self.friendList = self.friendList.sorted() // TODO: Sort
          self.searchFriendList = self.friendList
          self.tableView.reloadData()
        }
      }
    }
    
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    if let realm = try? Realm(configuration: config) {
      friendList = realm.objects(Friend.self)
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Realm Notification Friend List
    notificationToken = friendList?.observe{ changes in
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
  
  
  // numberOfRowsInSection
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchFriendList?.count ?? 0
  }
  
  
  // dequeueReusableCell
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserFriends", for: indexPath) as? UserFriendCell,
      let friend = searchFriendList?[indexPath.row] else { return UITableViewCell() }
    
    cell.configure(with: friend)

    return cell
  }
  
}
  
extension UserFriendController {
  // Segue переход к фотографиям пользователя
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendInfo" {
      
      // segue destination source - куда/откуда передаем данные
      let friendImageController = segue.destination as! FriendImageController
      let userFriendController = segue.source as! UserFriendController
      
      // определяем выбранного пользователя
      guard let indexPath = userFriendController.tableView.indexPathForSelectedRow else { return }
      // отправляем Friend Id в коллекцию friendImageController
      if let friend = searchFriendList?[indexPath.row] {
        friendImageController.selectedFriendId = friend.id
      }
      
      
    }
  }
}

// // TODO: SearchBar
//extension UserFriendController {
//  // SearchBar
//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    // очищаем фильтр, если запрос пустой
//    guard !searchText.isEmpty else {
//      searchFriendList = friendList
//      tableView.reloadData()
//      return
//    }
//
//    // фильтр по lowercase в имени и фамилии
//    searchFriendList = friendList.filter({ user -> Bool in
//      //let namesurname = (user.name.lowercased() + user.surname.lowercased())
//      return (user.first_name.lowercased() + user.last_name.lowercased()).contains(searchText.lowercased())
//    })
//    tableView.reloadData()
//
//  }
//}
