//
//  Forward.swift
//  FlameChat
//
//  Created by matthew on 2017-03-10.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

class Forward: UIViewController {

    
    @IBOutlet weak var contentField: UITextField!
    
    @IBOutlet weak var no1: UITextField!
    @IBOutlet weak var no2: UITextField!
    @IBOutlet weak var no3: UITextField!
    @IBOutlet weak var no4: UITextField!
    @IBOutlet weak var no5: UITextField!
    @IBOutlet weak var no6: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentField.text! = content;
        
        
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(_ sender: Any) {
        
        var n1 = self.no1.text!;
        var n2 = self.no2.text!;
        var n3 = self.no3.text!;
        var n4 = self.no4.text!;
        var n5 = self.no5.text!;
        var n6 = self.no6.text!;

        sendEach(phone: n1);
        sendEach(phone: n2);
        sendEach(phone: n3);
        sendEach(phone: n4);
        sendEach(phone: n5);
        sendEach(phone: n6);
    }
    
    func sendEach(phone: String){
        if(phone != ""){
            var tmp = self.contentField.text!;
            
            firebase?.child("users").child(phone).child("mailBox").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                var mailNum = value?["mailNum"] as? String ?? ""
                
                var num:Int? = (Int)(mailNum);
                var newNum = num! + 1;
                mailNum = String(describing: newNum);
                
                self.getTime();
                /** send mail to receiver */
                if(tmp != ""){
                    firebase!.child("users").child(phone).child("mailBox").updateChildValues(["mailNum": mailNum]);
                    firebase!.child("users").child(phone).child("mailBox").child(mailNum).setValue(["time": dateTime, "content": content, "sender": myPhoneNo])
                }
            })

        }
    }

    func getTime(){
        var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd/yyyy,hh:mm:ss"
        dateTime = formatter.string(from: date)
    }
}
