//
//  animatedTableCell.swift
//  AppStructure
//
//  Created by Admin on 30/08/21.
//

import UIKit

class AnimatedTableCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emailLabel.addGradient()
        phoneNumLabel.addGradient()
        addressLabel.addGradient()
        nameLabel.addGradient()
        profileImageView.addGradient()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
