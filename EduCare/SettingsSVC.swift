//
//  SettingsSVC.swift
//  EduCare
//
//  Created by Sejal Kanikaram on 8/3/20.
//  Copyright © 2020 Sejal Kanikaram. All rights reserved.
//

import UIKit
import Firebase

class SettingsSVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var skills: UITextField!
    
    var ref: DatabaseReference!
    
    @IBAction func saveChanges(_ sender: UIButton) {
        ref = Database.database().reference()
        
        if(password.text! == confirmPassword.text!){
            let user = Auth.auth().currentUser;
            
            if(email.text! != ""){
                user!.updateEmail(to: email.text!) { (error) in
                    print(error!)
                }
                
                if (email.text! != ""){
                    self.ref.child("users").setValue(email.text!, forKey: "email")
                }
                
            }
            
            if (password.text! != "") {
                user!.updatePassword(to: password.text!) { (error) in
                    print(error!)
                }
            }
                
            if (location.text! != ""){
                self.ref.child("users").setValue(location.text!, forKey: "location")
            }
            
            if (skills.text! != ""){
                self.ref.child("users").setValue(skills.text!, forKey: "skills")
            }
            
        
        } else {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
