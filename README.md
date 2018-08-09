# TextFieldsFlow
Switch to the next UITextField with a helper class and an extension.


## Description
This small piece of Swift code is a simple utility to switch to the next UITextField by pressing the "Next" button on your keyboard.

## Usage
To enable switching into a given set of fields:

```swift
[field1, field2, field3, field4].setFlowable(true)
```

You can even add a callback to call after a field has left focus:

```swift
field4.onConfirmTapped = {
    print("i'm working")
} 
```

## Installation
I don't think this short piece of code is worth making a pod so I'll keep it rough and make you copy-paste some code.
```swift 
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
```
## License
Copyright 2018 Mattia Contin <m.contin.dev@gmail.com> 
 
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: 
 
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. 
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 \ No newline at end of file 
