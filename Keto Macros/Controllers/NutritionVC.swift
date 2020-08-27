//
//  NutritionVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/13/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class NutritionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Segues to the nutrition facts description vc, with specific applications to each macro
    func segue() {
        performSegue(withIdentifier: "nutritionDescriptionVCSegue", sender: self)
    }

    //Dismisses the view and returns to the results screen
    @IBAction func onBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Shows the fats info
    @IBAction func onFatsITapped(_ sender: Any) {
        UserHealthData.whichInfo = "fats"
        segue()
    }
    
    //Shows the carbs info
    @IBAction func onCarbsITapped(_ sender: Any) {
        UserHealthData.whichInfo = "carbs"
        segue()
    }
    
    //Shows the protein info
    @IBAction func onProteinITapped(_ sender: Any) {
        UserHealthData.whichInfo = "protein"
        segue()
    }
    
}
