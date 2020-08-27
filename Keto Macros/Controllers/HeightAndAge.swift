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
        
        setPlaceholder()
    
        let nextBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        nextBtn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        nextBtn.setTitle("Continue", for: .normal) //Always use .setTitle, instead of .titleLabel
        nextBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        nextBtn.addTarget(self, action: #selector(HeightAndAgeVC.closeKeypad), for: .allTouchEvents)
        
        let continueBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        continueBtn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        continueBtn.setTitle("Continue", for: .normal) //Always use .setTitle, instead of .titleLabel
        continueBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        continueBtn.addTarget(self, action: #selector(HeightAndAgeVC.closeKeypad), for: .allTouchEvents)
        
        ageTxt.inputAccessoryView = nextBtn
        ftOrCm.inputAccessoryView = nextBtn
        inches.inputAccessoryView = continueBtn
    }
    
    @objc func closeKeypad() {
        view.endEditing(true)
    }
    
    @objc func validCharacters(whichTextField: UITextField) -> Bool {
        if let textField = whichTextField.text {
            if textField == "" {
                return false
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
        }
        return true
    }
    
    @objc func isValidAge() -> Bool {
        if let age = ageTxt.text {
            if let doubleAge = Double(age) {
                if doubleAge < 5 || doubleAge > 115 {
                    return false
                }
            } else if !validCharacters(whichTextField: ageTxt) {
                return false
            }
        }
        return true
    }
    
    @objc func isValidHeight() -> Bool {
        if UserData.kgIsOn {
            if let cm = ftOrCm.text {
                if let doubleCm = Double(cm) {
                    if doubleCm < 20 || doubleCm > 245 {
                        return false
                    }
                }
            }
        } else {
            if let ft = ftOrCm.text {
                if let doubleFt = Double(ft) {
                    if doubleFt < 1 || doubleFt > 8 {
                        return false
                    }
                }
            } else {
                if let inches = inches.text {
                    if let doubleInches = Double(inches) {
                        if doubleInches <= 0 || doubleInches > 8 {
                            return false
                        }
                    }
                }
            }
        }
    
        if !validCharacters(whichTextField: ftOrCm) || !validCharacters(whichTextField: inches) {
            return false
        }
        return true
    }
    
    @objc func storeAge() {
        if let updatedAge = ageTxt.text {
            if let doubleAge = Double(updatedAge) {
                UserData.age = doubleAge
            }
        }
    }
    
    @objc func storeHeight() {
        if UserData.kgIsOn {
            if let height = ftOrCm.text {
                if let updatedHeight = Double(height) {
                    UserData.height = updatedHeight
                }
            }
        } else {
            if let ft = ftOrCm.text {
                if let updatedFt = Double(ft) {
                    if let inches = inches.text {
                        if let updatedInches = Double(inches) {
                            UserData.height = (updatedFt + (updatedInches / 12)) * 30.48
                        }
                    }
                }
            }
        }
    }
    
    @objc func setPlaceholder() {
        if UserData.kgIsOn {
            inches.isHidden = true
            ftOrCm.placeholder = "cm"
        } else {
            inches.isHidden = false
        }
        ageTxt.placeholder = "years"
    }
    
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
    
    @IBAction func unwindFromSkillVC(unwindSegue: UIStoryboardSegue) {
        
    }
    
    @objc func invalidEntryError() {
        let message = "One or more entries are invalid. Please enter valid measurements to continue."
        let alertController = UIAlertController(title: "Invalid Age or Height", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

}
