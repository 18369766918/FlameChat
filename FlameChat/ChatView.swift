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
            let status = value?["status"] as? String ?? ""
            
            self.otherTextFeild.text! = ":" + msg;
            
            if(status == "online"){
                self.otherTextFeild.text! = "Other person ended chat.";
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** display other's email */
        firebase?.child("users").child(yourPhoneNo).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let yourName = value?["name"] as? String ?? ""
            
            self.otherEmailField.text! = "Chatting with: " + yourName;
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
        
        self.myTextField.text! = "me: " + toBeSent;
        
        self.composetField.text! = "" // clean composet field
        
    }
    
    /** end call */
    @IBAction func end(_ sender: Any) {
        firebase?.child("users").child(yourPhoneNo).updateChildValues(["message": ""]);
        firebase?.child("users").child(myPhoneNo).updateChildValues(["message": ""]);
        
        firebase?.child("users").child(yourPhoneNo).updateChildValues(["status": "online"]);
        firebase?.child("users").child(myPhoneNo).updateChildValues(["status": "online"]);
        
        firebase?.child("users").child(yourPhoneNo).updateChildValues(["caller": ""]);
        firebase?.child("users").child(myPhoneNo).updateChildValues(["caller": ""]);

        yourPhoneNo = "";
        
        /** present dial view */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dial") as! DialViewController
        self.present(popOverVC, animated: true, completion: nil)
    }
    
    
}
