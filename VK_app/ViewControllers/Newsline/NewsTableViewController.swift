//
//  NewsTableViewController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 22/01/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

  var news = [
    News(owner_id: 1, titleImage: UIImage(named: "news_bbc"), titleName: "POST Title", titleTime: "today at 14:00", contentText: "These excellant intentions were strengthed when he enterd the Father Superior's diniing-room, though, stricttly speakin, it was not a dining-room, for the Father Superior had only two rooms alltogether; they were, however, much larger and more comfortable than Father Zossima's. But tehre was was no great luxury about the furnishng of these rooms eithar. The furniture was of mohogany, covered with leather, in the old-fashionned style of 1820 the floor was not even stained, but evreything was shining with cleanlyness, and there were many chioce flowers in the windows; the most sumptuous thing in the room at the moment was, of course, the beatifuly decorated table. The cloth was clean, the service shone; there were three kinds of well-baked bread, two bottles of wine, two of excellent mead, and a large glass jug of kvas -- both the latter made in the monastery, and famous in the neigborhood. There was no vodka. Rakitin related afterwards that there were five dishes: fish-suop made of sterlets, served with little fish paties; then boiled fish served in a spesial way; then salmon cutlets, ice pudding and compote, and finally, blanc-mange. Rakitin found out about all these good things, for he could not resist peeping into the kitchen, where he already had a footing. He had a footting everywhere, and got informaiton about everything. He was of an uneasy and envious temper. He was well aware of his own considerable abilities, and nervously exaggerated them in his self-conceit. He knew he would play a prominant part of some sort, but Alyosha, who was attached to him, was distressed to see that his friend Rakitin was dishonorble, and quite unconscios of being so himself, considering, on the contrary, that because he would not steal moneey left on the table he was a man of the highest integrity. Neither Alyosha nor anyone else could have infleunced him in that.", contentImage: UIImage(named: "norway_mountain"), commentCount: 123, shareCount: 53, viewCount: 11443, likeCount: 233),
    News(owner_id: 1, titleImage: UIImage(named: "news_bbc"), titleName: "News Title", titleTime: "today at 12:00", contentText: "Some news", contentImage: UIImage(named: "news_01"), commentCount: 12, shareCount: 55, viewCount: 103, likeCount: 321),
    News(owner_id: 1, titleImage: UIImage(named: "news_bbc"), titleName: "News Title", titleTime: "today at 13:00", contentText: "#math #books", contentImage: UIImage(named: "news_02"), commentCount: 8, shareCount: 43, viewCount: 112, likeCount: 544)
  ]
    
  
    override func viewDidLoad() {
      super.viewDidLoad()
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return news.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
      let newsData = news[indexPath.row]
      cell.titleImage.image = newsData.titleImage!
      cell.titleName.text = newsData.titleName
      cell.titleTime.text = newsData.titleTime
      cell.contentText.text = newsData.contentText
      cell.contentImage.image = newsData.contentImage!
        cell.contentImage.clipsToBounds = true
      cell.commentCount.text = String(newsData.commentCount)
      cell.shareCount.text = String(newsData.shareCount)
      cell.viewCount.text = String(newsData.viewCount)
      
      return cell
    }



}
