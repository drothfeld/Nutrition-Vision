//
//  IngredientViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/14/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {
    // UI Elements
    
    
    // Defined Values
    var detailIngredient: Ingredient? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    // Setting up the view
    func configureView() {
//        if let detailCandy = detailIngredient {
//            if let detailDescriptionLabel = detailDescriptionLabel, let candyImageView = candyImageView {
//                detailDescriptionLabel.text = detailCandy.name
//                candyImageView.image = UIImage(named: detailCandy.name)
//                title = detailIngredient.category
//            }
//        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
