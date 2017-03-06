//
//  Personalize.swift
//  FlameChat
//
//  Created by matthew on 2017-03-04.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

var NIGHTMODE = "off"

class Personalize: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changePW(_ sender: Any) {
        guard let password = self.passwordField.text else {
            return
        }
        if(password != ""){
            firebase?.child("users").child(myPhoneNo).updateChildValues(["passwd": password]);
            
            /** show sign up successful message */
            let alert = UIAlertController(title: "Note well", message: "Your password has been changed!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "I understand", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil) 
        }
    }

    @IBAction func changeNM(_ sender: Any) {
        guard let name = self.nameField.text else {
            return
        }
        if(name != ""){
            firebase?.child("users").child(myPhoneNo).updateChildValues(["name": name]);
            
            /** show sign up successful message */
            let alert = UIAlertController(title: "Note well", message: "Your name has been changed!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "I understand", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func changeEM(_ sender: Any) {
        guard let email = self.emailField.text else {
            return
        }
        if(email != ""){
            firebase?.child("users").child(myPhoneNo).updateChildValues(["email": email]);
            
            /** show sign up successful message */
            let alert = UIAlertController(title: "Note well", message: "Your email address has been changed!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "I understand", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func defaultTheme(_ sender: Any) {
        theme = "blue";
        firebase?.child("users").child(myPhoneNo).updateChildValues(["theme": "blue"]);
        self.view.backgroundColor = UIColor(displayP3Red: 0.12, green: 0.29, blue: 0.58, alpha: 1)
    }
    @IBAction func greyTheme(_ sender: Any) {
        theme = "grey";
        firebase?.child("users").child(myPhoneNo).updateChildValues(["theme": "grey"]);
        self.view.backgroundColor = UIColor.gray;
    }
    @IBAction func redTheme(_ sender: Any) {
        theme = "pink";
        firebase?.child("users").child(myPhoneNo).updateChildValues(["theme": "pink"]);
        self.view.backgroundColor = UIColor(displayP3Red: 0.95, green: 0.64, blue: 0.59, alpha: 1)
    }
    @IBAction func greenTheme(_ sender: Any) {
        theme = "green";
        firebase?.child("users").child(myPhoneNo).updateChildValues(["theme": "green"]);
        self.view.backgroundColor = UIColor(displayP3Red: 0.49, green: 0.70, blue: 0.35, alpha: 1)
    }
   
    
    @IBOutlet weak var nite: UISwitch!
    @IBAction func niteSwitch(_ sender: Any) {
        if nite.isOn {
            NIGHTMODE = "on"
            self.view.backgroundColor = UIColor.black;
        } else {
            NIGHTMODE = "off"
            if (theme == "blue") {
                self.view.backgroundColor = UIColor(displayP3Red: 0.12, green: 0.29, blue: 0.58, alpha: 1)
            }
            if (theme == "grey") {
                self.view.backgroundColor = UIColor.gray
            }
            if (theme == "pink") {
                self.view.backgroundColor = UIColor(displayP3Red: 0.95, green: 0.64, blue: 0.59, alpha: 1)
            }
            if (theme == "green") {
                self.view.backgroundColor = UIColor(displayP3Red: 0.49, green: 0.70, blue: 0.35, alpha: 1)
            }
        }
    }
    
    
    
    
}
