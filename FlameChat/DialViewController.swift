//
//  DialViewController.swift
//  FlameChat
//
//  Created by matthew on 2017-02-03.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import Firebase

var myPhoneNo = "";

class DialViewController: UIViewController {

    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.CallField.resignFirstResponder()
        
    }
    
    @IBOutlet weak var phoneNo: UILabel! // display current user's phone No.
    
    @IBOutlet weak var CallField: UITextField!
    
    
    internal func refresh(){
        manuallyRef(phone: myPhoneNo);
    }
 
    func manuallyRef(phone: String){
        
            firebase?.child("id").child(phone).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get call information
                let value = snapshot.value as? NSDictionary
                let call = value?["call"] as? String ?? ""
                
                if (call == "true"){
                    
                    /** show the beCalling view */
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "beCalling") as! BeCallingView
                    
                    self.present(popOverVC, animated: true, completion: nil)
                    
                    return;
                }
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        firebase?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let phone = value?["phone"] as? String ?? ""
            
            myPhoneNo = phone;
            
            self.phoneNo.text = "Your flameID: " + phone; // display phone No.
           
        }) { (error) in
            print(error.localizedDescription)
        }
        
        /** tested! */
        var timer: Timer;
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func logout(_ sender: Any) {
        /** change user status (online) to: false */
        let userID = FIRAuth.auth()?.currentUser?.uid
        firebase?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let phone = value?["phone"] as? String ?? ""
            
            firebase!.child("id").child(phone).updateChildValues(["online": "false"]);
            
        })

        logout_newview();
        
    }
    
    func logout_newview(){
        /** show the dial navigation controller */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! Login
        
        self.present(popOverVC, animated: true, completion: nil)
        
    }

    @IBAction func call(_ sender: Any) {
        let targetPhone = self.CallField!.text;
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        firebase?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let phone = value?["phone"] as? String ?? ""
            
            
            firebase?.child("id").child(targetPhone!).updateChildValues(["call": "true", "caller": phone]);
        })
    }
    
    
    @IBAction func manCheck(_ sender: Any) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        firebase?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let phone = value?["phone"] as? String ?? ""
            
            self.manuallyRef(phone: phone);
            
        })
    }
    

}// end of class
