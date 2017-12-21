//
//  ScannerViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/2/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // Defined Values
    let captureSession = AVCaptureSession()
    var previewLayer: CALayer!
    var captureDevice: AVCaptureDevice!
    var takePhoto = false
    var currentScannedLabel: ScannedLabel!
    var nutritionFeedback: String = ""
    var isHealthy: Bool = true
    
    // UI Elements
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resetScanner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareCamera()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Used to set up the camera
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        captureDevice = availableDevices.first
        beginSession()
    }
    
    // Start camera session
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        self.previewLayer = previewLayer
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        
        captureSession.startRunning()
            
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [((kCVPixelBufferPixelFormatTypeKey as NSString) as String): NSNumber(value: kCVPixelFormatType_32BGRA)]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if takePhoto {
            takePhoto = false
            // Get an image from sample buffer
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer) {
                DispatchQueue.main.async {
                    let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
                    photoVC.takenPhoto = image
                    
                    self.present(photoVC, animated: true, completion: {
                        self.stopCaptureSession()
                    })
                }
                // Creating scanned label object
                currentScannedLabel = ScannedLabel(scannedImage: image)
                currentScannedLabel.extractTextFromImage()
                currentScannedLabel.parseText()
                currentScannedLabel.updateScannedValues()
                
                // Checking each nutrition value and creating
                // feedback
                for (index, scannedValue) in currentScannedLabel.scannedValues.enumerated() {
                    if (scannedValue >= (nutritionValues[index].dailyMax/2)) {
                        nutritionFeedback = nutritionFeedback + " " + currentScannedLabel.getNutritionFeedback(scannedValue: scannedValue, DVvalue: nutritionValues[index])
                    }
                }
                
                // Checking if there were any nutritional
                // issues with the scanned product
                if (nutritionFeedback.isEmpty) {
                    NSLog("Healthy")
                } else {
                    NSLog("Unhealthy")
                }
            }
        }
    }
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer) ->UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage((ciImage), from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        return nil
    }
    
    func stopCaptureSession() {
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
            }
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        takePhoto = true
    }
    
    // Resetting all scanner values
    func resetScanner() {
        nutritionFeedback = ""
        isHealthy = true
        // TODO: Need to grab the string from the
        // name of the image that user takes
    }
    
    // Concatenating feedback string for all nutritional values
    func checkNutritionValues() {
        for (index, nutritionObject) in nutritionValues.enumerated() {
            nutritionFeedback += currentScannedLabel.getNutritionFeedback(scannedValue: currentScannedLabel.scannedValues[index], DVvalue: nutritionObject)
        }
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

