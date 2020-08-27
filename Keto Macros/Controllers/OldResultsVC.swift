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
        
        notRecLbl.isHidden = true
        getCaloriesAndUpdateLbls()
        
    }
    
    @objc func getCaloriesAndUpdateLbls() {
        if let calories = UserDefaults.standard.object(forKey: "calories") as? Double {
            updateCalsLbl()
            if calories < 100 {
                notRecLbl.isHidden = false
                lowCaloriesError()
            } else {
                setLbls()
            }
        }
    }
    
    @objc func updateCalsLbl() {
        if let calories = UserDefaults.standard.object(forKey: "calories") as? Double {
            if calories < 1000 {
                notRecLbl.isHidden = false
            }
            caloriesLbl.text = String(Int(calories))
        }
    }
    
    @objc func setLbls() {
        if let fatsCals = UserDefaults.standard.object(forKey: "fats in cals") as? Double {
            var fatsCalsString = String(Int(fatsCals))
            fatsCalsString.append(" calories")
            fatsCalsLbl.text = fatsCalsString
            
            var fatsGramsString = String(Int(fatsCals / 9))
            fatsGramsString.append(" grams")
            fatsGramsLbl.text = fatsGramsString
        }

        if let proteinCals = UserDefaults.standard.object(forKey: "protein in cals") as? Double {
            var proteinCalsString = String(Int(proteinCals))
            proteinCalsString.append(" calories")
            proteinCalsLbl.text = proteinCalsString
            
            var proteinGramsString = String(Int(proteinCals / 4))
            proteinGramsString.append(" grams")
            proteinGramsLbl.text = proteinGramsString
        }

        if let carbsCals = UserDefaults.standard.object(forKey: "carbs in cals") as? Double {
            var carbsCalsString = String(Int(carbsCals))
            carbsCalsString.append(" calories")
            carbsCalsLbl.text = carbsCalsString
            
            var carbsGramsString = String(Int(carbsCals / 4))
            carbsGramsString.append(" grams")
            carbsGramsLbl.text = carbsGramsString
        }

    }
    
    @objc func lowCaloriesError() {
       let message = "1,000 calorie minimum."
       let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
       alertController.addAction(defaultAction)
       present(alertController, animated: true, completion: nil)
    }
    
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
