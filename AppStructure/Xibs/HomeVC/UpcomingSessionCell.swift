//
//  UpcomingSessionCell.swift
//  AppStructure
//
//  Created by Admin on 03/09/21.
//

import UIKit

class UpcomingSessionCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 4
    }

}
