//
//  OldResultsVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/17/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class OldResultsVC: UIViewController {

    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var fatsCalsLbl: UILabel!
    @IBOutlet weak var fatsGramsLbl: UILabel!
    @IBOutlet weak var proteinCalsLbl: UILabel!
    @IBOutlet weak var proteinGramsLbl: UILabel!
    @IBOutlet weak var carbsCalsLbl: UILabel!
    @IBOutlet weak var carbsGramsLbl: UILabel!
    @IBOutlet weak var notRecLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //Sets up the initial view
    func setupView() {
        notRecLbl.isHidden = true
        getCaloriesAndUpdateLbls()
    }
    
    //Sets all of the macros labels, include the calories label
    func getCaloriesAndUpdateLbls() {
        if let calories = UserDefaults.standard.object(forKey: "calories") as? Double {
            updateCalsLbl()
            if calories < 100 {
                notRecLbl.isHidden = false
                lowCaloriesError()
            } else {
                updateMacrosLbls(whichMacroCals: fatsCalsLbl, whichMacroGrams: fatsGramsLbl, whichMacroKey: "fats in cals")
                updateMacrosLbls(whichMacroCals: proteinCalsLbl, whichMacroGrams: proteinGramsLbl, whichMacroKey: "protein in cals")
                updateMacrosLbls(whichMacroCals: carbsCalsLbl, whichMacroGrams: carbsGramsLbl, whichMacroKey: "carbs in cals")
            }
        } else {
            Utilities.errorMsg("OldResultsVC.getCaloriesAndUpdateLbls(): error code 13 -> data retrieval")
        }
    }
    
    //Framework for setting the calories label. Fails if the amount is < 1,000
    func updateCalsLbl() {
        if let calories = UserDefaults.standard.object(forKey: "calories") as? Double {
            if calories < 1000 {
                notRecLbl.isHidden = false
            }
            caloriesLbl.text = String(Int(calories))
        } else {
            Utilities.errorMsg("OldResultsVC.updateCalsLbls(): error code 14 -> data retrieval")
        }
    }
    
    //Framework for determining the macros labels
    func updateMacrosLbls(whichMacroCals: UILabel, whichMacroGrams: UILabel, whichMacroKey: String) {
        if let macroCals = UserDefaults.standard.object(forKey: whichMacroKey) as? Double {
            var macroCalsString = String(Int(macroCals))
            macroCalsString.append(" calories")
            whichMacroCals.text = macroCalsString
            
            var macroGramsString: String
            if whichMacroKey == "fats in cals" {
                macroGramsString = String(Int(macroCals / 9))
            } else {
                macroGramsString = String(Int(macroCals / 4))
            }
            
            macroGramsString.append(" grams")
            whichMacroGrams.text = macroGramsString
        } else {
            Utilities.errorMsg("OldResultsVC.updateMacrosLbls(): error code 15 -> data retrieval")
        }
    }
    
    //Alerts the user if their total calories is < 1,000
    func lowCaloriesError() {
       let message = "1,000 calorie minimum."
       let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
       alertController.addAction(defaultAction)
       present(alertController, animated: true, completion: nil)
    }
    
    //Allows the user to share their results via email, saving the image, etc.
    @IBAction func shareTapped(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let activityVC = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }

}
