//
//  ChatView.swift
//  FlameChat
//
//  Created by matthew on 2017-02-10.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import Firebase

class ChatView: UIViewController {
    
    @IBOutlet weak var otherEmailField: UILabel!
    @IBOutlet weak var otherTextFeild: UILabel!
    @IBOutlet weak var myTextField: UILabel!
    @IBOutlet weak var composetField: UITextField!
    
    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.composetField.resignFirstResponder()
        
    }
    
    internal func getMsg(){
        firebase?.child("users").child(myPhoneNo).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let msg = value?["message"] as? String ?? ""
            
            self.otherTextFeild.text! = msg;
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** display other's email */
        firebase?.child("users").child(yourPhoneNo).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let yourName = value?["name"] as? String ?? ""
            
            self.otherEmailField.text! = yourName;
        })
        
        /** refresh */
        var timer: Timer;
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getMsg), userInfo: nil, repeats: true);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** Send button */
    @IBAction func sentMsg(_ sender: Any) {
        
        let toBeSent = self.composetField.text!;
        
        firebase?.child("users").child(yourPhoneNo).updateChildValues(["message": toBeSent]); // send message
        
        self.myTextField.text! = toBeSent;
        
        self.composetField.text! = "" // clean composet field
        
    }
    
    
    
}
