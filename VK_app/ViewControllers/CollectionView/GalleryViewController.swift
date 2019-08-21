//
//  GalleryViewController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 31/01/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

// TODO поменять имя userGallery
private let reuseIdentifier = "userGallery"



class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // TODO: поменять имя galleryFoto
  // TODO: Подгрузить качественные фото
  var galleryFoto = [IndexPath]()
  var galleryFotoArray: Results<FriendPhoto>?
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let screenSize = UIScreen.main.bounds.size
    let cellWidth = floor(screenSize.width)
    let cellHeigth = floor(screenSize.height / 2)
    let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: cellWidth, height: cellHeigth)
  }
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    DispatchQueue.main.async {
      //self.collectionView.scrollToItem(at: 3, section: 0), at: .centeredHorizontally, animated: false)
      self.collectionView.scrollToItem(at: self.galleryFoto[0], at: .centeredHorizontally, animated: false)
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return galleryFotoArray?.count ?? 0
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryViewCell,
      let gallery = galleryFotoArray?[indexPath.row] else { return UICollectionViewCell() }
    cell.configure(with: gallery.url)
    return cell
  }

}
