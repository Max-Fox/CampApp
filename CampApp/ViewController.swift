//
//  ViewController.swift
//  CampApp
//
//  Created by Максим Лисица on 14/05/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var secondFoodCollectionView: UICollectionView!
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var thirdCV: UICollectionView!
    @IBOutlet weak var pageControlThirdFood: UIPageControl!
    
    
    var foodInJSON: Foods?
    var drinkFood: [Food]? = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupCollectionsView()
        setupNavigationBar(withTitle: "Главная", large: true)
        
        //ManagerLoadData
        parceJSONFoodRecipe(in: &foodInJSON)
        loadDrinkRecipeFromPListFile(in: &drinkFood)
        
        pageControlThirdFood.numberOfPages = drinkFood?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collection1) {
            return foodInJSON?.firstFood?.count ?? 0
        } else if (collectionView == thirdCV) {
            return drinkFood?.count ?? 0
        }
        else {
            return foodInJSON?.secondFood?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collection1) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.label.text = foodInJSON?.firstFood![indexPath.row].Product
            
            
            //Проверка на наличие ImagePath в JSON
            if (foodInJSON?.firstFood != nil) {
                if (foodInJSON?.firstFood![indexPath.row] != nil) {
                    if (foodInJSON?.firstFood![indexPath.row].Detail != nil) {
                        if (foodInJSON?.firstFood![indexPath.row].Detail!.ImagePath != nil) {
                            cell.image.image = UIImage(named: (foodInJSON?.firstFood![indexPath.row].Detail!.ImagePath)!)
                        }
                    }
                }
            }
            
            
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            return cell
            
        } else if (collectionView == thirdCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            
            cell.label.text = drinkFood![indexPath.row].Product
            cell.image.image = UIImage(named: drinkFood![indexPath.row].Detail?.ImagePath ?? "null")
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.label.text = foodInJSON?.secondFood![indexPath.row].Product
            
            
            //Проверка на наличие ImagePath в JSON
            if (foodInJSON?.secondFood != nil) {
                if (foodInJSON?.secondFood![indexPath.row] != nil) {
                    if (foodInJSON?.secondFood![indexPath.row].Detail != nil) {
                        if (foodInJSON?.secondFood![indexPath.row].Detail!.ImagePath != nil) {
                            cell.image.image = UIImage(named: (foodInJSON?.secondFood![indexPath.row].Detail!.ImagePath)!)
                        }
                    }
                }
            }
            
            
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
            return cell
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView != thirdCV) {
            return CGSize(width: 200, height: 200)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath)")
        if(collectionView == secondFoodCollectionView){
            let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailSB") as! DetailTableViewController
            detailVC.textLabel = foodInJSON?.secondFood![indexPath.row].Product ?? "Без названия"
            detailVC.textImagePath = (foodInJSON?.secondFood![indexPath.row].Detail?.ImagePath!)!
            detailVC.steps = foodInJSON?.secondFood![indexPath.row].steps ?? []
            detailVC.ingredients = foodInJSON?.secondFood![indexPath.row].Ingredients ?? "Нет описания"
            navigationController?.pushViewController(detailVC, animated: true)
        }
        if(collectionView == thirdCV){
            let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailSB") as! DetailTableViewController
            detailVC.textLabel = drinkFood?[indexPath.row].Product ?? "Нет названия"
            detailVC.textImagePath = drinkFood?[indexPath.row].Detail?.ImagePath ?? "Нет фото"
            detailVC.steps = drinkFood?[indexPath.row].steps ?? []
            detailVC.ingredients = drinkFood?[indexPath.row].Ingredients ?? "Нет данных"
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func setupCollectionsView(){
        collection1.showsHorizontalScrollIndicator = false
        secondFoodCollectionView.showsHorizontalScrollIndicator = false
        
        //Прозрачный фон
        collection1.backgroundColor = UIColor(white: 1, alpha: 0)
        secondFoodCollectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        thirdCV.backgroundColor = UIColor(white: 1, alpha: 0)
        thirdCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            //Определение, какая ячейка нажата
            let indexPaths = self.collection1!.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as NSIndexPath
            //Конец
            let detailVC = segue.destination as! DetailTableViewController
            
            detailVC.textLabel = (foodInJSON?.firstFood![indexPath.row].Product)!
            detailVC.textImagePath = (foodInJSON?.firstFood![indexPath.row].Detail?.ImagePath!)!
            detailVC.steps = (foodInJSON?.firstFood![indexPath.row].steps ?? [])
            detailVC.ingredients = (foodInJSON?.firstFood![indexPath.row].Ingredients ?? "Нет описания")
        }
        if (segue.identifier == "ShowAllFirstFoodSegue") {
            print("Yes")
            let showAllVC = segue.destination as! ShowAllFoodCollectionViewController
            
            showAllVC.arrayFood = foodInJSON?.firstFood ?? []
            showAllVC.navigationTitle = navigationTitle.text
        }
    }
    @IBAction func showAllSecondFood(_ sender: Any) {
        let showAllController = storyboard?.instantiateViewController(withIdentifier: "ShowAllFood") as! ShowAllFoodCollectionViewController
        showAllController.arrayFood = foodInJSON?.secondFood ?? []
        showAllController.navigationTitle = "Вторые блюда"
        navigationController?.pushViewController(showAllController, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(collectionView == thirdCV){
            pageControlThirdFood.currentPage = indexPath.row
        }
    }
    
    @IBAction func changeValue(_ sender: UIPageControl) {
        thirdCV.scrollToItem(at: NSIndexPath(row: sender.currentPage, section: 0) as IndexPath, at: .right, animated: true)
    }
}


