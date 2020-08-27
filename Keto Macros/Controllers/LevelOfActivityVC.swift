//
//  LevelOfActivityVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/4/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class LevelOfActivityVC: UIViewController {

    @IBOutlet weak var sedentaryBtn: ModBorderButton!
    @IBOutlet weak var slightlyBtn: ModBorderButton!
    @IBOutlet weak var moderatelyBtn: ModBorderButton!
    @IBOutlet weak var veryBtn: ModBorderButton!
    @IBOutlet weak var athleteBtn: ModBorderButton!
    @IBOutlet weak var warningMsg: UILabel!
    
    var descShowing: Bool! = false
    var optionSelected: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        warningMsg.isHidden = true
    }
    
    //Changes color of buttons when selected, and text description of activity
    func toggleDescs(whichBtn: ModBorderButton) {
        var count = -1
        
        let btnList: [ModBorderButton] = [sedentaryBtn, slightlyBtn, moderatelyBtn, veryBtn, athleteBtn]
        let btnTitleList: [String] = ["Sedentary", "Slightly Active", "Moderately Active", "Very Active", "Athlete"]
        let descList: [String] = ["No activity", "Infrequent exercise", "Occasional exercise", "Frequent exercise", "Daily rigorous exercise"]
        
        var index = -1
        for btn in btnList {
            index += 1
            if btn == whichBtn {
                break
            }
        }
        
        for btn in btnList {
            count += 1
            btn.setTitle(btnTitleList[count], for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.7450980392, blue: 0, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
        
        if descShowing {
            descShowing = false
            whichBtn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.7450980392, blue: 0, alpha: 1)
            whichBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            whichBtn.setTitle(btnTitleList[index], for: .normal)
        } else {
            descShowing = true
            optionSelected = true
            whichBtn.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            whichBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            whichBtn.setTitle(descList[index], for: .normal)
        }

        descShowing = false
        
    }
    
    //Goes into either the WeightLossVC or the ResultsVC, depending on whether they want to maintain their weight
    func segue() {
        if UserHealthData.desiredDeficit == 2 {
            performSegue(withIdentifier: "resultsVCSegue", sender: self)
        } else {
            performSegue(withIdentifier: "weightLossVCSegue", sender: self)
        }
    }
    
    //Alerts the user if they do not select an activity level
    func invalidActivityError() {
       let message = "Please select an activity level to continue."
       let alertController = UIAlertController(title: "Indicate Your Physical Activity", message: message, preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
       alertController.addAction(defaultAction)
       present(alertController, animated: true, completion: nil)
    }
    
    //Sets the user's activity level to sedentary
    @IBAction func onSedentaryTapped(_ sender: Any) {
        UserHealthData.activity = 0
        toggleDescs(whichBtn: sedentaryBtn)
    }
    
    //Sets the user's activity level to slightly active
    @IBAction func onSlightlyBtn(_ sender: Any) {
        UserHealthData.activity = 1
        toggleDescs(whichBtn: slightlyBtn)
    }
    
    //Sets the user's activity level to moderately active
    @IBAction func onModeratelyBtn(_ sender: Any) {
        UserHealthData.activity = 2
        toggleDescs(whichBtn: moderatelyBtn)
    }
    
    //Sets the user's activity level to very active
    @IBAction func onVeryBtn(_ sender: Any) {
        UserHealthData.activity = 3
        toggleDescs(whichBtn: veryBtn)
    }
    
    //Sets the user's activity level to athlete
    @IBAction func onAthleteBtn(_ sender: Any) {
        UserHealthData.activity = 4
        toggleDescs(whichBtn: athleteBtn)
    }
    
    //Transitions to next vc if an activity level is selected
    @IBAction func onNextTapped(_ sender: Any) {
        if !optionSelected {
            warningMsg.isHidden = false
            invalidActivityError()
        } else {
            segue()
        }
    }

}
