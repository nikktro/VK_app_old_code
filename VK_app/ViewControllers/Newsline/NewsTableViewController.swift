//
//  NewsTableViewController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 22/01/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit
import RealmSwift

class NewsTableViewController: UITableViewController {

  //TODO: Remove HardCoded
  var news = [
    News(owner_id: 1, titleImage: UIImage(named: "news_bbc"), titleName: "POST Title", titleTime: "today at 14:00", contentText: "Some Text", contentImage: UIImage(named: "norway_mountain"), commentCount: 123, shareCount: 53, viewCount: 11443, likeCount: 233),
    News(owner_id: 1, titleImage: UIImage(named: "news_bbc"), titleName: "News Title", titleTime: "today at 12:00", contentText: "Some news", contentImage: UIImage(named: "news_01"), commentCount: 12, shareCount: 55, viewCount: 103, likeCount: 321),
    News(owner_id: 1, titleImage: UIImage(named: "news_bbc"), titleName: "News Title", titleTime: "today at 13:00", contentText: "#math #books", contentImage: UIImage(named: "news_02"), commentCount: 8, shareCount: 43, viewCount: 112, likeCount: 544)
  ]
  
  private var newsfeedList: Results<Newsfeed>?
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.estimatedRowHeight = 80
    self.tableView.rowHeight = UITableView.automaticDimension
  }
  
  // TODO: Notification
  override func viewDidAppear(_ animated: Bool) {
    
    // Постановка запроса в очередь
    DispatchQueue.global().async {
      // Запрос к API Newsfeed
      let vkService = VKService()
      vkService.apiNewsfeed() { [weak self] newsfeed, error in
        if let error = error {
          // TODO: правильно через extenssion выдавать пользователю alert
          print(error.localizedDescription)
          return
        } else if let newsfeed = newsfeed, let self = self {
          RealmProvider.save(items: newsfeed)
          
          // чтение данных из Realm
          let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
          if let realm = try? Realm(configuration: config) {
            self.newsfeedList = realm.objects(Newsfeed.self).sorted(byKeyPath: "date", ascending: false)
          }
          // Обновление данных
          self.tableView.reloadData()
        }
      }
    }
  }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return newsfeedList?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell,
        let realmNews = newsfeedList?[indexPath.row] else { return UITableViewCell() }
      let newsData = news[0]
      
      // TODO: Remove HardCoded
        //cell.titleImage.image = newsData.titleImage!
        cell.titleName.text = newsData.titleName
      cell.titleTime.text = "\(String((Int(Date().timeIntervalSince1970) - realmNews.date) / 60 )) минут назад"
      cell.contentText.text = newsData.contentText
        cell.contentText.text = realmNews.text
        //cell.contentImage.image = newsData.contentImage!
        cell.contentImage.clipsToBounds = true
        cell.commentCount.text = String(newsData.commentCount)
        cell.shareCount.text = String(newsData.shareCount)
        cell.viewCount.text = String(newsData.viewCount)
      
      return cell
    }
}
