//
//  NintyDegreePushAnimator.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 03/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit


final class NintyDegreePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let source = transitionContext.viewController(forKey: .from) else { return }
    guard let destination = transitionContext.viewController(forKey: .to) else { return }
    
    transitionContext.containerView.addSubview(destination.view)
    destination.view.frame = source.view.frame

    let shift = CGAffineTransform(translationX: destination.view.frame.height / 2 + destination.view.frame.width / 2 , y: destination.view.frame.width / 2)
    let rotate = CGAffineTransform(rotationAngle: (CGFloat(-Double.pi/2)))
    destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    destination.view.transform = shift.concatenating(rotate)
    
    UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                            delay: 0,
                            options: .calculationModePaced,
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0,
                                                 relativeDuration: 0.75,
                                                 animations: {
                                                  let translation = CGAffineTransform(translationX: -200, y: 0)
                                                  let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                                  source.view.transform = translation.concatenating(scale)
                                                  
                              })
                              UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                 relativeDuration: 0.5,
                                                 animations: {
                                                  let translation = CGAffineTransform(translationX: 0, y: -destination.view.frame.width / 2)
                                                  let rotate = CGAffineTransform(rotationAngle: 0)
                                                  destination.view.transform = translation.concatenating(rotate)
                              })
    }) { finished in
      if finished && !transitionContext.transitionWasCancelled {
        source.view.transform = .identity
      }
      transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
    }
  }
}
