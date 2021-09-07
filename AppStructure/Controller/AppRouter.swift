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
        vc.present(scene, animated: true)
    }
    
    class func gotoLoginVC(vc: UIViewController) {
        let scene = LoginVC.instantiate(fromAppStoryboard: .PreLogin)
        vc.present(scene, animated: true)
    }
    
    
    class func gotoWelcomeVC(vc: UIViewController) {
        let scene = WelcomeVC.instantiate(fromAppStoryboard: .PostLogin)
        vc.present(scene, animated: true)
    }
    
    class func gotoMapVC(vc: UIViewController) {
        let scene = MapVC.instantiate(fromAppStoryboard: .PostLogin)
        vc.present(scene, animated: true)
    }
    
    class func gotoHomeVC(vc: UIViewController) {
        let scene = HomeVC.instantiate(fromAppStoryboard: .PostLogin)
        vc.present(scene, animated: true)
    }
}
