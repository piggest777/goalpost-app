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
    
    @IBOutlet weak var undoView: UIView!
    
    @IBOutlet weak var undoViewHeightConst: NSLayoutConstraint!
    
    //Variable
    
    var goals: [Goal] = []
    var undoGoals: [GoalToRestore] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        undoView.isHidden = true
        undoViewHeightConst.constant = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObject()
               tableView.reloadData()
        
    }
    
    
    @IBAction func undoBtnWasPressed(_ sender: Any) {
        
        for goal in undoGoals {
            restoreGoals(goalToSave: goal) { (successeful) in
                if successeful {
                    undoGoals.removeFirst()
                    print(undoGoals)
                }
            }
        }
        

        
    fetchCoreDataObject()
    undoView.isHidden = true
    undoViewHeightConst.constant = 0
    tableView.reloadData()
    view.setNeedsDisplay()
        
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
        undoGoals = []
        undoView.isHidden = true
        undoViewHeightConst.constant = 0
        
    }
    
    func keepGoal (description: String, type: String, progress: Int32, completion: Int32 ) {
        let restoreDate = GoalToRestore(description: description, goalType: type, goalProgress: progress, goalCompletion: completion)
        
       undoGoals.append(restoreDate)
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
            
            let goalToRemove = self.goals[indexPath.row]
            self.keepGoal(description: goalToRemove.goalDescription!, type: goalToRemove.goalType!, progress: goalToRemove.goalProgress, completion: goalToRemove.goalCompletionValue)
            self.removeGoal(atIndexPath: indexPath)
            self.undoView.isHidden = false
            self.undoViewHeightConst.constant = 50
            self.view.setNeedsDisplay()
            self.fetchCoreDataObject()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowenAtcinson, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath ) {
        guard let managedContext = appDelagate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        do {
            try managedContext.save()
            print("Successfuly set progress")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelagate?.persistentContainer.viewContext else {return}
        
//        undoGoals.append(goals[indexPath.row])
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
    
    func restoreGoals (goalToSave goal: GoalToRestore, completion: (_ finished: Bool)->()) {
        guard let managedContex = appDelagate?.persistentContainer.viewContext else {return}
        
         let goalToRestore = Goal(context: managedContex)
        
        
        goalToRestore.goalDescription = goal.description
        goalToRestore.goalType = goal.goalType
        goalToRestore.goalCompletionValue = goal.goalCompletion
        goalToRestore.goalProgress = goal.goalProgress
        
        do{
            try managedContex.save()
            print("successfuly restore data!")
            completion(true)
        } catch {
            debugPrint("Could not restore:\(error.localizedDescription)")
            completion(false)
        }
    }
    
}







