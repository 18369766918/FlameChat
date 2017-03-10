//
//  Compose.swift
//  FlameChat
//
//  Created by matthew on 2017-02-12.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import Firebase

class Compose: UIViewController {
    
    @IBOutlet weak var receiverField: UITextField!
    @IBOutlet weak var contentField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if (NIGHTMODE == "on"){
            self.view.backgroundColor = UIColor.black;
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func sendMail(_ sender: Any) {
        var receiver = self.receiverField.text!;
        var content = self.contentField.text!;
        
        firebase?.child("users").child(receiver).child("mailBox").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var mailNum = value?["mailNum"] as? String ?? ""
            
            var num:Int? = (Int)(mailNum);
            var newNum = num! + 1;
            mailNum = String(describing: newNum);
            
            /** send mail to receiver */
            if(receiver != "" && content != ""){
                firebase!.child("users").child(receiver).child("mailBox").updateChildValues(["mailNum": mailNum]);
                firebase!.child("users").child(receiver).child("mailBox").child(mailNum).setValue(["time": "2017", "content": content, "sender": myPhoneNo])
            }
            
        })
        
        
        
        /** display success slogan */
        let successAlert = UIAlertController(title: "Your mail has been sent!", message: "", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
        successAlert.addAction(defaultAction)
        self.present(successAlert, animated: true, completion: nil)
        
        /** clear fields */
        self.receiverField.text! = ""
        self.contentField.text! = ""
    }
    
    
    @IBAction func groupSend(_ sender: Any) {
        var tmp = self.contentField.text!;
        content = tmp;
    }
    
    
}
