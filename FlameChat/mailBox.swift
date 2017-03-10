//
//  ViewController.swift
//  FlameChat
//
//  Created by matthew on 2017-01-30.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

var myAUTH = "";

var content = "";

class mailBox: UIViewController{
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mailNumField: UILabel!
    
    
    @IBOutlet weak var mailNo: UILabel!
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var contents: UILabel!
    
    var maxNum:Int? = 0;
    var currentNo:Int? = 0;
    
    //var postData = ["Message"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        
        
        firebase?.child("users").child(myPhoneNo).child("mailBox").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            var mailNum = value?["mailNum"] as? String ?? ""
            var newestMail = value?[mailNum] as? String ?? ""
            var myauth = value?["AUTH"] as? String ?? ""
            myAUTH = myauth;
            
            if myAUTH == authno {
                var num:Int? = (Int)(mailNum);
                
                self.mailNumField.text! = "You have " + mailNum + " mails."
                
                self.currentNo! = num! + 1;
                self.maxNum! = num!;
                
                print("\n\nTTTTTTTTT")
                print(mailNum);
            }
            else{
                var num:Int? = (Int)(mailNum);
                num = num! + 1;
                mailNum = "\(num!)";
                
                firebase!.child("users").child(myPhoneNo).child("mailBox").updateChildValues(["mailNum": mailNum]);
                firebase!.child("users").child(myPhoneNo).child("mailBox").updateChildValues(["AUTH": authno]);
                firebase!.child("users").child(myPhoneNo).child("mailBox").child(mailNum).setValue(["time": "NEWEST", "content": broadcast, "sender": "Authorizer"])
                
                
                self.mailNumField.text! = "You have " + mailNum + " mails."
                
                self.currentNo! = num! + 1;
                self.maxNum! = num!;
                
                print("\n\nTTTTTTTTT")
                print(mailNum);
            }
            
        })
        
        self.initializeMail();

        print("\n\nTTTTTTTTT")
        print(self.currentNo);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getMail(_ sender: Any) {
        
        self.currentNo = self.currentNo! - 1;
        if self.currentNo! <= maxNum! {
            
            if self.currentNo! == 0 {
                self.currentNo = 1;
            }
            
            var get:String = "\(self.currentNo!)";
       
            firebase?.child("users").child(myPhoneNo).child("mailBox").child(get).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                var cont = value?["content"] as? String ?? ""
                var tm = value?["time"] as? String ?? ""
                var sd = value?["sender"] as? String ?? ""
                
                self.contents.text! = "Contents: "+cont
                self.time.text! = "Time: "+tm
                self.sender.text! = "Sender: "+sd
                self.mailNo.text! = "No: "+get;
                
                content = cont;

                
            })
            
        }
    }// end of get mail
    
    @IBAction func previous(_ sender: Any) {
        
        
        self.currentNo = self.currentNo! + 1;
        
        if self.currentNo! > maxNum! {
            self.currentNo = maxNum!;
        }
        
        if self.currentNo! <= maxNum! {
            
            var get:String = "\(self.currentNo!)";
            
            firebase?.child("users").child(myPhoneNo).child("mailBox").child(get).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                var cont = value?["content"] as? String ?? ""
                var tm = value?["time"] as? String ?? ""
                var sd = value?["sender"] as? String ?? ""
                
                self.contents.text! = "Contents: "+cont
                self.time.text! = "Time: "+tm
                self.sender.text! = "Sender: "+sd
                self.mailNo.text! = "No: "+get;
                
                content = cont;
            })
            
        }

    }// end of previous email
    
    
    @IBAction func deleteNew(_ sender: Any) {
        
        if self.maxNum! > 0 {
            self.maxNum = self.maxNum! - 1;
            
            var deleteNum:String = "\(self.maxNum!)";
            
            firebase!.child("users").child(myPhoneNo).child("mailBox").updateChildValues(["mailNum": deleteNum]);
            
        }
            
        
        
        self.currentNo = self.maxNum!;
        
        if self.currentNo! > maxNum! {
            self.currentNo = maxNum!;
        }
        
        if self.currentNo! <= maxNum! {
            
            var get:String = "\(self.currentNo!)";
            
            firebase?.child("users").child(myPhoneNo).child("mailBox").child(get).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                var cont = value?["content"] as? String ?? ""
                var tm = value?["time"] as? String ?? ""
                var sd = value?["sender"] as? String ?? ""
                
                self.contents.text! = "Contents: "+cont
                self.time.text! = "Time: "+tm
                self.sender.text! = "Sender: "+sd
                self.mailNo.text! = "No: "+get;
                
                self.mailNumField.text! = "You have " + get + " mails";
            })
            
        }
    }// end of delete
    
    
    func initializeMail(){
        self.currentNo = self.currentNo! + 1;
        
        if self.currentNo! > maxNum! {
            self.currentNo = maxNum!;
        }
        
        if self.currentNo! <= maxNum! {
            
            var get:String = "\(self.currentNo!)";
            
            firebase?.child("users").child(myPhoneNo).child("mailBox").child(get).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                var cont = value?["content"] as? String ?? ""
                var tm = value?["time"] as? String ?? ""
                var sd = value?["sender"] as? String ?? ""
                
                self.contents.text! = "Contents: "+cont
                self.time.text! = "Time: "+tm
                self.sender.text! = "Sender: "+sd
                self.mailNo.text! = "No: "+get;
                
            })
            
        }
        
    }// end of initializeMail

    
}

