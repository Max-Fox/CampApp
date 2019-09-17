//
//  FullAdviceViewController.swift
//  CampApp
//
//  Created by Максим Лисица on 08/06/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

class FullAdviceViewController: UIViewController {

    @IBOutlet weak var imageViewAdvice: UIImageView!
    @IBOutlet weak var titleAdviceLable: UILabel!
    @IBOutlet weak var aboutAdviceLabel: UILabel!
    @IBOutlet weak var navigationItemTitle: UINavigationItem!
    
    
    var textTitleLabel: String = ""
    var textAboutLabel: String = ""
    var textImageView: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItemTitle.title = textTitleLabel
        
        
        
        // Do any additional setup after loading the view.
        titleAdviceLable.text = textTitleLabel
        aboutAdviceLabel.text = textAboutLabel
        imageViewAdvice.image = UIImage(named: textImageView)
        
        aboutAdviceLabel.sizeToFit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
