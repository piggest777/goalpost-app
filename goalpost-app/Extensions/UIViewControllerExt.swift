//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by Denis Rakitin on 27/05/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPressent:UIViewController)  {
        let transition = CATransition ()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPressent, animated: false, completion: nil)
    }
    
    func dismissDetail() {
            let transition = CATransition ()
            transition.duration = 0.3
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            self.view.window?.layer.add(transition, forKey: kCATransition)
            
            dismiss(animated: false, completion: nil)
        
        }

}
