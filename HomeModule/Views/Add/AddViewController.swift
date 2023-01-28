//
//  AddViewController.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import UIKit

class AddViewController: UIViewController {

    weak var presenter: AddPresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        let dummy = Data()
        
        // DummyTest
        
        self.presenter?.createFood(name: "dummy", calories: 10.0, fats: 10.0, sugars: 10.0, fiber: 10.0, carbs: 10.0, proteins: 10.0, unit: "dummy unit", factor: 10.0, image: dummy)
        
    }
    
}

extension AddViewController: AddViewDelegate {
    
    func foods(foodCreated food: FoodEntity) {
        
        self.presenter?.closeAdd()
        
    }
    
}
