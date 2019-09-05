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

        
        navigationItem.title = navigationTitle
        //navigationController?.navigationBar.prefersLargeTitles = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(ShowAllFoodCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayFood.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShowAllFoodCollectionViewCell
    
        cell.textLabelName.text = "\(arrayFood[indexPath.row].Product ?? "Нет имени")"
        cell.image.image = UIImage(named: arrayFood[indexPath.row].Detail?.ImagePath ?? "")
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 185, height: 215)
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
            //
            
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
