//
//  CreateAccount.swift
//  FlameChat
//
//  Created by matthew on 2017-02-17.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

class CreateAccount: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var FlameIDField: UITextField!
    @IBOutlet weak var PasswdField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    
    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.FlameIDField.resignFirstResponder()
        self.PasswdField.resignFirstResponder()
        self.NameField.resignFirstResponder()
        self.EmailField.resignFirstResponder()
    }

    @IBAction func accept(_ sender: Any) {
        guard let phone = self.FlameIDField.text else {
            return
        }
        guard let password = self.PasswdField.text else{
            return
        }
        guard let name = self.NameField.text else{
            return
        }
        guard let email = self.EmailField.text else{
            return
        }
        if(phone != "" && password != ""){
            firebase?.child("users").child(phone).setValue(["status":"offline", "passwd": password, "name": name, "email": email, "welcome": "Please leave me a message."])
            firebase?.child("users").child(phone).child("mailBox").setValue(["mailNum": "0", "AUTH": "0"]);
           
            /** show sign up successful message */
            let alert = UIAlertController(title: "Thank you!", message: "Welcome, our new member!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Start chat now!", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            

        }

    }
    
    
    
    @IBAction func giveUp(_ sender: Any) {
        /** show the dial navigation controller */
        /** present dial view */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! Login
        
        self.present(popOverVC, animated: true, completion: nil)
        
    }
    
}
