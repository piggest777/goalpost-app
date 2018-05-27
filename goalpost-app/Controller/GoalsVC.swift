//
//  ViewController.swift
//  goalpost-app
//
//  Created by Denis Rakitin on 26/05/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let goal = Goal()
        goal.goalCompletionValue = Int32(exactly: 12.0)

    }

    @IBAction func addButtonWasPressed(_ sender: Any) {
    }
    

}

