
import UIKit
import Firebase

class BeCallingView: UIViewController {
    
    @IBOutlet weak var callerID: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** display caller ID */
        firebase?.child("users").child(myPhoneNo).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let caller = value?["caller"] as? String ?? ""
            
            yourPhoneNo = caller;
            
            self.callerID.text! = "Caller ID: " + yourPhoneNo;
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func cancel(_ sender: Any) {
        firebase?.child("users").child(myPhoneNo).updateChildValues(["status": "online"])
        firebase?.child("users").child(yourPhoneNo).updateChildValues(["status": "canceled"])
        
        /** present dial view */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dial") as! DialViewController
        
        self.present(popOverVC, animated: true, completion: nil)
        
    }
    
    @IBAction func answer(_ sender: Any) {
        firebase?.child("users").child(myPhoneNo).updateChildValues(["status": "chatting"])
        firebase?.child("users").child(yourPhoneNo).updateChildValues(["status": "chatting"])
        
        /** present chat view */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chat") as! ChatView
        
        self.present(popOverVC, animated: true, completion: nil)
        

    }
    
}
