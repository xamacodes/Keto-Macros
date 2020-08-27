//
//  ModBorderButton.swift
//  Keto Macros
//
//  Created by Sena A on 8/14/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class ModBorderButton: UIButton { //Simply for curving the edges 

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}
