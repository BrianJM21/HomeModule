//
//  HomeViewController.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    weak var presenter: HomePresenter?
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var foodCollection: UICollectionView!
    
    var foods: [FoodEntity] = []
    var selectedFood: FoodEntity?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.foodCollection.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionFoodCell")
        
        self.foodCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter?.requestFoods()
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        if let keyword = self.searchTextField.text {
            
            guard !keyword.isEmpty else { return }
            self.presenter?.searchFoods(byKeyword: keyword)
        }
    }
    
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        self.presenter?.goToAdd()
    }
    
    

}

extension HomeViewController: HomeViewDelegate {
    
    func foods(selectedFood food: FoodEntity) {
        
        self.selectedFood = food
    }
    
    func foods(foods: [FoodEntity]) {
        
        self.foods = foods
        
        self.foodCollection.reloadData()
    }
    
    func foods(filteredFoods foods: [FoodEntity]) {
        
        self.foods = foods
        
        self.foodCollection.reloadData()
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionFoodCell", for: indexPath)
        
        if let cell = cell as? HomeCollectionViewCell {
                        
            let dummy = UIImage.init(systemName: "frying.pan")?.pngData()
            
            cell.setup(title: foods[indexPath.row].name ?? "NO NAME", details: "\(foods[indexPath.row].calories) cal x \(foods[indexPath.row].unit ?? "NO DESCRIPTION")", image: UIImage(data: foods[indexPath.row].image ?? dummy!) ?? UIImage.init(systemName: "frying.pan")!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedFood = self.foods[indexPath.row]
    }
}
