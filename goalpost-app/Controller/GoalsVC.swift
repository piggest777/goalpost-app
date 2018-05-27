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
     tableView.delegate = self
     tableView.dataSource = self
     tableView.isHidden = false
    }

    @IBAction func addButtonWasPressed(_ sender: Any) {
    }
    

}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        
        cell.configureCell(description: "description", type: .shortTerm, goalProgressAmount: 2)
        
        return cell
    }
}

