//
//  ShowAllFoodCollectionViewController.swift
//  CampApp
//
//  Created by Максим Лисица on 22/05/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ShowAllFoodCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var arrayFood: [Food] = []
    var navigationTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navigationTitle
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayFood.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShowAllFoodCollectionViewCell
        
        cell.textLabelName.text = "\(arrayFood[indexPath.row].Product ?? "Нет имени")"
        cell.image.image = UIImage(named: arrayFood[indexPath.row].Detail?.ImagePath ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 215)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            //Определение, какая ячейка нажата
            let indexPaths = self.collectionView.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as NSIndexPath
            //Конец
            let detailVC = segue.destination as! DetailTableViewController
            
            detailVC.textLabel = (arrayFood[indexPath.row].Product)!
            //detailVC.aboutLabelText = (foodInJSON?.firstFood![indexPath.row].Detail?.Discription)!
            detailVC.textImagePath = (arrayFood[indexPath.row].Detail?.ImagePath!)!
            detailVC.steps = (arrayFood[indexPath.row].steps ?? [])
            detailVC.ingredients = (arrayFood[indexPath.row].Ingredients ?? "Нет описания")
            
            
        }
    }
}
