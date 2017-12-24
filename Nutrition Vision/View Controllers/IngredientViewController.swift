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
    @IBOutlet weak var IngredientDescriptionText: UITextView!
    @IBOutlet weak var IngredientImage: UIImageView!
    @IBOutlet weak var IngredientSourceText: UITextView!
    
    // Defined Values
    let attributedSourceString = NSMutableAttributedString(string: "Reference/Source")
    
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
                // Hypertext to reference site
                IngredientSourceText.text = String(describing: detailIngredient.source)
                attributedSourceString.addAttribute(.link, value: String(describing: detailIngredient.source), range: NSRange(location: 0, length: 16))
                IngredientSourceText.attributedText = attributedSourceString
                IngredientImage.image = detailIngredient.image
            }
        }
    }
    
    // Hiding status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
