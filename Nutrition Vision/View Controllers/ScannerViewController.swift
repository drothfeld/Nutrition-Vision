//
//  ScannerViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/2/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    
    var previewLayer: CALayer!
    var captureDevice: AVCaptureDevice!

    // Defined Values
    var currentScannedLabel: ScannedLabel = ScannedLabel(scannedImage: "null")
    var scannedImageName: String = "placeholder.png"
    var nutritionFeedback: String = ""
    var isHealthy: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        resetScanner()
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

