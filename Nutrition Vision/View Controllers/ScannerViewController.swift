//
//  ScannerViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/2/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController {

    // Defined Values
    var currentScannedLabel: ScannedLabel = ScannedLabel(scannedImage: "null")
    var scannedImageName: String = "placeholder.png"
    var nutritionFeedback: String = ""
    var isHealthy: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        resetScanner()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Resetting all scanner values
    func resetScanner() {
        nutritionFeedback = ""
        isHealthy = true
        // TODO: Need to grab the string from the
        // name of the image that user takes
        scannedImageName = "placeholder.png"
        currentScannedLabel = ScannedLabel(scannedImage: scannedImageName)
    }
    
    // Concatenating feedback string for all nutritional values
    func checkNutritionValues() {
        for (index, nutritionObject) in nutritionValues.enumerated() {
            nutritionFeedback += currentScannedLabel.getNutritionFeedback(scannedValue: currentScannedLabel.scannedValues[index], DVvalue: nutritionObject)
        }
    }


}

