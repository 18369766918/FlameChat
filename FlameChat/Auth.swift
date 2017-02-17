//
//  Auth.swift
//  FlameChat
//
//  Created by matthew on 2017-02-17.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

var AUTH = "";

class Auth: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** get version NO: AUTH */
        firebase?.child("users").child(myPhoneNo).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var tmp = value?["AUTH"] as? String ?? ""
            
            AUTH = tmp;
            var auth:Int? = (Int)(AUTH);
            //auth = auth! + 1;
            AUTH = "\(auth!)";
            
            print("TTTTTTT\n")
            print(AUTH)
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(_ sender: Any) {
        /** change user status (online) to: false */
        
        
        //myPhoneNo = "";
        yourPhoneNo = "";
        firebase!.child("users").child(myPhoneNo).updateChildValues(["status": "offline"])
        
        logout_newview();
    }
    
    func logout_newview(){
        /** show the dial navigation controller */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! Login
        
        self.present(popOverVC, animated: true, completion: nil)
        
    }

    
    @IBOutlet weak var broadcastField: UITextField!
    
    @IBAction func broadcast(_ sender: Any) {
        var content = self.broadcastField.text!;
        
        var auth:Int? = (Int)(AUTH);
        auth = auth! + 1;
        AUTH = "\(auth!)";
        
        print("TTTTTTT\n")
        print(AUTH)

        
        firebase!.child("users").child(myPhoneNo).updateChildValues(["broadcast": content, "AUTH": AUTH]);
    }
    
    
}
