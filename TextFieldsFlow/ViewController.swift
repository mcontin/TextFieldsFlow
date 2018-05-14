//
//  ViewController.swift
//  TextFieldsFlow
//
//  Created by Mattia on 14/05/2018.
//  Copyright © 2018 mcontin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var field1: UITextField!
    @IBOutlet var field2: UITextField!
    @IBOutlet var field3: UITextField!
    @IBOutlet var field4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [field1, field2, field3, field4].setFlowable(true)
        
        field4.onConfirmTapped = {
            print("i'm working")
        }
    }
    
    deinit {
        [field1, field2, field3, field4].setFlowable(false)
    }

}
