//
//  PhotoViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 12/4/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // Defined Values
    var takenPhoto: UIImage?
    
    // UI Outlets
    @IBOutlet weak var imageView: UIImageView!
    
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
        }
    }
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
