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
        
        setupView()
        
        //print(user?.firstName)
    }
    
    //Sets up the initial view
    func setupView() {
        idLbl.text = user?.debugDescription ?? ""
    }
    
}
