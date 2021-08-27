//
//  WelcomeVC.swift
//  AppStructure
//
//  Created by Admin on 27/08/21.
//

import UIKit

class WelcomeVC: UIViewController {
    static var name = ""
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = WelcomeVC.name
    }
    
}
