//
//  WeightVC.swift
//  Keto Macros
//
//  Created by Sena A on 7/31/20.
//  Copyright © 2020 Project X. All rights reserved.
//

//65 fats, 30 protein, 5 carbs

import UIKit

class CurrentWeightVC: UIViewController {
    
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var goalWeightTxt: UITextField!
    @IBOutlet weak var warningMsg: UILabel!
    @IBOutlet weak var maintainOrEnter: BorderButton!
    
    var kgPlaceholder: Bool!
    var storeGoalWeight: Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Sets up the initial view
    func setupView() {
        setPlaceholder()
        
        warningMsg.isHidden = true
        
        let nextBtn = Utilities.createKeypadBtn(view: view)
        let continueBtn = Utilities.createKeypadBtn(view: view)
        
        weightTxt.inputAccessoryView = nextBtn
        goalWeightTxt.inputAccessoryView = continueBtn
    }
    
    //Sets the user health data to be the weight entered, if they are valid entries
    func storeWeight(someWeightTxt: UITextField, whichWeight: String!) {
        if storeGoalWeight {
            if isValidWeight(someWeightTxt: someWeightTxt) {
                if let updatedWeight = someWeightTxt.text {
                    if let doubleUpdatedWeight = Double(updatedWeight) {
                        if whichWeight == "current" {
                            if UserHealthData.kgIsOn {
                                UserHealthData.currentWeight = doubleUpdatedWeight
                            } else {
                                UserHealthData.currentWeight = doubleUpdatedWeight / 2.2
                            }
                        } else if whichWeight == "goal" {
                            if UserHealthData.kgIsOn {
                                UserHealthData.goalWeight = doubleUpdatedWeight
                            } else {
                                UserHealthData.goalWeight = doubleUpdatedWeight / 2.2
                            }
                        }
                    } else {
                        Utilities.errorMsg("CurrentWeightVC.storeWeight(): error code 4.1 -> nil value")
                    }
                } else {
                    Utilities.errorMsg("CurrentWeightVC.storeWeight(): error code 4.2 -> nil value")
                }
            }
        }
    }
    
    //Checks if is a valid weight entry
    func isValidWeight(someWeightTxt: UITextField) -> Bool {
        if let weight = someWeightTxt.text {
            if let doubleWeight = Double(weight) {
                if doubleWeight < 20 || doubleWeight > 800 {
                    return false
                }
            } else if weight == "" {
                return false
            } else {
                var count = 0
                for character in weight {
                    if character == "." {
                        count += 1
                    }
                }
                if count > 1 {
                    return false
                }
            }
        } else {
            Utilities.errorMsg("CurrentWeightVC.isValidWeight(): error code 5 -> nil value")
        }
        return true
    }

    //Shows alert if either of the weight entries are invalid
    func invalidWeightError() {
        let message = "One or more entries are invalid. Please enter valid measurements to continue."
        let alertController = UIAlertController(title: "Invalid Weight(s)", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //Sets the initial units placeholder in the text box
    func setPlaceholder() {
        if UserHealthData.kgIsOn {
            weightTxt.placeholder = "kg"
            goalWeightTxt.placeholder = "kg"
        } else {
            weightTxt.placeholder = "lbs"
            goalWeightTxt.placeholder = "lbs"
        }
    }
    
    //Enables or disables the user from providing a goal weight
    func maintainOrChangeWeight() {
        if goalWeightTxt.isEnabled {
            warningMsg.isHidden = true
            maintainOrEnter.setTitle("Enable goal weight", for: .normal)
            goalWeightTxt.text = ""
            goalWeightTxt.isEnabled = false
            goalWeightTxt.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            storeGoalWeight = false
        } else {
            maintainOrEnter.setTitle("Maintain weight", for: .normal)
            goalWeightTxt.isEnabled = true
            goalWeightTxt.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            storeGoalWeight = true
        }
    }
    
    //Greys out or enables goal weight text box
    @IBAction func onMaintainTapped(_ sender: Any) {
        maintainOrChangeWeight()
    }
    
    //Goes to the height and age vc if the weight entries are valid
    @IBAction func onNextTapped(_ sender: Any) {
        if storeGoalWeight {
            if !isValidWeight(someWeightTxt: weightTxt) || !isValidWeight(someWeightTxt: goalWeightTxt) {
                invalidWeightError()
                warningMsg.isHidden = false
            } else {
                storeWeight(someWeightTxt: weightTxt, whichWeight: "current")
                storeWeight(someWeightTxt: goalWeightTxt, whichWeight: "goal")
                UserHealthData.determineWeightLbl()
                performSegue(withIdentifier: "heightAndAgeVCSegue", sender: self)
                warningMsg.isHidden = true
            }
        } else {
            if !isValidWeight(someWeightTxt: weightTxt) {
                invalidWeightError()
                warningMsg.isHidden = false
            } else {
                if let updatedCurrentWeight = weightTxt.text {
                    if let doubleUpdatedCurrentWeight = Double(updatedCurrentWeight) {
                        UserHealthData.currentWeight = doubleUpdatedCurrentWeight / 2.2
                        UserHealthData.goalWeight = doubleUpdatedCurrentWeight / 2.2
                        UserHealthData.determineWeightLbl()
                        performSegue(withIdentifier: "heightAndAgeVCSegue", sender: self)
                    }
                }
            }
        }
    }

}
