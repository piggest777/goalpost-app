//
//  ViewController.swift
//  goalpost-app
//
//  Created by Denis Rakitin on 26/05/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit
import CoreData

let appDelagate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variable
    
    var goals: [Goal] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     tableView.delegate = self
     tableView.dataSource = self
     tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObject()
               tableView.reloadData()
    }
    
    func fetchCoreDataObject() {
    self.fetch { (comlplete) in
    if comlplete {
    if goals.count >= 1 {
    tableView.isHidden = false
    
        } else {
        tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addButtonWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
        
    }
    

}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowenAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObject()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [deleteAction]
    }
}

extension GoalsVC {
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelagate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(goals[indexPath.row])
        
        do{
            try managedContext.save()
            print("Successfuly removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    
    func fetch(completion: (_ complete: Bool)->())  {
        guard let managedContext = appDelagate?.persistentContainer.viewContext else { return  }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
      goals =  try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}







