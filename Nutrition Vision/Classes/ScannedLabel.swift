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
    var scannedValues: [Int]
    
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
        
        self.scannedValues = [
            sodium,
            cholesterol,
            total_carbohydrate,
            dietary_fiber,
            saturated_fat,
            total_fat,
            sugar,
            protein
        ]
    }
    
    // Description returned for nutritional value comparison
    private func overDailyMax(nutritionalValue: String, halfToMax: Bool) -> String {
        return "The amount of " + nutritionalValue + " in a single serving of this product is more than" + (halfToMax ? " half of " : " ") + "the healthy daily allowance."
    }
    
    // Parse nutrition values from extended
    // string extracted from image
    func parseText() {
        let splitTextArray = self.scannedText.components(separatedBy:  " ")
        for (index, text) in splitTextArray.enumerated() {
            
            // FOR TESTING:
            NSLog("NEW INDEX: " + text)
            if ((text.lowercased().range(of:"sugar") != nil) ||
                (text.lowercased().range(of:"sugars") != nil) ||
                (text.lowercased().range(of:"protein") != nil) ||
                (text.lowercased().range(of:"fiber") != nil)) {
                NSLog("----------------------")
                NSLog("SUGAR/PROTEIN AMOUNT: " + splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
//                let number = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
                NSLog("----------------------")
            }
            
            if (text.lowercased().range(of:"fiber") != nil && Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
                self.dietary_fiber = Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
            }
            
            if (((text.lowercased().range(of:"sugar") != nil) ||
                (text.lowercased().range(of:"sugars") != nil)) &&
                Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
                self.sugar = Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
            }
            
            if (text.lowercased().range(of:"protein") != nil && Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
                self.protein = Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
            }
            
            switch text {
                case "Sodium":
                    if (Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
                        self.sodium = Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
                    }

                case "Cholesterol":
                    if (Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
                        self.cholesterol = (Int(splitTextArray[index + 1].dropLast().dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()))!
                    }
                
                case "Total":
                    if (splitTextArray[index + 1] == "Fat") {
                        if (Int(splitTextArray[index + 2].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
                            self.total_fat = Int(splitTextArray[index + 2].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
                        }
                    } else if (splitTextArray[index + 1] == "Carbohydrate") {
                        self.total_carbohydrate = Int(splitTextArray[index + 2].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
                    }
                
//                case "Fiber":
//                    if (Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
//                        self.dietary_fiber = Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
//                    }
                
                case "Saturated":
                    if (Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
                        self.saturated_fat = Int(splitTextArray[index + 2].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
                    }
                
//                case "Sugar", "Sugars":
//                    if (Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
//                        self.sugar = Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
//                    }
//
//                case "Protein":
//                    if (Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) != nil) {
//                        self.protein = Int(splitTextArray[index + 1].dropLast().components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
//                    }
                
                default:
                    break
            }
        }
    }
    
    // Update scanned values array
    func updateScannedValues() {
        self.scannedValues = [
            sodium,
            cholesterol,
            total_carbohydrate,
            dietary_fiber,
            saturated_fat,
            total_fat,
            sugar,
            protein
        ]
    }
    
    // Get text feedback about scanned
    // nutrition value compared to healthy DV
    func getNutritionFeedback(scannedValue: Int, DVvalue: NutritionValue) -> String {
        if (scannedValue > DVvalue.dailyMax) {
            return overDailyMax(nutritionalValue: DVvalue.name, halfToMax: false)
        } else if ((scannedValue <= DVvalue.dailyMax) && (scannedValue >= (DVvalue.dailyMax/2))) {
            return overDailyMax(nutritionalValue: DVvalue.name, halfToMax: true)
        }
        return ""
    }
}
