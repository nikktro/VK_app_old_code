//
//  progressBar.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 24/01/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit

class ProgressBar: UIViewController {

  
  @IBOutlet weak var animationViewOne: UIView!
  @IBOutlet weak var animationViewTwo: UIView!
  @IBOutlet weak var animationViewThree: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let duration = 1.0
    progressBar(duration: duration, begin: 0, animationView: animationViewOne)
    progressBar(duration: duration, begin: duration/4, animationView: animationViewTwo)
    progressBar(duration: duration, begin: duration/2, animationView: animationViewThree)
    
  }
    

  func progressBar(duration: Double, begin: Double, animationView: UIView) {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.beginTime = CACurrentMediaTime() + CFTimeInterval(begin)
    animation.fromValue = 1
    animation.toValue = 0
    animation.duration = CFTimeInterval(duration)
    animation.repeatCount = .infinity
    animation.autoreverses = true
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    animationView.layer.cornerRadius = animationView.frame.size.height / 2
    animationView.layer.masksToBounds = true
    animationView.layer.add(animation, forKey: nil)
  }

}
