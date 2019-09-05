//
//  AdviceTableViewCell.swift
//  CampApp
//
//  Created by Максим Лисица on 08/06/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageViewAdvice: UIImageView!
    @IBOutlet weak var labelAdvice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewAdvice.contentMode = .scaleAspectFill
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.imageViewAdvice.layer.cornerRadius = 10
//        self.imageViewAdvice.layer.shadowOpacity = 0.3
//        self.imageViewAdvice.layer.shadowRadius = 9
//        self.imageViewAdvice.layer.shadowOffset = CGSize(width: 5, height: 8)
        self.imageViewAdvice.clipsToBounds = true
    }

}
