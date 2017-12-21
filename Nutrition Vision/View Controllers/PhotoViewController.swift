//
//  PhotoViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 12/4/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit
import TesseractOCR

class PhotoViewController: UIViewController {
    
    // Defined Values
    var takenPhoto: UIImage?
    var currentScannedLabel: ScannedLabel!
    var nutritionFeedback: String = ""
    
    // UI Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var isHealthyLabel: UILabel!
    @IBOutlet weak var nutritionalFeedback: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAndSetPhotoTaken()
    }
    
    // Go Back Button
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // If there is a taken photo, display it
    func checkAndSetPhotoTaken() {
        if let availableImage = takenPhoto {
            imageView.image = availableImage
            processScannedImage(image: availableImage)
        }
    }
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Process image
    func processScannedImage(image: UIImage) {
        // Creating scanned label object
        currentScannedLabel = ScannedLabel(scannedImage: image)
        
        // Prepare and process image for text
        let scaledImage = currentScannedLabel.scannedImage.scaleImage(640)
        
//        activityIndicator.startAnimating()
//        dismiss(animated: true, completion: {
            self.performImageRecognition(scaledImage!)
//        })
        
        currentScannedLabel.parseText()
        currentScannedLabel.updateScannedValues()
        
        // Checking each nutrition value and creating
        // feedback
        for (index, scannedValue) in currentScannedLabel.scannedValues.enumerated() {
            if (scannedValue >= (nutritionValues[index].dailyMax/2)) {
                nutritionFeedback = nutritionFeedback + " " + currentScannedLabel.getNutritionFeedback(scannedValue: scannedValue, DVvalue: nutritionValues[index])
            }
        }
        
        NSLog("Sugar: " + String(describing: currentScannedLabel.scannedValues[6]))
        
        // Checking if there were any nutritional
        // issues with the scanned product
        if (nutritionFeedback.isEmpty) {
            NSLog("Healthy")
        } else {
            NSLog("Unhealthy")
        }
    }
    
    // Concatenating feedback string for all nutritional values
    func checkNutritionValues() {
        for (index, nutritionObject) in nutritionValues.enumerated() {
            nutritionFeedback += currentScannedLabel.getNutritionFeedback(scannedValue: currentScannedLabel.scannedValues[index], DVvalue: nutritionObject)
        }
    }
    
    // Tesseract Image Recognition
    func performImageRecognition(_ image: UIImage) {
        if let tesseract = G8Tesseract(language: "eng+fra") {
            tesseract.engineMode = .cubeOnly
            tesseract.pageSegmentationMode = .auto
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize()
            
            // Grabbing text for scannedLabel 
            currentScannedLabel.scannedText = tesseract.recognizedText
            NSLog("tesseract (" + String(describing: tesseract.engineMode) + "): " + tesseract.recognizedText)
        }
//        activityIndicator.stopAnimating()
    }
}

// UIImage extension
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
