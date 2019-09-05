//
//  NormalizeTableViewCell.swift
//  CampApp
//
//  Created by Максим Лисица on 12/06/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

class NormalizeTableViewCell: UITableViewCell {
    @IBOutlet weak var TitleNormalizeLabel: UILabel!
    @IBOutlet weak var sizeInPvdLabel: UILabel!
    @IBOutlet weak var sizeInSummerLabel: UILabel!
    @IBOutlet weak var sizeInWinterLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        TitleNormalizeLabel.sizeToFit()
    }
}
