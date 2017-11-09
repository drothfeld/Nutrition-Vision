//
//  UnhealthyViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/7/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class UnhealthyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // User Interface Outlets
    @IBOutlet weak var UnhealthyIngredientsTableView: UITableView!
    
    // Defined Values
    var sortedUnhealthyIngredients: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshTable()
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unhealthyIngredients.count
    }
    
    
    // Cell Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        cell.textLabel?.text = sortedUnhealthyIngredients[indexPath.item].name
        return cell
    }
    
    // Sort list of unhealthy ingredients alphabetically
    func sortIngredientsAlphabetically(unsortedList: Array<Ingredient>) -> Array<Ingredient> {
        return unsortedList.sorted { $0.name < $1.name }
    }
    
    // Table Refresh
    func refreshTable() {
        sortedUnhealthyIngredients = sortIngredientsAlphabetically(unsortedList: unhealthyIngredients)
        self.UnhealthyIngredientsTableView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
