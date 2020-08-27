//
//  UnitsConfirmationVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/1/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class UnitsConfirmationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func lbsBtnTapped(_ sender: Any) {
        UserHealthData.kgIsOn = false
    }
    
    @IBAction func kgBtnTapped(_ sender: Any) {
        UserHealthData.kgIsOn = true
    }
    
    //Sets the kg placeholder of the weight vc, depending on which units are used
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CurrentWeightVC {
            if UserHealthData.kgIsOn {
                vc.kgPlaceholder = true
            } else {
                vc.kgPlaceholder = false
            }
        } else {
            Utilities.errorMsg("UnitsConfirmationVC.prepare(): error code 4 -> vc not found")
        }
    }

}
