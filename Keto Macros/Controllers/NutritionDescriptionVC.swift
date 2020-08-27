//
//  NutritionDescriptionVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/17/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class NutritionDescriptionVC: UIViewController {
    
    @IBOutlet weak var desc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        determineLbl()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func getData(macro: String) -> Int {
        if macro == "fats" {
            if let fatsCals = UserDefaults.standard.object(forKey: "fats in cals") as? Double {
                let fatsGrams = fatsCals / 9
                return Int(fatsGrams)
            }
        } else if macro == "carbs" {
            if let carbsCals = UserDefaults.standard.object(forKey: "carbs in cals") as? Double {
                let carbsGrams = carbsCals / 4
                return Int(carbsGrams)
            }
        } else if macro == "protein" {
            if let proteinCals = UserDefaults.standard.object(forKey: "protein in cals") as? Double {
                let proteinGrams = proteinCals / 4
                return Int(proteinGrams)
            }
        }
        return 0
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func determineLbl() {
        var lbl: String = ""
        if UserHealthData.whichInfo == "fats" {
            let data = getData(macro: "fats")
            if data > 4 {
                let rounded = (round((Double(4 / Double(data))) * 10) / 10) * 100
                var dataAsString: String
                if rounded < 1 {
                    dataAsString = "<1"
                } else {
                    dataAsString = "~"
                    dataAsString.append(String(rounded))
                }
                lbl = "On most nutrition labels, your macros will be shown in grams. From the data you have entered, your total daily intake of fats should be \(data)g. This product has 4g of fats, which is \(dataAsString)% of your daily recommended intake."
            } else {
                lbl = "On most nutrition labels, your macros will be shown in grams. From the data you have entered, your total daily intake of fats should be \(data)g. This product has 4g of fats, which matches or exceeds your daily recommended intake."
            }
        } else if UserHealthData.whichInfo == "carbs" {
            let data = getData(macro: "carbs")
            if data > 46 {
                let rounded = (round((Double(46 / Double(data))) * 10) / 10) * 100
                var dataAsString: String
                if rounded < 1 {
                    dataAsString = "<1"
                } else {
                    dataAsString = "~"
                    dataAsString.append(String(rounded))
                }
                lbl = "On most nutrition labels, your macros will be shown in grams. From the data you have entered, your total daily intake of carbs should be \(data)g. This product has 46g of carbs, which is \(dataAsString)% of your daily intake."
            } else {
                lbl = "On most nutrition labels, your macros will be shown in grams. From the data you have entered, your total daily intake of carbs should be \(data)g. This product has 46g of carbs, which matches or exceeds your daily recommended intake."
            }
        } else if UserHealthData.whichInfo == "protein" {
            let data = getData(macro: "protein")
            if data > 11 {
                let rounded = (round((Double(11 / Double(data))) * 10) / 10) * 100
                var dataAsString: String
                if rounded < 1 {
                   dataAsString = "~"
                   dataAsString.append(String(rounded))
                } else {
                   dataAsString = String(rounded)
                }
                lbl = "On most nutrition labels, your macros will be shown in grams. From the data you have entered, your total daily intake of protein should be \(data)g. This product has 11g of protein, which is \(dataAsString)% of your daily recommended intake."
            } else {
                lbl = "On most nutrition labels, your macros will be shown in grams. From the data you have entered, your total daily intake of protein should be \(data)g. This product has 11g of protein, which matches or exceeds your daily recommended intake."
            }
        } else {
            lbl = "Error."
        }
        
        desc.text = lbl
    }
    
    

}
