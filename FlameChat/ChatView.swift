//
//  ChatView.swift
//  FlameChat
//
//  Created by matthew on 2017-02-10.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import Firebase

class ChatView: UIViewController {
    
    @IBOutlet weak var otherEmailField: UILabel!
    @IBOutlet weak var otherTextFeild: UILabel!
    @IBOutlet weak var composetField: UITextField!
    
    //点击空白区域隐藏键盘
    // touch blank area to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.composetField.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sentMsg(_ sender: Any) {
        
        
        
    }
    
    
    
}
