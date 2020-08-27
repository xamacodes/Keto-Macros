//
//  FoodVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/24/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class FoodVC: UIViewController {

    @IBOutlet weak var fatsLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var carbsLbl: UILabel!
    var fatsIndex: Int?
    var proteinIndex: Int?
    var carbsIndex: Int?
    
    var food: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        displayNutrientLbls()
    }
    
    func displayNutrientLbls() {
        if let fats = food?.foodNutrients[fatsIndex!].value, let protein = food?.foodNutrients[proteinIndex!].value, let carbs = food?.foodNutrients[carbsIndex!].value {
            if let fatsUnits = food?.foodNutrients[fatsIndex!].unitName, let proteinUnits = food?.foodNutrients[proteinIndex!].unitName, let carbsUnits = food?.foodNutrients[carbsIndex!].unitName {
                
                var fatsText = "\(fats)"
                fatsText.append(fatsUnits.lowercased())
                fatsLbl.text = fatsText
                
                var proteinText = "\(protein)"
                proteinText.append(proteinUnits.lowercased())
                proteinLbl.text = proteinText
                
                var carbsText = "\(carbs)"
                carbsText.append(carbsUnits.lowercased())
                carbsLbl.text = carbsText
            }
        }
    }
    
    
}
