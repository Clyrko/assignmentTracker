//
//  UITextFieldExtension.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/16/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

extension UITextField {
    var hasValue: Bool {
        guard text == "" else { return true }
        
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
        
        placeholder = "Required!"
        
        rightViewMode = .unlessEditing
        
        return false
    }
}
