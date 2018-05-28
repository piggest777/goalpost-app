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
    }
    
}
