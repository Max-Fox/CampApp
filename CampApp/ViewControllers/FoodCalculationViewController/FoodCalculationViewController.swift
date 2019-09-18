//
//  FoodCalculationViewController.swift
//  CampApp
//
//  Created by Максим Лисица on 08/06/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

class FoodCalculationViewController: UIViewController {
    
    @IBOutlet weak var pickerViewTypeFood: UIPickerView!
    var typeFood = ["Первые блюда", "Вторые блюда", "Напитки"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad FoodCalculationViewController")
        
        setupNavigationBar(withTitle: "Раскладка", large: true)
        
        pickerViewTypeFood.dataSource = self
        pickerViewTypeFood.delegate = self
    }
    
    @IBAction func calcButtonAction(_ sender: Any) {
        print("Selected: \(typeFood[pickerViewTypeFood.selectedRow(inComponent: 0)])")
        
    }
}

extension FoodCalculationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeFood.count
    }
    
    
}
extension FoodCalculationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeFood[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
