//
//  SwipeRightToPopViewController.swift
//  SwipeRightToPopController
//
//  Created by Warif Akhand Rishi on 2/19/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

import UIKit

class SwipeRightToPopViewController: UIViewController {

    var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addGesture()
    }
    
    func addGesture() {
        
        guard navigationController?.viewControllers.count > 1 else {
            return
        }
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        let percent = max(panGesture.translationInView(view).x, 0) / view.frame.width
        
        switch panGesture.state {
            
        case .Began:
            navigationController?.delegate = self
            navigationController?.popViewControllerAnimated(true)
            
        case .Changed:
            if let percentDrivenInteractiveTransition = percentDrivenInteractiveTransition {
                percentDrivenInteractiveTransition.updateInteractiveTransition(percent)
            }
            
        case .Ended:
            let velocity = panGesture.velocityInView(view).x
            
            // Continue if drag more than 50% of screen width or velocity is higher than 1000
            if percent > 0.5 || velocity > 1000 {
                percentDrivenInteractiveTransition.finishInteractiveTransition()
            } else {
                percentDrivenInteractiveTransition.cancelInteractiveTransition()
            }
            
        case .Cancelled, .Failed:
            percentDrivenInteractiveTransition.cancelInteractiveTransition()
            
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension SwipeRightToPopViewController: UINavigationControllerDelegate {

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideAnimatedTransitioning()
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        navigationController.delegate = nil
        
        if panGestureRecognizer.state == .Began {
            percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            percentDrivenInteractiveTransition.completionCurve = .EaseOut
        } else {
            percentDrivenInteractiveTransition = nil
        }
        
        return percentDrivenInteractiveTransition
    }
}
