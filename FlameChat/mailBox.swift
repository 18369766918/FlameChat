//
//  ViewController.swift
//  FlameChat
//
//  Created by matthew on 2017-01-30.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

class mailBox: UIViewController{
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mailNumField: UILabel!
    
    @IBOutlet weak var retrieveNo: UITextField!
    
    @IBOutlet weak var mailNo: UILabel!
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var contents: UILabel!
    
    
    //var postData = ["Message"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //tableView.delegate = self
        //tableView.dataSource = self
        
        firebase?.child("users").child(myPhoneNo).child("mailBox").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            var mailNum = value?["mailNum"] as? String ?? ""
            
            var num:Int? = (Int)(mailNum);
            
            self.mailNumField.text! = "You have " + mailNum + " mails."
            /*
            if(num == 0){
                self.contents.text! = ""
                self.time.text! = ""
                self.sender.text! = ""
                self.mailNo.text! = ""
            }
            else{
                
                let box = snapshot.children as? NSEnumerator// test

                //print(box?.allObjects)
                let boxValue = box?.allObjects as? NSDictionary
                
                
                print("")
                print(boxValue)
                
                var cont = boxValue?["content"] as? String ?? ""
                var tm = boxValue?["time"] as? String ?? ""
                var sd = boxValue?["sender"] as? String ?? ""
 
                
                
                self.contents.text! = cont
                self.time.text! = tm
                self.sender.text! = sd
                self.mailNo.text! = "Newest message: " + mailNum;
 
            }
            
            */
        })

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getMail(_ sender: Any) {
        var retrieve = self.retrieveNo.text!;
        
        firebase?.child("users").child(myPhoneNo).child("mailBox").child(retrieve).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            var cont = value?["content"] as? String ?? ""
            var tm = value?["time"] as? String ?? ""
            var sd = value?["sender"] as? String ?? ""
            
            self.contents.text! = cont
            self.time.text! = tm
            self.sender.text! = sd
            self.mailNo.text! = retrieve;
            
        })
    }
    
    
}

