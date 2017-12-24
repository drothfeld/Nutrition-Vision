//
//  Ingredient.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/9/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class Ingredient {
    // Fields
    var name: String
    var description: String
    var image: UIImage
    var source: URL
    
    // Constructor
    init(name: String, description: String, source: URL, image: UIImage) {
        self.name = name
        self.description = description
        self.source = source
        self.image = image
    }
}
