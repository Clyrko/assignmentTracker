//
//  UIViewExtentions.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadows() {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    func addRoundedCorners() {
        layer.cornerRadius = 10
    }
}
