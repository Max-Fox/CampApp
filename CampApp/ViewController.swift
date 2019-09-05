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
    //let backgroundImage = UIImage(named: "1.jpg")
    //var imageView: UIImageView!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection1.showsHorizontalScrollIndicator = false
        secondFoodCollectionView.showsHorizontalScrollIndicator = false
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.title = "Главная"
        setupNavigationBar()
        
        
        
        //Установкка фона картинкой
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "1.jpg"))
        
        //Прозрачный фон
        collection1.backgroundColor = UIColor(white: 1, alpha: 0)
        secondFoodCollectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        thirdCV.backgroundColor = UIColor(white: 1, alpha: 0)
        thirdCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        
        //Изображение адаптировано под фон
        //        imageView = UIImageView(frame: view.bounds)
        //        imageView.contentMode = .scaleAspectFill
        //        imageView.clipsToBounds = true
        //        imageView.image = backgroundImage
        //        imageView.center = view.center
        //        view.addSubview(imageView)
        //        self.view.sendSubviewToBack(imageView)
        //
        //        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        
        
        parceJSON()
        loadDataFromPListFile()
        
        //Создание третьей CollectionView через код
        //        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.scrollDirection = .horizontal
        //        thirdCollectionView = UICollectionView(frame: CGRect(x: 15, y: 800, width: 600, height: 300), collectionViewLayout: flowLayout)
        //
        //        thirdCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        //        thirdCollectionView.delegate = self
        //        thirdCollectionView.dataSource = self
        //
        //        scrollView.addSubview(thirdCollectionView)
        //scrollView.sizeToFit()
        pageControlThirdFood.numberOfPages = drinkFood?.count ?? 0
        
        
    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1500)
    //        print("SIZE: \(scrollView.contentSize)")
    //    }
    
    
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
            //cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1) : #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
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
        //        let detailVC = DetailViewController()
        //        detailVC.textLabel = "Test: \(indexPath.row)"
        //        navigationController?.pushViewController(detailVC, animated: true)
        
        //self.performSegueWithIdentifier("aboutHero", sender: self) вызов перехода вручную
    }
    
    func setupNavigationBar(){
        //Большой шрифт в заголовке
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    func parceJSON() {
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do{
                let json = try Data(contentsOf: url)
                foodInJSON = try JSONDecoder().decode(Foods.self, from: json)
                //Получить изображение
                // let image = UIImage(named: (textInJson.array![0].Detail?.FilePath?.name)! + (textInJson.array![0].Detail?.FilePath?.type)!)
                
                //  imageView.image = image
                //  labelName.text = textInJson.array![1].Product
                //  labelAge.text = String(describing: textInJson.array![1].Detail?.Discription)
                
            } catch let error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if (segue.identifier == "detailSegue") {
        //            //Определение, какая ячейка нажата
        //            let indexPaths = self.collection1!.indexPathsForSelectedItems
        //            let indexPath = indexPaths![0] as NSIndexPath
        //            //Конец
        //            let detailVC = segue.destination as! DetailViewController
        //
        //            detailVC.textLabel = (foodInJSON?.firstFood![indexPath.row].Product)!
        //            detailVC.aboutLabelText = (foodInJSON?.firstFood![indexPath.row].Detail?.Discription)!
        //            detailVC.textImagePath = (foodInJSON?.firstFood![indexPath.row].Detail?.ImagePath!)!
        //            detailVC.steps = (foodInJSON?.firstFood![indexPath.row].steps ?? [])
        ////
        //
        //        }
        if (segue.identifier == "detailSegue") {
            //Определение, какая ячейка нажата
            let indexPaths = self.collection1!.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as NSIndexPath
            //Конец
            let detailVC = segue.destination as! DetailTableViewController
            
            detailVC.textLabel = (foodInJSON?.firstFood![indexPath.row].Product)!
            //detailVC.aboutLabelText = (foodInJSON?.firstFood![indexPath.row].Detail?.Discription)!
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
            //print("CELL: (\(indexPath.item) \(indexPath.row))")
            pageControlThirdFood.currentPage = indexPath.row
        }
    }
    @IBAction func changeValue(_ sender: UIPageControl) {
        print("Change \(sender.currentPage)")
        thirdCV.scrollToItem(at: NSIndexPath(row: sender.currentPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    func loadDataFromPListFile(){
        let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: pathToFile!)!
        for dictionary in dataArray {
            var drink = Food()
            let drinkDictionary = dictionary as! NSDictionary
            drink.Product = drinkDictionary["Name"] as? String
            
            let detailDict = drinkDictionary["Detail"] as! NSDictionary
            drink.Detail = Detail()
            drink.Detail?.ImagePath = detailDict["ImagePath"] as? String
            drink.Detail?.Discription = detailDict["Discription"] as? String
            
            drink.Ingredients = drinkDictionary["Ingredients"] as? String
            
            drink.steps = []
            let arrayStep = drinkDictionary["Steps"] as? NSArray ?? []
            var countStep = 0
            for step in arrayStep {
                let tempStep = Step(numStep: countStep + 1, aboutStep: step as? String)
                drink.steps?.append(tempStep)
                countStep+=1
            }
            drinkFood?.append(drink)
        }
    }
}


