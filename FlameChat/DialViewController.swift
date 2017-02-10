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

    //var firebase: FIRDatabaseReference?
    
    @IBOutlet weak var phoneNo: UILabel! // display current user's phone No.
    
    @IBOutlet weak var CallField: UITextField!
    
    
    func refresh(phone: String){
        
        
    
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
                    
                }
                
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // current user, not used
        let current = FIRAuth.auth()?.currentUser
        

        let userID = FIRAuth.auth()?.currentUser?.uid
        firebase?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let phone = value?["phone"] as? String ?? ""
            
            self.phoneNo.text = "Your flameID: " + phone; // display phone No.
            
            //self.refresh(phone: phone); // TEST TEST TEST POAWOEPWORPOPFDOBPDFOBPDGOBPOGBPFGOBPOFPGOBPDOGBPFOGPBOFPGOB

        }) { (error) in
            print(error.localizedDescription)
        }
        
        
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
