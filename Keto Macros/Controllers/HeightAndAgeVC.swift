//
//  VC.swift
//  Keto Macros
//
//  Created by Sena A on 8/2/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class HeightAndAgeVC: UIViewController {

    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var ftOrCm: UITextField!
    @IBOutlet weak var inches: UITextField!
    @IBOutlet weak var warningMsg: UILabel!
    
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
        
        ageTxt.inputAccessoryView = nextBtn
        ftOrCm.inputAccessoryView = nextBtn
        inches.inputAccessoryView = continueBtn
    }
    
    //Checks to ensure that the fields are not empty or have extra decimal points
    func validCharacters(whichTextField: UITextField) -> Bool {
        if let textField = whichTextField.text {
            if textField == "" {
                if textField != inches.text {
                     return false
                }
            } else {
                var count = 0
                for character in textField {
                    if character == "." {
                        count += 1
                    }
                }
                if count > 1 {
                    return false
                }
            }
        } else {
            Utilities.errorMsg("HeightAndAgeVC.validCharacters(): error code 6 -> nil value")
        }
        return true
    }
    
    //Ensures the age entry is valid
    func isValidAge() -> Bool {
        if let age = ageTxt.text {
            if let doubleAge = Double(age) {
                if doubleAge < 5 || doubleAge > 115 {
                    return false
                }
            } else if !validCharacters(whichTextField: ageTxt) {
                return false
            }
        } else {
            Utilities.errorMsg("HeightAndAgeVC.isValidAge(): error code 7 -> nil value")
        }
        return true
    }
    
    //Ensures the height entry is valid
    func isValidHeight() -> Bool {
        if UserHealthData.kgIsOn {
            if let cm = ftOrCm.text {
                if let doubleCm = Double(cm) {
                    if doubleCm < 20 || doubleCm > 245 {
                        return false
                    } else if cm == "" {
                        return false
                    }
                }
            } else {
                Utilities.errorMsg("HeightAndAgeVC.isValidHeight(): error code 8.1 -> nil value")
            }
        } else {
            if let ft = ftOrCm.text {
                if ft == "" {
                    return false
                }
                if let doubleFt = Double(ft) {
                    if doubleFt < 1 || doubleFt > 8 {
                        return false
                    }
                }
            } else {
                Utilities.errorMsg("HeightAndAgeVC.isValidHeight(): error code 8.2 -> nil value")
            }
            
            if let inches = inches.text {
                if let doubleInches = Double(inches) {
                    if doubleInches < 0 || doubleInches >= 12 {
                        return false
                    }
                }
            } else {
                Utilities.errorMsg("HeightAndAgeVC.isValidHeight(): error code 8.3 -> nil value")
            }
            
            if !validCharacters(whichTextField: inches) {
                return false
            }
        }
        
        if !validCharacters(whichTextField: ftOrCm) {
            return false
        }
        return true
    }
    
    //Stores their age into the user's health data
    func storeAge() {
        if let updatedAge = ageTxt.text {
            if let doubleAge = Double(updatedAge) {
                UserHealthData.age = doubleAge
            }
        } else {
            Utilities.errorMsg("HeightAndAgeVC.storeAge(): error code 9 -> nil value")
        }
    }
    
    //Stores their height into the user's health data
    func storeHeight() {
        if UserHealthData.kgIsOn {
            if let height = ftOrCm.text {
                if let updatedHeight = Double(height) {
                    UserHealthData.height = updatedHeight
                }
            } else {
                Utilities.errorMsg("HeightAndAgeVC.storeHeight(): error code 10.1 -> nil value")
            }
        } else {
            if let ft = ftOrCm.text {
                if let updatedFt = Double(ft) {
                    if let inches = inches.text {
                        if inches == "" {
                            UserHealthData.height = updatedFt * 30.48
                        } else {
                            if let updatedInches = Double(inches) {
                                UserHealthData.height = (updatedFt + (updatedInches / 12)) * 30.48
                            }
                        }
                    }
                }
            } else {
                Utilities.errorMsg("HeightAndAgeVC.storeHeight(): error code 10.2 -> nil value")
            }
        }
    }
    
    //Determines the units for the placeholder in the height field(s)
    func setPlaceholder() {
        if UserHealthData.kgIsOn {
            inches.isHidden = true
            ftOrCm.placeholder = "cm"
        } else {
            inches.isHidden = false
        }
        ageTxt.placeholder = "years"
    }
    
    //Alerts the user if they submitted an invalid age or height
    func invalidEntryError() {
        let message = "One or more entries are invalid. Please enter valid measurements to continue."
        let alertController = UIAlertController(title: "Invalid Age or Height", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //Segues to the LevelOfActivityVC if the age and height are valid
    @IBAction func onNextTapped(_ sender: Any) {
        if !isValidAge() || !isValidHeight() {
            invalidEntryError()
            warningMsg.isHidden = false
        } else {
            storeAge()
            storeHeight()
            performSegue(withIdentifier: "levelOfActivityVCSegue", sender: self)
            warningMsg.isHidden = true
        }
    }
    
}
