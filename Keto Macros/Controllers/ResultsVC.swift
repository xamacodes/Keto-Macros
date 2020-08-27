//
//  LoadingVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/5/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit
import CoreData

class ResultsVC: UIViewController {

    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var carbsGramsLbl: UILabel!
    @IBOutlet weak var carbsCalsLbl: UILabel!
    @IBOutlet weak var proteinGramsLbl: UILabel!
    @IBOutlet weak var proteinCalsLbl: UILabel!
    @IBOutlet weak var fatsGramsLbl: UILabel!
    @IBOutlet weak var fatsCalsLbl: UILabel!
    @IBOutlet weak var notRecLbl: UILabel!
    var lowCalories: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Sets up initial view
    func setupView() {
        lowCalories = false
        notRecLbl.isHidden = true
        UserHealthData.determineCaloriesPerDayWithRate()
        
        checkLowCalories()
        
        UserHealthData.resultsReached = true
        UserDefaults.standard.set(UserHealthData.resultsReached, forKey: "results VC reached")
    }
    
    //Gets the calculated final calories from the user health data
    func getCalories() -> Double {
        if let calories = UserHealthData.caloriesPerDayWithRate {
            if calories < 1000 {
                notRecLbl.isHidden = false
                lowCalories = true
            }
            UserDefaults.standard.set(calories, forKey: "calories")
            return calories
        } else {
            Utilities.errorMsg("ResultsVC.getCalories(): error code 11 -> nil value")
        }
        return 11 //some error occurred
    }
    
    //Checks and alerts the user if the final calories are too low
    func checkLowCalories() {
        updateCaloriesLbl()
        if lowCalories {
            lowCaloriesError()
        } else {
            updateMacrosLbl(whichMacro: "carbs")
            updateMacrosLbl(whichMacro: "protein")
            updateMacrosLbl(whichMacro: "fats")
        }
    }
    
    //Alerts the user if the calories are under 1,000
    func lowCaloriesError() {
       let message = "1,000 calorie minimum."
       let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
       alertController.addAction(defaultAction)
       present(alertController, animated: true, completion: nil)
    }
    
    //Creates the calories label with the final calories amount
    func updateCaloriesLbl() {
        caloriesLbl.text = "\(Int(getCalories()))"
    }
    
    //Updates the carbs, protein, or fats labels with the calculated macro amount
    func updateMacrosLbl(whichMacro: String) {
        let cals = getCalories()
        var newMacro = whichMacro
        var macroCals: Double = 0
        
        if whichMacro == "carbs" {
            macroCals = cals * 0.05
            carbsCalsLbl.text = "\(Int(macroCals)) calories"
            carbsGramsLbl.text = "\(Int(macroCals / 4)) grams"
        } else if whichMacro == "protein" {
            macroCals = cals * 0.2
            proteinCalsLbl.text = "\(Int(macroCals)) calories"
            proteinGramsLbl.text = "\(Int(macroCals / 4)) grams"
        } else if whichMacro == "fats" {
            macroCals = cals * 0.7
            fatsCalsLbl.text = "\(Int(macroCals)) calories"
            fatsGramsLbl.text = "\(Int(macroCals / 9)) grams"
        }
        
        newMacro.append(" in cals")
        UserDefaults.standard.set(macroCals, forKey: newMacro)
    }
    
    //Shows the nutrition facts vc
    @IBAction func onInfoTapped(_ sender: Any) {
        performSegue(withIdentifier: "nutritionVCSegue", sender: self)
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
