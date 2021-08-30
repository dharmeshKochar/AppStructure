//
//  WelcomeVC.swift
//  AppStructure
//
//  Created by Admin on 27/08/21.
//

import UIKit

class WelcomeVC: UIViewController {
    
    //MARK:- Properties
    static var name = ""
    var profilesName: String?
    var addresses: String?
    var phone: String?
    var image: UIImage?
    var email:String?
    
    //MARK:- IBOutlet
    @IBOutlet weak var animationtableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = WelcomeVC.name
        animationtableView.delegate = self
        animationtableView.dataSource = self
        self.animationtableView.registerCell(with: animatedTableCell.self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [self] in
             profilesName = "Donald Trump"
             addresses = "Presidency Candidate United state"
             phone = "+001298374"
             email = "donald@donald.com"
             image = UIImage(named: "sample1")
             self.animationtableView.reloadData()
        })
    }
    
}

//MARK:- Extension for TableView
extension WelcomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: animatedTableCell.self, indexPath: indexPath)
        cell.nameLabel.text = profilesName
        cell.addressLabel.text = addresses
        cell.phoneNumLabel.text = phone
        cell.imageView?.image = image
        cell.emailLabel.text = email
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        132
    }
}
