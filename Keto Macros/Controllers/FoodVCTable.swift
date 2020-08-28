//
//  FoodVCTable.swift
//  Keto Macros
//
//  Created by Sena A on 8/24/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

//implement search bar here

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
    
    //Sends the indices of each macro nutrient from the nutrients list, as well as the food in the list they're on, to the FoodVC (description for cell food item)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FoodVC {
            let currentFood = foodList?[(tableView.indexPathForSelectedRow?.row)!]
            destination.food = currentFood
            destination.carbsIndex = getMacro(food: currentFood!, whichMacro: "Carbohydrate, by difference")
            destination.fatsIndex = getMacro(food: currentFood!, whichMacro: "Total lipid (fat)")
            destination.proteinIndex = getMacro(food: currentFood!, whichMacro: "Protein")
        } else {
            Utilities.errorMsg("FoodVCTable.prepare(): error code 19 -> segue destination error")
        }
    }
    
    //#1: Determines number of cells that show up
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = foodList?.count {
            return count
        } else {
            Utilities.errorMsg("FoodVCTable.tableView(#1): error code 17 -> cell counting issue")
            return 1 //So at least the tableview has 1 cell
        }
    }
    
    //#2: Determines what data fills each cell
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
        } else {
            Utilities.errorMsg("FoodVCTable.tableView(#2): error code 18 -> nil cell text value")
        }
        return cell
    }
    
    //#3: Segues into the macros breakdown for a food; result of clicking a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }

    //downloads the JSON of the food data from FoodDataCentral
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=HSRXxpM567XslBGDwcjNuyup4r4DFaALp06s9BWs&query=cheese")
        
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        let dataAboutFoodSearch: FoodDataCentral = try JSONDecoder().decode(FoodDataCentral.self, from: data)
                        if !dataAboutFoodSearch.foods.isEmpty {
                            self.transferFoods(dataAboutFoodSearch: dataAboutFoodSearch)
                            DispatchQueue.main.async {
                                completed()
                            }
                        }
                    } catch {
                        Utilities.errorMsg("FoodVCTable.downloadJSON(): error code 20.1 -> error parsing JSON data: \(error)")
                    }
                } else {
                    Utilities.errorMsg("FoodVCTable.downloadJSON(): error code 20.2 -> issue downloading JSON data")
                }
            }
        }.resume()
        
    }
    
    //Gets the index in the food nutrients list of the desired macro
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
    
    //Sets the global variables to the list of foods retrieved
    func transferFoods(dataAboutFoodSearch: FoodDataCentral) {
        self.mainFoods = dataAboutFoodSearch
        self.foodList = dataAboutFoodSearch.foods
    }

}
