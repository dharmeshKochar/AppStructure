//
//  AppRouter.swift
//  AppStructure
//
//  Created by Admin on 23/08/21.
//

import Foundation
import UIKit
class AppRouter {
  
    class func gotoSignupVC(vc: UIViewController) {
        let scene = SignUpVC.instantiate(fromAppStoryboard: .PreLogin)
//        scene.modalPresentationStyle = .fullScreen
//        scene.modalTransitionStyle = .partialCurl
        vc.present(scene, animated: true)
    }
    
    class func gotoWelcomeVC(vc: UIViewController) {
        let scene = WelcomeVC.instantiate(fromAppStoryboard: .PreLogin)
        vc.present(scene, animated: true)
    }
}
