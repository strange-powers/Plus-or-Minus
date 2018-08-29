//
//  NewActionViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 29.07.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

class NewActionViewController: UIViewController {
    
    var day: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBOutlet weak var descTxtField: UITextField!
    
    @IBAction func addNewAction(_ sender: Any?) {
        guard let button = sender as? UIButton else {
            return
        }
        
        guard let desc = descTxtField.text else {
            return
        }
        
        let conclusions = [true, false]
        
        createNewAction(with: conclusions[button.tag], and: desc)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func createNewAction(with conclusion: Bool, and desc: String) {
        let data: Dictionary<String, Any> = [
            DayActionController.CONCLUSION_KEY: conclusion,
            DayActionController.DAY_KEY: day,
            DayActionController.DESC_KEY: desc,
            DayActionController.CREATED_AT_KEY: Date()
        ]
        
        DayActionController.createDayAction(with: data)
        application.saveContext()
    }
    
}
