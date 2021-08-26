//
//  Alert.swift
//  EditProfile
//
//  Created by Admin on 02/08/21.
//

import Foundation
import UIKit

struct Alert {
    static func sendAlert(_ vc: UIViewController,_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        vc.present(alert,animated:true)
  }
}
