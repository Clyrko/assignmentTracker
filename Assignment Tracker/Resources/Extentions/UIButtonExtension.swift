//
//  UIButtonExtension.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/7/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

extension UIButton {
    
    func createFloatingButtonAction() {
        backgroundColor = Theme.tintColor
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize (width: 0, height: 10)
    }
}
