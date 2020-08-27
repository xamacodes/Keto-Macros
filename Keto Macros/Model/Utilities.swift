//
//  Utilities.swift
//  Keto Macros
//
//  Created by Sena A on 8/25/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func errorMsg(_ message: String) {
        print(message)
    }
    
    //Creates template for the orange continue button
    static func createKeypadBtn(view: UIView) -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        btn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        btn.setTitle("Continue", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.addTarget(self, action: #selector(Utilities.closeKeypad), for: .allTouchEvents)
        return btn
    }
    
    @objc func closeKeypad(view: UIView) {
        view.endEditing(true)
    }
    
}
