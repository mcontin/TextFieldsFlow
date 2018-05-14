//
//  UITextFieldFlower.swift
//  TextFieldsFlow
//
//  Created by Mattia on 14/05/2018.
//  Copyright © 2018 mcontin. All rights reserved.
//

import UIKit

private var objcKey: UInt8 = 0

// Extend UITextField in order to add a confirm callback to a specific field
extension UITextField {
    
    // Function called by the final UITextField of a flowable array of UITextFields
    var onConfirmTapped: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &objcKey) as? () -> Void
        }
        set(newValue) {
            objc_setAssociatedObject(self, &objcKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}

// Add the setFlowable function only to arrays of UITextFields
extension Array where Element: UITextField {
    
    // We must use a function because Array is a struct and we can't use a computed property
    func setFlowable(_ enabled: Bool) {
        for (index, textField) in enumerated() {
            textField.tag = index
            textField.delegate = enabled ? UITextFieldFlower.shared : nil
        }
    }
    
}

// Class that handles the fields switching.
// If there's no next field, calls the function associated to the onConfirmTapped callback
fileprivate class UITextFieldFlower: NSObject, UITextFieldDelegate {
    
    private override init() {}
    fileprivate static let shared = UITextFieldFlower()
    
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
