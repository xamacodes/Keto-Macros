//
//  WeightVC.swift
//  Keto Macros
//
//  Created by Sena A on 7/31/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class CurrentWeightVC: UIViewController {
    
    @IBOutlet weak var lbsOrKg: UITextField!
    @IBOutlet weak var unitsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let continueBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        continueBtn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        continueBtn.setTitle("Continue", for: .normal) //Always use .setTitle, instead of .titleLabel
        continueBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        continueBtn.addTarget(self, action: #selector(CurrentWeightVC.storeCurrentWeight), for: .touchUpInside)
        unitsSwitch.addTarget(self, action: #selector(CurrentWeightVC.switchToKg), for: .touchUpInside)
        
        lbsOrKg.inputAccessoryView = continueBtn

    }
    
    @objc func storeCurrentWeight() {
        if let currentWeight = lbsOrKg.text {
            if let updatedCurrentWeight = Double(currentWeight) {
                UserData.currentWeight = updatedCurrentWeight
                view.endEditing(true)
                print(UserData.currentWeight ?? "No value (WeightVC.storeCurrentWeight)")
            }
        }
    }
    
    @objc func switchToKg() {
        if unitsSwitch.isOn {
            lbsOrKg.placeholder = "kg"
            UserData.kgIsOn = false
        } else {
            lbsOrKg.placeholder = "lbs"
            UserData.kgIsOn = true
        }
    }

    
   
    //65 fats, 30 protein, 5 carbs
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
