//
//  UnhealthyViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/7/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class UnhealthyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // User Interface Outlets
    @IBOutlet weak var UnhealthyIngredientsTableView: UITableView!
    @IBOutlet weak var UnhealthyIngredientSearchBar: UISearchBar!
    
    // Defined Values
    var sortedUnhealthyIngredients: [Ingredient] = []
    var filteredUnhealthyIngredients: [Ingredient] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshTable()
        searchBarSetup()
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching) {
            return filteredUnhealthyIngredients.count
        }
        return unhealthyIngredients.count
    }
    
    // Cell Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        if (isSearching) {
            cell.textLabel?.text = filteredUnhealthyIngredients[indexPath.item].name
        } else {
            cell.textLabel?.text = sortedUnhealthyIngredients[indexPath.item].name
        }
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
    
    // Search Bar Setup
    func searchBarSetup() {
        UnhealthyIngredientSearchBar.delegate = self
        UnhealthyIngredientSearchBar.returnKeyType = UIReturnKeyType.done
    }
    
    // Search Bar Functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (UnhealthyIngredientSearchBar.text == nil || UnhealthyIngredientSearchBar.text == "") {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            filteredUnhealthyIngredients = sortedUnhealthyIngredients.filter( {$0.name.lowercased().contains(UnhealthyIngredientSearchBar.text!.lowercased())} )
        }
        UnhealthyIngredientsTableView.reloadData()
    }
    
    // Preparing Ingredient to get details on
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = UnhealthyIngredientsTableView.indexPathForSelectedRow {
            let ingredient: Ingredient
            if isSearching {
                ingredient = filteredUnhealthyIngredients[indexPath.row]
            } else {
                ingredient = sortedUnhealthyIngredients[indexPath.row]
            }
            let controller = segue.destination as! IngredientViewController
            controller.detailIngredient = ingredient
        }
    }
    
    // Hiding status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
