//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Denis Rakitin on 27/05/2018.
//  Copyright © 2018 Denis Rakitin. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    //Outlets
    @IBOutlet weak var goalTextView: UITextView!
    
    @IBOutlet weak var shortTermButton: UIButton!
    
    @IBOutlet weak var longTermButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
    }
    
    @IBAction func shortTermWasPressed(_ sender: Any) {
    }
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
    }
    


}
