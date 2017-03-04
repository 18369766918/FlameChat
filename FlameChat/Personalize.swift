//
//  Personalize.swift
//  FlameChat
//
//  Created by matthew on 2017-03-04.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

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
    
}
