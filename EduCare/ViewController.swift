//
//  ViewController.swift
//  EduCare
//
//  Created by Sejal Kanikaram on 7/31/20.
//  Copyright © 2020 Sejal Kanikaram. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UILabel!
    
    var ref: DatabaseReference!
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: UIButton) {
        ref = Database.database().reference()

        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.ref.child("users").child("name " + self.name.text!).observe(.value, with: {(data) in
                    let user = data.value as! NSDictionary
                    let userType = user["type"] as! String
                    
                    if(userType == "Student"){
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentVC")
                        self.present(vc!, animated: true, completion: nil)
                    } else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EducatorVC")
                        self.present(vc!, animated: true, completion: nil)
                    }
                })
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                               
                 alertController.addAction(defaultAction)
                 self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ref = Database.database().reference()
        self.ref.child("users").child("name " + self.name.text!).observe(.value, with: {(data) in
        let user = data.value as! NSDictionary
        let userType = user["type"] as! String
        
            if(userType == "Student"){
                var vc = segue.destination as! ProfileSVC
                vc.username = self.userName
            } else {
                var vc = segue.destination as! ProfileEVC
                vc.username = self.userName
            }
        })
    }

    
}

