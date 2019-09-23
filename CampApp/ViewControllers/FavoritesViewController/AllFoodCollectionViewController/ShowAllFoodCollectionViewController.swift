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
    
    // MARK: - UICollectionViewDataSource
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
        if segue.identifier == "detailSegue" {
            //Определение, какая ячейка нажата
            let indexPaths = self.collectionView.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as NSIndexPath
            
            let detailVC = segue.destination as! DetailTableViewController
            detailVC.textLabel = (arrayFood[indexPath.row].Product)!
            detailVC.textImagePath = (arrayFood[indexPath.row].Detail?.ImagePath!)!
            detailVC.steps = (arrayFood[indexPath.row].steps ?? [])
            detailVC.ingredients = (arrayFood[indexPath.row].Ingredients ?? "Нет описания")
            detailVC.delegate = self
            
        }
    }
}

extension ShowAllFoodCollectionViewController: DetailTableViewDelegate {
    
    func didPressInfoButton(message: String) {
        let ac = UIAlertController(title: "Ингредиенты", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    func didPressAddToFavoritesButton(favoriteFoods: inout [FavoriteFood], textLabel: String, icon: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        var indexFood = 0
        var check = 0
        for i in 0..<favoriteFoods.count {
            if favoriteFoods[i].foodName == textLabel {
                check = 1
                indexFood = i
            }
        }
        if check == 0 {
            icon.setImage(UIImage(named: "favorite"), for: .normal)
            saveFood(foodName: textLabel, favoriteFood: &favoriteFoods)
            appDelegate?.sheldureNotification(notificationTitle: "Сохранено в CoreData", notificationContent: #"Рецепт "\#(textLabel)" сохранен"#)
        } else {
            deleteFood(indexFood: indexFood, favoriteFood: &favoriteFoods)
            icon.setImage(UIImage(named: "notfavorite"), for: .normal)
            appDelegate?.sheldureNotification(notificationTitle: "Удалено из CoreData", notificationContent: #"Рецепт "\#(textLabel)" удален"#)
        }
    }
}
