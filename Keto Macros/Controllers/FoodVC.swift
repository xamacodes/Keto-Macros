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
    
    //Sets up the initial view
    func setupView() {
        displayNutrientLbls(macroIndex: fatsIndex, whichMacro: "fats")
        displayNutrientLbls(macroIndex: proteinIndex, whichMacro: "protein")
        displayNutrientLbls(macroIndex: carbsIndex, whichMacro: "carbs")
    }
    
    //Gives macro details about the food selected from the table view vc
    func displayNutrientLbls(macroIndex: Int?, whichMacro: String) {
        if let macro = food?.foodNutrients[macroIndex!].value, let macroUnits = food?.foodNutrients[macroIndex!].unitName {
            
            var macroText = "\(macro)"
            macroText.append(macroUnits.lowercased())
            
            if whichMacro == "fats" {
                fatsLbl.text = macroText
            } else if whichMacro == "protein" {
                proteinLbl.text = macroText
            } else if whichMacro == "carbs" {
                carbsLbl.text = macroText
            }
        } else {
            Utilities.errorMsg("FoodVC.displayNutrientLbls(): error code 16 -> prepare for segue transfer of data")
        }
    }
    
}
