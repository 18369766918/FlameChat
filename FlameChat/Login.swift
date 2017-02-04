//
//  Login.swift
//  FlameChat
//
//  Created by matthew on 2017-01-31.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import Firebase

class Login: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneField: UITextField!

    var firebase: FIRDatabaseReference?
    
    /** Do any additional setup after loading the view. */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* database reference */
        self.firebase = FIRDatabase.database().reference()
        
        
        if let user = FIRAuth.auth()?.currentUser{
            
            self.firebase!.child("users/\(user.uid)/userID").setValue(user.uid)
            
        }else{
            
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                if error != nil{
                    
                    let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }else{
                    self.firebase!.child("users").child(user!.uid).setValue(["userID" : user!.uid])
                }
            })
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** create account botton */
    @IBAction func createAction(_ sender: AnyObject) {
        
        guard let email = self.emailField.text else {
            return
        }
        guard let password = self.passwordField.text else{
            return
        }
        guard let phone = self.phoneField.text else{
            return
        }
        
        if email != "" && password != "" {
            let credential = FIREmailPasswordAuthProvider.credential(withEmail: email, password: password)
            
            FIRAuth.auth()?.currentUser?.link(with: credential, completion: {(user,error) in
                
                if error != nil{
                    
                    let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)

                }else{
                    self.firebase!.child("users").child(user!.uid).setValue(["passwd":password, "email": email, "phone": phone])
                    self.firebase!.child("id").setValue(phone)
                    self.firebase!.child("id").child(phone).setValue(["passwd":password, "email": email, "online": false])
                    
                }
            })
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    func logged(){
        /** show the dial viewcontroller */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dial") as! DialViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

    }
    
    
    /** log in button */
    @IBAction func login(_ sender: AnyObject) {
        //var logged = false;
        
        FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!)
        {
            (user, error) in
            if error == nil{
                /** Log in Successfully do something here!! */
                print("\n\n\nLog in successfully! User: " + self.emailField.text! + "\n\n\n");
                
                var current = FIRAuth.auth()?.currentUser // current user reference
                //print("\n\n\n" + (current?.email)! + "\n\n\n");
                //print("\n\n\n" + (current?.uid)! + "\n\n\n");
                
                /** change user status (online) to: true */
                self.firebase!.child("users").child((current?.uid)!).updateChildValues(["online": true])
                
                
                /** show login successful alert box */
                let successAlert = UIAlertController(title: "Welcome back my friend!", message: "", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                successAlert.addAction(defaultAction)
                self.present(successAlert, animated: true, completion: nil)

                /** show the dial viewcontroller */
                self.logged()
            }
            else{
                print("Log in ERROR")
            }
        }
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
