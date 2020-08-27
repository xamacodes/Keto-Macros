//
//  WeightLossGoalViewController.swift
//  Keto Macros
//
//  Created by Sena A on 8/5/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class WeightLossGoalVC: UIViewController {

    @IBOutlet weak var iWantToLbl: UILabel!
    @IBOutlet weak var halfPoundBtn: ModBorderButton!
    @IBOutlet weak var poundBtn: ModBorderButton!
    @IBOutlet weak var twoPoundsBtn: ModBorderButton!
    @IBOutlet weak var warningMsg: UILabel!
    
    var optionSelected: Bool! = false
    var descShowing: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Sets up the initial view
    func setupView() {
        warningMsg.isHidden = true
        setBtnTitles()
        determineWeightLbl()
    }
    
    //Stores the desired rate of weight loss into the user's health data
    func setDesiredWeightLossRate(whichRate: Int) {
        UserHealthData.desiredWeightLossRate = whichRate
    }
    
    //If they want to gain/lose weight, the label says I want to [gain or lose]
    func determineWeightLbl() {
        if UserHealthData.desiredDeficit == 0 {
            iWantToLbl.text = "Rate of Weight Loss:"
        } else if UserHealthData.desiredDeficit == 1 {
            iWantToLbl.text = "Rate of Weight Gain:"
        }
    }
    
    //This sets the weight labels depending on the units they select
    func setBtnTitles() {
        if UserHealthData.kgIsOn {
            halfPoundBtn.setTitle("1/4 kg per week", for: .normal)
            poundBtn.setTitle("1/2 kg per week", for: .normal)
            twoPoundsBtn.setTitle("1 kg per week", for: .normal)
        } else {
            halfPoundBtn.setTitle("1/2 pounds per week", for: .normal)
            poundBtn.setTitle("1 pound per week", for: .normal)
            twoPoundsBtn.setTitle("2 pounds per week", for: .normal)
        }
    }
    
    //Highlights the selected weight loss rate button
    func toggleSelection(whichBtn: UIButton) {
        var count = -1
        
        let btnList: [ModBorderButton] = [halfPoundBtn, poundBtn, twoPoundsBtn]
        
        var index = -1
        for btn in btnList {
            index += 1
            if btn == whichBtn {
                break
            }
        }
        
        for btn in btnList {
            count += 1
            btn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.7450980392, blue: 0, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
    
        if descShowing {
            descShowing = false
            whichBtn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.7450980392, blue: 0, alpha: 1)
            whichBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        } else {
            descShowing = true
            optionSelected = true
            whichBtn.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            whichBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        }
        
        descShowing = false
        
    }
    
    //Alerts the user if they have not selected a rate
    func invalidRateError() {
       let message = "Please select a rate to continue."
       let alertController = UIAlertController(title: "Invalid Rate Selection", message: message, preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
       alertController.addAction(defaultAction)
       present(alertController, animated: true, completion: nil)
    }
    
    //Highlights the button and stores the desired weight loss rate of 1/2 pound per week (1/4 kg per week)
    @IBAction func onHalfPoundTapped(_ sender: Any) {
        toggleSelection(whichBtn: halfPoundBtn)
        setDesiredWeightLossRate(whichRate: 0)
    }

    //Highlights the button and stores the desired weight loss rate of 1 pound per week (1/2 kg per week)
    @IBAction func onPoundTapped(_ sender: Any) {
        toggleSelection(whichBtn: poundBtn)
        setDesiredWeightLossRate(whichRate: 1)
    }
    
    //Highlights the button and stores the desired weight loss rate of 2 pounds per week (1 kg per week)
    @IBAction func onTwoPoundsTapped(_ sender: Any) {
        toggleSelection(whichBtn: twoPoundsBtn)
        setDesiredWeightLossRate(whichRate: 2)
    }
    
    //Continues to the results vc if a weight loss rate is selected
    @IBAction func onNextTapped(_ sender: Any) {
        if optionSelected {
            warningMsg.isHidden = true
            performSegue(withIdentifier: "resultsVCSegue2", sender: self)
        } else {
            warningMsg.isHidden = false
            invalidRateError()
        }
    }
    
}
