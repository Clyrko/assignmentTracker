//
//  DateExtension.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/16/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func add(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: Date())!
    }
}
