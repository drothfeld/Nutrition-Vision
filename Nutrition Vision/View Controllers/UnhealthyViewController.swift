//
//  UnhealthyViewController.swift
//  Nutrition Vision
//
//  Created by Dylan Rothfeld on 11/7/17.
//  Copyright © 2017 Dylan Rothfeld. All rights reserved.
//

import UIKit

class UnhealthyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let myarray = ["item1", "item2", "item3"]
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myarray.count
    }
    
    
    // Cell Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        cell.textLabel?.text = myarray[indexPath.item]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
