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
        
    }
    
    override func layoutSubviews() {
        self.imageViewAdvice.layer.cornerRadius = 10
        self.imageViewAdvice.clipsToBounds = true
    }
    
}
