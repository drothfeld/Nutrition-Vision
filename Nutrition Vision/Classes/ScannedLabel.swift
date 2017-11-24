//
//  ScannedLabel.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/23/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class ScannedLabel {
    // Fields
    var scannedImage: UIImage
    var scannedText: String
    var sodium, cholesterol, total_carbohydrate, dietary_fiber, saturated_fat, total_fat, sugar, protein: Int
    
    // Constructor
    init(scannedImage: UIImage) {
        self.scannedImage = scannedImage
        self.scannedText = ""
        self.sodium = 0
        self.cholesterol = 0
        self.total_carbohydrate = 0
        self.dietary_fiber = 0
        self.saturated_fat = 0
        self.total_fat = 0
        self.sugar = 0
        self.protein = 0
        
        self.extractTextFromImage()
    }
    
    // TODO: Implement SwiftOCR library to
    // create nerual net that extracts a string
    // from the scanned image
    func extractTextFromImage() {
        self.scannedText = "Total Fat 14g Saturated Fat 9g Cholesterol 55mg Sodium 75g"
    }
    
    // Parse nutrition values from extended
    // string extracted from image
    func parseText() {
        let splitTextArray = self.scannedText.components(separatedBy:  " ")
        for (index, text) in splitTextArray.enumerated() {
            switch (text) {
                case "Sodium":
                    self.sodium = Int(splitTextArray[index + 1].dropLast())!
                
                case "Cholesterol":
                    self.cholesterol = (Int(splitTextArray[index + 1].dropLast().dropLast()))!
                
                case "Total":
                    if (splitTextArray[index + 1] == "Fat") {
                        self.total_fat = Int(splitTextArray[index + 2].dropLast())!
                    }
                default:
                    break
            }
            
        }
    }
}
