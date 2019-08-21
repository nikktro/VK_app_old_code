//
//  LikeControl.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 14/01/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit

@IBDesignable class LikeControl: UIControl {

  private let width: CGFloat = 32.0
  private let height: CGFloat = 32.0
  private let margin: CGFloat = 2.0
  
  private var counter: Int = 0
  
  private var likeView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 32, height: 32)))
  private var likeButton = UIButton(type: .custom)
  
  private lazy var likeLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.black
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 17.0)
    label.text = String(counter)
    return label
  }()
  
  private var isLiked = false {
    didSet {
      likeLabel.text = String(counter)
      if oldValue == false {
        likeLabel.textColor = UIColor.red
      } else {
        likeLabel.textColor = UIColor.black
      }
    }
  }
  
  private func setupView() {
    likeButton.setImage(UIImage(named: isLiked == true ? "liked" : "notLiked"), for: .normal)
    likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    //likeView.backgroundColor = .green
    self.addSubview(likeView)
    self.likeView.addSubview(likeButton)
    self.likeView.addSubview(likeLabel)
  }
  
  
  @objc func likeAction() {
    if !isLiked {
      counter += 1
      self.isLiked = true
      
      // Анимация лайка
      let animation = CASpringAnimation(keyPath: "transform.scale")
      animation.fromValue = 1
      animation.toValue = 4
      animation.duration = 0.1
      animation.autoreverses = true
      likeButton.layer.add(animation, forKey: nil)
      
    } else {
      counter -= 1
      self.isLiked = false
    }
    self.setupView()
    print("Счетчик: \(counter), кнопка нажата: \(isLiked)")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    likeView.frame = bounds
    likeButton.frame = CGRect(origin: .zero, size: CGSize(width: self.width + margin * 2, height: self.height))
    likeLabel.frame = CGRect(x: likeButton.frame.width, y: 0, width: self.width + margin, height: self.height)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
}
