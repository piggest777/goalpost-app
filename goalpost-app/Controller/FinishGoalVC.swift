//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Denis Rakitin on 28/05/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalButton: UIButton!
    
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButton.bindToKeyBoard()
         pointsTextField.delegate = self
    }

   
    @IBAction func createGoalWasPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            
            }
        
        
        }
        
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool)->())  {
        guard let managedContex = appDelagate?.persistentContainer.viewContext else {return}
        
        let goal = Goal(context: managedContex)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do{
        try managedContex.save()
            print("successfuly saved data!")
            completion(true)
        } catch {
            debugPrint("Could not save:\(error.localizedDescription)")
            completion(false)
        }
    }
}
