//
//  FriendImageController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 28/12/2018.
//  Copyright © 2018 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

private let reuseIdentifier = "userPhoto"

class FriendImageController: UICollectionViewController {
  
  var selectedFriendId: Int = 0
  var friendPhoto: Results<FriendPhoto>?
  let realm = try! Realm()
  
  var notificationToken: NotificationToken?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // VKService Friend Photo
    let vkService = VKService()

    vkService.apiUserFriendPhoto(for: selectedFriendId) { [weak self] friendPhoto, error in
      if let error = error {
        // TODO: правильно через extenssion выдавать пользователю alert
        print(error.localizedDescription)
        return
      } else if let friendPhoto = friendPhoto, let self = self {
        
        let realm = try! Realm()
        let user = realm.object(ofType: Friend.self, forPrimaryKey: self.selectedFriendId)
        
        // TODO: Generic
        try? realm.write {
          realm.add(friendPhoto, update: true)
          user?.friendPhoto.append(objectsIn: friendPhoto)
        }
        

        // сортировка и обновление интерфейса в главном потоке
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
    
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    if let realm = try? Realm(configuration: config) {
      friendPhoto = realm.objects(FriendPhoto.self).filter("ANY friend.id == %@", selectedFriendId)
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Realm Notification Friend Gallery
    notificationToken = friendPhoto?.observe{ changes in
      switch changes {
      case .initial(_):
        break
      case .update( _, _, _, _):
        self.collectionView.reloadData()
      case .error(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    notificationToken?.invalidate()
  }
  
}


// Collection View Friend
extension FriendImageController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // Будет отображаться одна секция
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // Количество Item определяет размер массива
    return friendPhoto?.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // создаем экземпляр cell для отображения в Collection Reusable View с id "userPhoto", приводим к FriendImageCell
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FriendImageCell,
      let friendPhotoLet = friendPhoto?[indexPath.row] else { return UICollectionViewCell() }
    cell.configure(with: friendPhotoLet.url)
    return cell
  }
  
}


// Segue to Gallery
extension FriendImageController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FriendPhotoGallery" {
      let friendImageController = segue.source as! FriendImageController
      let galleryViewController = segue.destination as! GalleryViewController
      
      guard let indexPath = friendImageController.collectionView.indexPathsForSelectedItems,
       let friendPhoto = friendPhoto else { return }
      galleryViewController.galleryFoto = indexPath
      galleryViewController.galleryFotoArray = friendPhoto
    }
  }
}
