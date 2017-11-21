//
//  NutritionValue.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/21/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class NutritionValue {
    // Fields
    var name: String
    var description: String
    var units: String
    var dailyMax: Int
    var source: URL
    
    // Constructor
    init(name: String, description: String, units: String, dailyMax: Int, source: URL) {
        self.name = name
        self.description = description
        self.units = units
        self.dailyMax = dailyMax
        self.source = source
    }
}
