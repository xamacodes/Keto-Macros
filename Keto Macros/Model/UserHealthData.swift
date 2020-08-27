//
//  Units.swift
//  Keto Macros
//
//  Created by Sena A on 7/31/20.
//  Copyright © 2020 Project X. All rights reserved.
//

//250 calories per day to lose 1/2 pound per week
//500 calories per day to lose 1 pound per week
//1000 calories per day to lose 2 pounds per week

import Foundation
import UIKit

struct UserHealthData {
    
    static var kgIsOn: Bool = true
    static var currentWeight: Double!
    static var goalWeight: Double! // To check if they maintained their weight, check if current = goal
    static var isMale: Bool!
    static var age: Double!
    static var height: Double!
    static var activity: Int! //0 for sed, 1 for slightly, 2 for mod, 3 for very, 4 for athlete
    static var caloriesPerDay: Double!
    static var caloriesPerDayWithRate: Double!
    static var desiredWeightLossRate: Int! //0 for 1/2 a week, 1 for 1 a week, 2 for 2 a week
    static var desiredDeficit: Int! //0 for loss, 1 for gain, 2 for maintain
    static var resultsReached: Bool!
    static var whichInfo: String?
    
    static var carbsInGrams: String!
    static var carbsInCals: String!
    static var fatsInGrams: String!
    static var fatsInCals: String!
    static var proteinInGrams: String!
    static var proteinInCals: String!
    
    static func calculateMifflin() {
        var mifflinResult: Double! = 0
        if currentWeight != nil {
            if height != nil {
                mifflinResult = 10 * currentWeight + 6.25 * height
                mifflinResult -= (5 * age)
                
                if isMale {
                    mifflinResult += 5
                } else {
                    mifflinResult -= 161
                }
                
                var tdee: Double!
                if activity == 0 {
                    tdee = 1.2
                } else if activity == 1 {
                    tdee = 1.375
                } else if activity == 2 {
                    tdee = 1.55
                } else if activity == 3 {
                    tdee = 1.725
                } else { //There was a condition between these two, 1.9, but I only made 5 options, not 6
                    tdee = 1.9
                }
                
                mifflinResult *= tdee
                caloriesPerDay = ceil(mifflinResult)
                //UserDefaults.standard.set(UserData.caloriesPerDay, forKey: "calories per day")
            }
        } else {
            print("nil63")
        }
    }
    
    static func determineWeightLbl() {
        let diff = currentWeight - goalWeight
        if diff == 0 {
            desiredDeficit = 2
        } else if diff < 0 {
            desiredDeficit = 1
        } else {
            desiredDeficit = 0
        }
        //UserDefaults.standard.set(desiredDeficit, forKey: "desired deficit")
    }
    
    static func determineCaloriesPerDayWithRate() {
        calculateMifflin()
        determineWeightLbl()
        var cals: Double! = caloriesPerDay
        var weightLossOrGainMultiple: Double!
        
        if desiredWeightLossRate == 0 {
            weightLossOrGainMultiple = 250
        } else if desiredWeightLossRate == 1 {
            weightLossOrGainMultiple = 500
        } else if desiredWeightLossRate == 2 {
            weightLossOrGainMultiple = 1000
        }
    
        if desiredDeficit == 0 {
            cals -= weightLossOrGainMultiple
        } else if desiredDeficit == 1 {
            cals += weightLossOrGainMultiple
        }
        
        caloriesPerDayWithRate = cals
        //UserDefaults.standard.set(UserData.caloriesPerDayWithRate, forKey: "calories per day with rate")
    }
    
}

