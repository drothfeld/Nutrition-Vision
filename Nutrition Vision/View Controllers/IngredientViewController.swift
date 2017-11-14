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
    @IBOutlet weak var IngredientNameLabel: UILabel!
    @IBOutlet weak var IngredientDescriptionText: UITextField!
    @IBOutlet weak var IngredientSourceLabel: UILabel!
    @IBOutlet weak var IngredientImage: UIImageView!
    
    // Defined Values
    var detailIngredient: Ingredient? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // Setting up the view
    func configureView() {
        if let detailIngredient = detailIngredient {
            if let IngredientDescriptionText = IngredientDescriptionText, let IngredientNameLabel = IngredientNameLabel {
                IngredientNameLabel.text = detailIngredient.name
                IngredientDescriptionText.text = detailIngredient.description
                //IngredientSourceLabel.text = detailIngredient.source
                //IngredientImage.image = UIImage(detailIngredient.image)
            }
        }
    }
    
    // Hiding status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
