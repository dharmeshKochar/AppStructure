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
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var menuBarView: UIView!
    @IBOutlet weak var menuButtonStack: UIStackView!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
       
    }
    
    func initialSetup() {
        nameLabel.text = WelcomeVC.name
        animationtableView.delegate = self
        animationtableView.dataSource = self
        self.animationtableView.registerCell(with: AnimatedTableCell.self)
        tabBarView.layer.cornerRadius = 24
        tabBarView.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [self] in
             profilesName = "Donald Trump"
             addresses = "Presidency Candidate United state"
             phone = "+001298374"
             email = "donald@donald.com"
             image = UIImage(named: "sample1")
             self.animationtableView.reloadData()
        })
        createTabBar()
        menuBarView.isHidden = true
        menuButtonStack.layer.cornerRadius = 32
        menuButtonStack.layer.masksToBounds = true
    }
    
    func createTabBar(){
        let path  = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        let width = (tabBarView.frame.width ) / 3 
        path.addLine(to: CGPoint(x: width - 15  , y: 0))
        path.addArc(withCenter:CGPoint(x: view.center.x - 15 , y: -15) , radius: (tabBarView.frame.width / 3)/2 , startAngle: -CGFloat.pi , endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: 3*width , y: 0))
        path.addLine(to: CGPoint(x: tabBarView.frame.width , y: tabBarView.frame.height))
        path.addLine(to: CGPoint(x: 0 , y: tabBarView.frame.height ))
        path.addLine(to: CGPoint(x: 0, y: 0))
        let shapLayer = CAShapeLayer()
        shapLayer.path = path.cgPath
        shapLayer.cornerRadius = 20
        shapLayer.fillColor = UIColor.white.cgColor
        tabBarView.layer.insertSublayer(shapLayer, at: 0)
        tabBarView.layer.cornerRadius = 20
        tabBarView.clipsToBounds = true
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        cameraButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        galleryButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        messageButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        cancelButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        UIView.animate(withDuration: 0.3) { [self] in
            menuButtonStack.transform = CGAffineTransform(scaleX: 0.5, y: 1)
        } completion: { [self] _ in
            plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            UIView.animate(withDuration: 0.3) {
                menuBarView.isHidden = true
                plusButton.transform = CGAffineTransform(translationX: 0, y: 8)
            }
        }
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5){
            self.plusButton.transform = CGAffineTransform(translationX: 0, y: -42)
        } completion: { [self] _ in
            plusButton.imageEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
            plusButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                menuBarView.isHidden = false
                menuButtonStack.transform = CGAffineTransform(scaleX: 2.5, y: 1)
            } completion: { _ in
                cameraButton.setImage(UIImage(systemName: "camera"), for: .normal)
                galleryButton.setImage(UIImage(systemName: "heart"), for: .normal)
                messageButton.setImage(UIImage(systemName: "message"), for: .normal)
                cancelButton.setImage(UIImage(systemName: "multiply"), for: .normal)
            }
        }
    }
     
}

//MARK:- Extension for TableView
extension WelcomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: AnimatedTableCell.self, indexPath: indexPath)
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
