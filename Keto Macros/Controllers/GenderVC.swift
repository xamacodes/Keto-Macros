//
//  GenderVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/1/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class GenderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Stores if they're male
    @IBAction func onMaleTapped(_ sender: Any) {
        UserHealthData.isMale = true
    }
    
    //Stores if they're female
    @IBAction func onFemaleTapped(_ sender: Any) {
        UserHealthData.isMale = false
    }

}
