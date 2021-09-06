//
//  LearnMoreCategoryCell.swift
//  AppStructure
//
//  Created by Admin on 03/09/21.
//

import UIKit

class LearnMoreCategoryCell: UICollectionViewCell {

    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var category: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.isHidden = true
    }

}
