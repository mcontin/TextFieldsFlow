//
//  SecondViewController.swift
//  TextFieldsFlow
//
//  Created by CrispyBacon018 on 07/08/2018.
//  Copyright © 2018 mcontin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [textfield1, textfield2, textfield3, textfield4].setFlowable(true)
        
        // did this small test just to make sure there were no conflicts with the previous controller's text fields
        textfield4.onConfirmTapped = {
            print("i'm working too!")
        }
    }

}
