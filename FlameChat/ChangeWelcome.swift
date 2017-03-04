//
//  ChangeWelcome.swift
//  FlameChat
//
//  Created by matthew on 2017-03-03.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

class ChangeWelcome: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.messageField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func set(_ sender: Any) {
        guard let welcome = self.messageField.text else {
            return
        }
        if(welcome != ""){
            firebase?.child("users").child(myPhoneNo).updateChildValues(["welcome": welcome]);
            
            /** show sign up successful message */
            let alert = UIAlertController(title: "Note well", message: "Your welcome message has been changed!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "I understand", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }

    }

}
