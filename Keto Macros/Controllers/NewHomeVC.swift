//
//  NewHomeVC.swift
//  Keto Macros
//
//  Created by Sena A on 8/24/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class NewHomeVC: UIViewController {

    @IBOutlet weak var idLbl: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLbl.text = user?.debugDescription ?? ""
        print(user?.firstName)
    }
}