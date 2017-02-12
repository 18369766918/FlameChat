//
//  Login.swift
//  FlameChat
//
//  Created by matthew on 2017-01-31.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import Firebase

var myPhoneNo = "";
var yourPhoneNo = "";


class Login: UIViewController {

    
    @IBOutlet weak var emailField: UITextField! // phone number
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneField: UITextField! // name field

    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.phoneField.resignFirstResponder()
    }
    
    
    /** Do any additional setup after loading the view. */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* database reference */
        firebase = FIRDatabase.database().reference()
        
        
        if let user = FIRAuth.auth()?.currentUser{
            
            //firebase!.child("users/\(user.uid)/userID").setValue(user.uid)
            
        }else{
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                if error != nil{
                    
                    let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }else{
                   // firebase!.child("users").child(user!.uid).setValue(["userID" : user!.uid])
                }
            })
         
        }
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** create account botton */
    @IBAction func createAction(_ sender: AnyObject) {
        
        guard let phone = self.emailField.text else {
            return
        }
        guard let password = self.passwordField.text else{
            return
        }
        guard let name = self.phoneField.text else{
            return
        }
        if(phone != "" && password != ""){
            firebase?.child("users").child(phone).setValue(["status":"offline", "passwd": password, "name": name, "mailNum": "0"])
            /** show sign up successful message */
            let alert = UIAlertController(title: "Thank you!", message: "Welcome, our new member!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Start chat now!", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        /*
        if email != "" && password != "" {
            let credential = FIREmailPasswordAuthProvider.credential(withEmail: email, password: password)
            
            FIRAuth.auth()?.currentUser?.link(with: credential, completion: {(user,error) in
                
                if error != nil{
                    
                    let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)

                }else{
                    firebase!.child("users").child(user!.uid).setValue(["passwd":password, "email": email, "phone": phone, "userID": user!.uid])
                    firebase!.child("id").child(phone).setValue(["passwd":password, "email": email, "online": false])
                    /** show sign up successful message */
                    let alert = UIAlertController(title: "Thank you!", message: "Welcome, our new member!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Start chat now!", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)

        }*/
    }
    
    
    /** 
     *   to load a new view controller
     */
    /*
    func logged(){
        /** show the dial viewcontroller */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dial") as! DialViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

    }*/
    
    func loggedTest(){
        /** show the dial navigation controller */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dial") as! DialViewController
        
        let navController = UINavigationController(rootViewController: popOverVC)

        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        //popOverVC.didMove(toParentViewController: self)
        self.present(navController, animated: true, completion: nil)
        
    }
    
    
    /** log in button */
    @IBAction func login(_ sender: AnyObject) {
        var EMAIL = "a@aa.com";
        var PASS = "123456";
        FIRAuth.auth()?.signIn(withEmail: EMAIL, password: PASS) // login as internal account!!!
        
        var inputPhone = self.emailField.text!;
        var inputPasswd = self.passwordField.text!;
        if(inputPhone != "" && inputPasswd != ""){
            firebase?.child("users").child(inputPhone).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let passwd = value?["passwd"] as? String ?? ""
                
                if(inputPasswd == passwd){
                    myPhoneNo = inputPhone;
                    firebase?.child("users").child(myPhoneNo).updateChildValues(["status": "online"])
                    /** show login successful alert box */
                    let successAlert = UIAlertController(title: "Welcome back friend!", message: "", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                    successAlert.addAction(defaultAction)
                    self.present(successAlert, animated: true, completion: nil)
                    
                    /** show the dial viewcontroller */
                    self.loggedTest()
                }
                
            })
        }
        /*
        FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!)
        {
            (user, error) in
            if error == nil{
                /** Log in Successfully do something here!! */
                print("\n\n\nLog in successfully! User: " + self.emailField.text! + "\n\n\n");
                
                var current = FIRAuth.auth()?.currentUser // current user reference
                print("\n\n\n" + (current?.email)! + "\n\n\n");
                print( (current?.uid)! + "\n\n\n");
                
                
                /** change user status (online) to: true */
                let userID = FIRAuth.auth()?.currentUser?.uid
                firebase?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user phone no value
                    let value = snapshot.value as? NSDictionary
                    let phone = value?["phone"] as? String ?? ""
                    
                    firebase!.child("id").child(phone).updateChildValues(["online": "true", "call": "false", "answer": ""]);
                    
                })
                
                
                /** show login successful alert box */
                let successAlert = UIAlertController(title: "Welcome back friend!", message: "", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                successAlert.addAction(defaultAction)
                self.present(successAlert, animated: true, completion: nil)

                /** show the dial viewcontroller */
                self.loggedTest()
            }
            else{
                print("Log in ERROR")
            }
        }*/
    
    }
    
    
    
    
    
}
