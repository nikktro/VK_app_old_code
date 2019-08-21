//
//  NintyDegreeNavigationController.swift
//  VK_app
//
//  Created by Nikolay.Trofimov on 03/02/2019.
//  Copyright © 2019 Nikolay.Trofimov. All rights reserved.
//

import UIKit


class NintyDegreeNavigationController: UINavigationController, UINavigationControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
  
  // CustomInteractiveTransition жест по границе экрана
  let interactiveTransition = CustomInteractiveTransition()
  
  func navigationController(_ navigationController: UINavigationController,
                            interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
      return interactiveTransition.hasStarted ? interactiveTransition : nil
  }
  
  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationController.Operation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      if operation == .push {
        self.interactiveTransition.viewController = toVC
        return NintyDegreePushAnimator()
      }
      return nil
  }
}
