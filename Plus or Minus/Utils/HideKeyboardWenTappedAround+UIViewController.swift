//
//  HideKeyboardWenTappedAround+UIViewController.swift
//  Plus or Minus
//
//  Created by Julian Vöst on 29.08.18.
//  Copyright © 2018 Julian Vöst. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
