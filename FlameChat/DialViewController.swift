//
//  DialViewController.swift
//  FlameChat
//
//  Created by matthew on 2017-02-03.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import Firebase

class DialViewController: UIViewController {

    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.CallField.resignFirstResponder()
        
    }
    
    @IBOutlet weak var statusField: UILabel!
    
    @IBOutlet weak var phoneNo: UILabel! // display current user's phone No.
    
    @IBOutlet weak var CallField: UITextField!
    

    internal func refresh(){
        manuallyRef(phone: myPhoneNo);
    }
 
    func manuallyRef(phone: String){
        
            firebase?.child("users").child(phone).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get call information
                let value = snapshot.value as? NSDictionary
                let status = value?["status"] as? String ?? ""
                
                if (status == "beingCalled"){
                    
                    /** show the beCalling view */
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "beCalling") as! BeCallingView
                    
                    self.present(popOverVC, animated: true, completion: nil)
                    
                    return;

                }
                
                if (status == "canceled"){
                    self.statusField.text! = "No answer."
                    firebase!.child("users").child(myPhoneNo).updateChildValues(["status": "online"]);
                }
                
                if (status == "calling"){
                    self.statusField.text! = "Calling..."
                }
                
                if (status == "chatting"){
                    
                    /** present dial view */
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chat") as! ChatView
                    
                    self.present(popOverVC, animated: true, completion: nil)
                    
                    return;
                }
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneNo.text = "Your flameID: " + myPhoneNo; // display phone No.
        
        /** waitnig for calling! */
        var timer: Timer;
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func logout(_ sender: Any) {
        /** change user status (online) to: false */
        firebase!.child("users").child(myPhoneNo).updateChildValues(["status": "offline"]);

        myPhoneNo = "";
        yourPhoneNo = "";
        
        logout_newview();
        
    }
    
    func logout_newview(){
        /** show the dial navigation controller */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! Login
        
        self.present(popOverVC, animated: true, completion: nil)
        
    }

    @IBAction func call(_ sender: Any) {
        let targetPhone = self.CallField!.text;
        yourPhoneNo = targetPhone!;
       
        firebase?.child("users").child(yourPhoneNo).updateChildValues(["status": "beingCalled", "caller": myPhoneNo]);
        firebase?.child("users").child(myPhoneNo).updateChildValues(["status": "calling"])
        
        self.statusField.text! = "Calling..."
    }
    

}// end of class
