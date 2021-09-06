//
//  HomeVC.swift
//  AppStructure
//
//  Created by Admin on 03/09/21.
//

import UIKit

class HomeVC: UIViewController {
    
    var categories = ["Recommended","Body Image","Communication","Mythbusters","Session"]
    
    @IBOutlet weak var todaySessionCollectionView: UICollectionView!
    @IBOutlet weak var upcomingSessionCollectionView: UICollectionView!
    @IBOutlet weak var learnMoreCategoryCollectionView: UICollectionView!
    @IBOutlet weak var learnMoreSelectedCategoryCollectionView: UICollectionView!
    @IBOutlet weak var supportCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todaySessionCollectionView.registerCell(with: TodaySessionCell.self)
        upcomingSessionCollectionView.registerCell(with: UpcomingSessionCell.self)
        learnMoreCategoryCollectionView.registerCell(with: LearnMoreCategoryCell.self)
        learnMoreSelectedCategoryCollectionView.registerCell(with: LearnMoreSelectedCategoryCell.self)
        supportCollectionView.registerCell(with: SupportCell.self)
    }
}

//MARK: Extension for CollectionView
extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case todaySessionCollectionView: return 1
        case upcomingSessionCollectionView: return 4
        case learnMoreCategoryCollectionView: return 5
        case learnMoreSelectedCategoryCollectionView: return 4
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case todaySessionCollectionView: return collectionView.dequeueCell(with: TodaySessionCell.self, indexPath: indexPath)
        case upcomingSessionCollectionView: return collectionView.dequeueCell(with: UpcomingSessionCell.self, indexPath: indexPath)
        case learnMoreCategoryCollectionView:
            let cell = collectionView.dequeueCell(with: LearnMoreCategoryCell.self, indexPath: indexPath)
            cell.category.text = categories[indexPath.row]
            return cell
        case learnMoreSelectedCategoryCollectionView: return collectionView.dequeueCell(with: LearnMoreSelectedCategoryCell.self, indexPath: indexPath)
        default: return collectionView.dequeueCell(with: SupportCell.self, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case todaySessionCollectionView: return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case upcomingSessionCollectionView: return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        case learnMoreCategoryCollectionView: return CGSize(width: 80, height: collectionView.frame.height)
        case learnMoreSelectedCategoryCollectionView: return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        default: return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == learnMoreCategoryCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as? LearnMoreCategoryCell
            cell?.selectedView.isHidden = false
            collectionView.reloadData()
        }
    }
}
