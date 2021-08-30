//
//  UItableView.swift
//  AppStructure
//
//  Created by Admin on 30/08/21.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell(with identifier: UITableViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                  forCellReuseIdentifier: "\(identifier.self)")
    }
    
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath? = nil) -> T {
        if let index = indexPath {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: index) as! T
        } else {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
        }
    }
}
