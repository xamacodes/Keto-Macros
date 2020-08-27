//
//  FoodVCTable.swift
//  Keto Macros
//
//  Created by Sena A on 8/24/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class FoodVCTable: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var mainFoods: FoodDataCentral?
    var foodList: [Food]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
//    func search() {
//        searchBar.
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = foodList?.count {
            return count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let cellText = self.foodList?[indexPath.row].description
        var temp: String?
        
        if let characters = cellText?.count {
            if characters == mainFoods?.foodSearchCriteria.query.count {
                temp = cellText
                temp?.append(" (general)")
                cell.textLabel?.text = temp?.lowercased()
            } else {
                cell.textLabel?.text = self.foodList?[indexPath.row].description.lowercased()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FoodVC {
            let currentFood = foodList?[(tableView.indexPathForSelectedRow?.row)!]
            destination.food = currentFood
            destination.carbsIndex = getMacro(food: currentFood!, whichMacro: "Carbohydrate, by difference")
            destination.fatsIndex = getMacro(food: currentFood!, whichMacro: "Total lipid (fat)")
            destination.proteinIndex = getMacro(food: currentFood!, whichMacro: "Protein")
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=HSRXxpM567XslBGDwcjNuyup4r4DFaALp06s9BWs&query=cheese")
        
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        let foods: FoodDataCentral = try JSONDecoder().decode(FoodDataCentral.self, from: data)
                        if !foods.foods.isEmpty {
                            self.transferFoods(foods: foods)
                            DispatchQueue.main.async {
                                completed()
                            }
                        }
                    } catch {
                        print("JSON parsing error: ", error)
                    }
                }
            }
        }.resume()
        
    }
    
    func getMacro(food: Food, whichMacro: String) -> Int {
        var count = -1
        for nutrient in food.foodNutrients {
            count += 1
            if nutrient.nutrientName == whichMacro {
                break
            }
        }
        return count //Returns -1 if carbs error
    }
    
    func transferFoods(foods: FoodDataCentral) {
        self.mainFoods = foods
        self.foodList = foods.foods
    }

}
