
import UIKit
import Firebase

class BeCallingView: UIViewController {
    
    @IBOutlet weak var callerID: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** display caller ID */
        firebase?.child("id").child(myPhoneNo).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user phone no value
            let value = snapshot.value as? NSDictionary
            let caller = value?["caller"] as? String ?? ""
            
            self.callerID.text! = "Caller ID: " + caller;
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func cancel(_ sender: Any) {
        /** change answer: NO */
        firebase?.child("id").child(myPhoneNo).updateChildValues(["answer": "NO"])

        
        /** present dial view */
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dial") as! DialViewController
        
        self.present(popOverVC, animated: true, completion: nil)
        
    }
    
    @IBAction func answer(_ sender: Any) {
        
    }
    
}
