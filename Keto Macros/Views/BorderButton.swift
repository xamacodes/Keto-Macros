//
//  BorderButton.swift
//  Keto Macros
//
//  Created by Sena A on 7/31/20.
//  Copyright © 2020 Project X. All rights reserved.
//

import UIKit

class BorderButton: UIButton { //For curving the edges and adding a border

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 3.0
        layer.cornerRadius = 5
    }

}
