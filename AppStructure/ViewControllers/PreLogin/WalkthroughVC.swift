//
//  WalkthroughVC.swift
//  AppStructure
//
//  Created by Admin on 01/09/21.
//

import UIKit

class WalkthroughVC: UIViewController {
    
    //MARK: Properties
    var titles = ["Simple Shopping","Cheap Shoping","Just use your Phone"]
    var body = ["Scan or search products so make shopping lists and share with family and friend","Get coupons so make you shopping cheaper and scan them at checkout","Replace your massy physical card today and just use your phone"]
    
    //MARK: IBOutlet
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var letsGo: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        letsGo.isHidden = true
        self.collectionView.registerCell(with: WalkthroughCollectionCell.self)
    }
    
    //MARK: PrivateFunction
    private func imageAnimation(_ imageView:UIImageView,_ index: Int) {
        switch index {
        case 0: imageView.animationImages = [UIImage(named: "img1"),UIImage(named: "img2")] as? [UIImage]
        case 1: imageView.animationImages = [UIImage(named: "img3"),
                                             UIImage(named: "img4"),UIImage(named: "img5")] as? [UIImage]
        default:imageView.animationImages = [UIImage(named: "img6"),UIImage(named: "img7")] as? [UIImage]
        }
        imageView.animationDuration = 2
        imageView.startAnimating()
        imageView.image = UIImage(named: "img7")
    }
    
    //MARK: IBAction
    @IBAction func letsGoButtonAction(_ sender: Any) {
        AppRouter.gotoLoginVC(vc: self)
    }
    
    @IBAction func skipButtonAction(_ sender: UIButton) {
        AppRouter.gotoLoginVC(vc: self)
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
                if visibleIndexPath!.row == 0 {
                    self.collectionView.scrollToItem(at: visibleIndexPath!, at: .left, animated: true)
        }
    }
}

//MARK: Extension for CollectionView
extension WalkthroughVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: WalkthroughCollectionCell.self, indexPath: indexPath)
        cell.titleLabel.text = titles[indexPath.row]
        cell.bodyLabel.text = body[indexPath.row]
        imageAnimation(cell.imageView,indexPath.row)
        pageControl.currentPage = indexPath.row
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            if indexPath!.row == 0 {
                backgroundView.backgroundColor = .blue
            } else if indexPath!.row == 1 {
                backgroundView.backgroundColor = .orange
            } else if indexPath!.row == 2 {
                pageControl.isHidden = true
                skipButton.isHidden = true
                nextButton.isHidden = true
                letsGo.isHidden = false
                letsGo.isUserInteractionEnabled = true
                self.backgroundView.backgroundColor = .purple
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cardView.frame.width - 8, height: cardView.frame.height - 80)
    }
    
}
