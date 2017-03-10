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
var theme = "";




class Login: UIViewController {

    
    @IBOutlet weak var emailField: UITextField! // phone number
    @IBOutlet weak var passwordField: UITextField!

    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
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
        
        /** present dial view */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createAccount") as! CreateAccount
        
        self.present(popOverVC, animated: true, completion: nil)
        

    }
    
  
    
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
    
    func authLogin(){
        /** show the dial navigation controller */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "auth") as! Auth
        
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
                theme = value?["theme"] as? String ?? "" // get theme name

                if(inputPasswd == passwd){
                    myPhoneNo = inputPhone;
                    firebase?.child("users").child(myPhoneNo).updateChildValues(["status": "online"])
                    
                    if inputPhone == "Authorizer"{
                        /** show login successful alert box */
                        let successAlert = UIAlertController(title: "Welcome back authorizer!", message: "", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                        successAlert.addAction(defaultAction)
                        self.present(successAlert, animated: true, completion: nil)
                        
                        /** show the dial viewcontroller */
                        self.authLogin()
                    }
                    
                    else{
                    /** show login successful alert box */
                    let successAlert = UIAlertController(title: "Welcome back friend!", message: "", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                    successAlert.addAction(defaultAction)
                    self.present(successAlert, animated: true, completion: nil)
                    
                    /** show the dial viewcontroller */
                    self.loggedTest()
                    }
                }
                else{
                    /** show login fail alert box */
                    let failAlert = UIAlertController(title: "Wrong password or ID!", message: "", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                    failAlert.addAction(defaultAction)
                    self.present(failAlert, animated: true, completion: nil)
                }
                
            })
        }
        else{
            /** show login fail alert box */
            let failAlert = UIAlertController(title: "Can't be empty", message: "", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
            failAlert.addAction(defaultAction)
            self.present(failAlert, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
}
