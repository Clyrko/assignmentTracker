//
//  AppUIButton.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/7/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class AppUIButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = Theme.tintColor
        layer.cornerRadius = frame.height / 2
        setTitleColor(UIColor.white, for: .normal)
    }
}
