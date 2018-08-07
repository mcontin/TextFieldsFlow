//
//  UITextField.swift
//  TextFieldsFlow
//
//  Created by CrispyBacon018 on 07/08/2018.
//  Copyright © 2018 mcontin. All rights reserved.
//

import UIKit

private var objcKey: UInt8 = 0

/// Extend UITextField in order to add a confirm callback to a specific field
extension UITextField {
    
    /// Called by the final UITextField of a flowable array of UITextFields
    var onConfirmTapped: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &objcKey) as? () -> Void
        }
        set(newValue) {
            objc_setAssociatedObject(self, &objcKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}

extension Array where Element: UITextField {
    
    /// Sets this array of text fields as flowable by assigning them and index and a delegate
    func setFlowable(_ enabled: Bool) {
        for (index, textField) in enumerated() {
            textField.tag = index
            textField.delegate = enabled ? UITextFieldFlower.shared : nil
        }
    }
    
}
