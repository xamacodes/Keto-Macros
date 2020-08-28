//
//  Garbage.swift
//  Keto Macros
//
//  Created by Sena A on 8/4/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import Foundation

//@objc func closeKeypad() {
//    view.endEditing(true)
//    checkGoalWeight()
//    checkCurrentWeight()
//}
//
//@objc func checkGoalWeight() {
//    if let weight = UserData.goalWeight {
//        if weight < 21 || weight > 800 {
//            isValidStartingWeight = false
//            warningMsg.isHidden = false
//            actualNextBtn.isEnabled = false
//        } else {
//            actualNextBtn.isEnabled = true
//        }
//    }
//}
//
//@objc func checkCurrentWeight() {
//    if let weight = UserData.currentWeight  {
//        if weight < 21 || weight > 800 {
//            isValidStartingWeight = false
//            warningMsg.isHidden = false
//            actualNextBtn.isEnabled = false
//        } else {
//            actualNextBtn.isEnabled = true
//        }
//    }
//}
//
//@objc func finalCheck() {
//    if weightTxt.text == "" || goalWeightTxt.text == "" {
//        let alertController = UIAlertController(title: "Invalid Weight", message: "Please enter a valid starting weight.", preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//        alertController.addAction(defaultAction)
//        isValidStartingWeight = false
//        warningMsg.isHidden = false
//        actualNextBtn.isEnabled = false
//
//        present(alertController, animated: true, completion: nil)
//    } else {
//        if let weight = UserData.currentWeight, let goalWeight = UserData.goalWeight {
//            if (weight < 21 || weight > 800) && (goalWeight < 21 || goalWeight > 800) {
//                let alertController = UIAlertController(title: "Invalid Weight", message: "Please enter a valid starting weight.", preferredStyle: .alert)
//                let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//                alertController.addAction(defaultAction)
//                isValidStartingWeight = false
//                warningMsg.isHidden = false
//                actualNextBtn.isEnabled = false
//
//                present(alertController, animated: true, completion: nil)
//            } else {
//                actualNextBtn.isEnabled = true
//                warningMsg.isHidden = true
//            }
//        }
//    }
//}
//
//@objc func setPlaceholder() {
//    if let p = kgPlaceholder {
//        if p {
//            weightTxt.placeholder = "kg"
//            goalWeightTxt.placeholder = "kg"
//        } else {
//            weightTxt.placeholder = "lbs"
//            goalWeightTxt.placeholder = "lbs"
//        }
//    }
//}
//
//@objc func getWeightDataCurrent() {
//    storeCurrentWeight(weight: weightTxt, current: true)
//    //validWeights()
//}
//
//@objc func getWeightDataGoal() {
//    storeCurrentWeight(weight: goalWeightTxt, current: false)
//    //validWeights()
//}
//
//@objc func validWeights() {
//    if isValidGoalWeight && isValidStartingWeight {
//        actualNextBtn.isEnabled = true
//    }
//}
//
//@objc func storeCurrentWeight(weight: UITextField, current: Bool) {
//    if let currentWeight = weight.text {
//        if let updatedCurrentWeight = Double(currentWeight) {
//            if updatedCurrentWeight < 21 || updatedCurrentWeight > 800 {
//                if current {
//                    let alertController = UIAlertController(title: "Invalid Weight", message: "Please enter a valid starting weight.", preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//                    alertController.addAction(defaultAction)
//                    isValidStartingWeight = false
//                    warningMsg.isHidden = false
//                    actualNextBtn.isEnabled = false
//                    UserData.currentWeight = updatedCurrentWeight
//
//                    present(alertController, animated: true, completion: nil)
//                } else {
//                    let alertController = UIAlertController(title: "Invalid Weight", message: "Please enter a valid goal weight.", preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//                    alertController.addAction(defaultAction)
//                    isValidGoalWeight = false
//                    warningMsg.isHidden = false
//                    actualNextBtn.isEnabled = false
//                    UserData.goalWeight = updatedCurrentWeight
//
//                    present(alertController, animated: true, completion: nil)
//                }
//            } else {
//                if current {
//                    isValidStartingWeight = true
//                    UserData.currentWeight = updatedCurrentWeight
//                    warningMsg.isHidden = true
//                } else {
//                    isValidGoalWeight = true
//                    UserData.goalWeight = updatedCurrentWeight
//                    warningMsg.isHidden = true
//                }
//                view.endEditing(true)
//            }
//        } else {
//            if current {
//                let alertController = UIAlertController(title: "Invalid Weight", message: "Please enter a valid starting weight.", preferredStyle: .alert)
//                let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//                alertController.addAction(defaultAction)
//                warningMsg.isHidden = false
//                actualNextBtn.isEnabled = false
//
//                present(alertController, animated: true, completion: nil)
//            } else {
//                let alertController = UIAlertController(title: "Invalid Weight", message: "Please enter a valid goal weight.", preferredStyle: .alert)
//                let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//                alertController.addAction(defaultAction)
//                warningMsg.isHidden = false
//                actualNextBtn.isEnabled = false
//
//                present(alertController, animated: true, completion: nil)
//            }
//        }
//    }
//}

//
//func updateCarbsLbls() {
//    let cals = getCalories()
//    let carbCals = cals * 0.05
//    UserDefaults.standard.set(carbCals, forKey: "carbs in cals")
//    carbsCalsLbl.text = "\(Int(carbCals)) calories"
//    carbsGramsLbl.text = "\(Int(carbCals / 4)) grams"
//}
//
//func updateProteinLbls() {
//    let cals = getCalories()
//    let proteinCals = cals * 0.2
//    UserDefaults.standard.set(proteinCals, forKey: "protein in cals")
//    proteinCalsLbl.text = "\(Int(proteinCals)) calories"
//    proteinGramsLbl.text = "\(Int(proteinCals / 4)) grams"
//}
//
//func updateFatsLbls() {
//    let cals = getCalories()
//    let fatsCals = cals * 0.7
//    UserDefaults.standard.set(fatsCals, forKey: "fats in cals")
//    fatsCalsLbl.text = "\(Int(fatsCals)) calories"
//    fatsGramsLbl.text = "\(Int(fatsCals / 9)) grams"
//}


//if let fatsCals = UserDefaults.standard.object(forKey: "fats in cals") as? Double {
//    var fatsCalsString = String(Int(fatsCals))
//    fatsCalsString.append(" calories")
//    fatsCalsLbl.text = fatsCalsString
//
//    var fatsGramsString = String(Int(fatsCals / 9))
//    fatsGramsString.append(" grams")
//    fatsGramsLbl.text = fatsGramsString
//}
//
//if let proteinCals = UserDefaults.standard.object(forKey: "protein in cals") as? Double {
//    var proteinCalsString = String(Int(proteinCals))
//    proteinCalsString.append(" calories")
//    proteinCalsLbl.text = proteinCalsString
//
//    var proteinGramsString = String(Int(proteinCals / 4))
//    proteinGramsString.append(" grams")
//    proteinGramsLbl.text = proteinGramsString
//}
//
//if let carbsCals = UserDefaults.standard.object(forKey: "carbs in cals") as? Double {
//    var carbsCalsString = String(Int(carbsCals))
//    carbsCalsString.append(" calories")
//    carbsCalsLbl.text = carbsCalsString
//
//    var carbsGramsString = String(Int(carbsCals / 4))
//    carbsGramsString.append(" grams")
//    carbsGramsLbl.text = carbsGramsString
//}



//if let fats = food?.foodNutrients[fatsIndex!].value, let protein = food?.foodNutrients[proteinIndex!].value, let carbs = food?.foodNutrients[carbsIndex!].value {
//if let fatsUnits = food?.foodNutrients[fatsIndex!].unitName, let proteinUnits = food?.foodNutrients[proteinIndex!].unitName, let carbsUnits = food?.foodNutrients[carbsIndex!].unitName {
//
//    var fatsText = "\(fats)"
//    fatsText.append(fatsUnits.lowercased())
//    fatsLbl.text = fatsText
//
//    var proteinText = "\(protein)"
//    proteinText.append(proteinUnits.lowercased())
//    proteinLbl.text = proteinText
//
//    var carbsText = "\(carbs)"
//    carbsText.append(carbsUnits.lowercased())
//    carbsLbl.text = carbsText
//}
