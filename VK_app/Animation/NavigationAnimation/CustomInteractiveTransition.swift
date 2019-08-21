//
//  CustomInteractiveTransition.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 03/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit


class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
  
  var viewController: UIViewController? {
    didSet {
      // жест по границе экрана
      let recognizer = UIScreenEdgePanGestureRecognizer(target: self,
                                                        action: #selector(handleScreenEdgeGesture(_:)))
      // жест слева - граница экрана слева
      recognizer.edges = [.left]
      
      // добавляем на вьюшку внутри view controller
      viewController?.view.addGestureRecognizer(recognizer)
    }
  }
  
  
  var hasStarted: Bool = false
  var shouldFinish: Bool = false
  
  @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
    switch recognizer.state {
    case .began:
      self.hasStarted = true
      self.viewController?.navigationController?.popViewController(animated: true)
    case .changed:
      let translation = recognizer.translation(in: recognizer.view)
      let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
      let progress = max(0, min(1, relativeTranslation))
      
      self.shouldFinish = progress > 0.33
      
      self.update(progress)
    case .ended:
      self.hasStarted = false
      self.shouldFinish ? self.finish() : self.cancel()
    case .cancelled:
      self.hasStarted = false
      self.cancel()
    default: return
    }
  }
  
  
}
