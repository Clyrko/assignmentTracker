//
//  PopupUIView.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/7/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class PopupUIView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
        
        backgroundColor = Theme.backgroundColor
        
    }
}
