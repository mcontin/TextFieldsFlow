//
//  UITextFieldFlower.swift
//  TextFieldsFlow
//
//  Created by Mattia on 14/05/2018.
//  Copyright © 2018 mcontin. All rights reserved.
//

import UIKit

// Class that handles the fields switching.
// If there's no next field, calls the function associated to the onConfirmTapped callback
class UITextFieldFlower: NSObject, UITextFieldDelegate {
    
    private override init() {}
    static let shared = UITextFieldFlower()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // else
            textField.resignFirstResponder()
            textField.onConfirmTapped?()
        }
        return false
    }
    
}
