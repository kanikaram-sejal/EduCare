//
//  SignUpVC.swift
//  EduCare
//
//  Created by Sejal Kanikaram on 8/1/20.
//  Copyright © 2020 Sejal Kanikaram. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var userType: UISegmentedControl!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var skills: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var hiring: UISwitch!
    @IBOutlet weak var topic: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        ref = Database.database().reference()
        let type = ["Student", "Educator"]
        
        if(password.text! == confirmPassword.text!){
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    if(self.userType.selectedSegmentIndex == 0){
                        self.ref.child("users").child("name " + self.name.text!).setValue(["type": type[self.userType.selectedSegmentIndex], "email": self.email.text!, "skills": self.skills.text!, "location": self.location.text!])
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentVC")
                        self.present(vc!, animated: true, completion: nil)
                    } else {
                        self.ref.child("users").child("name " + self.name.text!).setValue(["type": type[self.userType.selectedSegmentIndex], "email": self.email.text!, "skills": self.skills.text!, "location": self.location.text!, "hiring": String(self.hiring.isOn), "subject": self.topic.text!])
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EducatorVC")
                        self.present(vc!, animated: true, completion: nil)
                    }
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                     
                     alertController.addAction(defaultAction)
                     self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
