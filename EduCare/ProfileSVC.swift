//
//  ProfileSVC.swift
//  EduCare
//
//  Created by Sejal Kanikaram on 8/3/20.
//  Copyright © 2020 Sejal Kanikaram. All rights reserved.
//

import UIKit
import Firebase

class ProfileSVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var skills: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var ref: DatabaseReference!
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("users").child("name " + username).observe(.value, with: {(data) in
            let user = data.value as! NSDictionary
            let userName = user["name"]
            let userSkills = user["skills"]
            let userLocation = user["location"]
            let userEmail = user["email"]
            
            self.name!.text = (userName as! String)
            self.skills!.text = (userSkills as! String)
            self.location!.text = (userLocation as! String)
            self.email!.text = (userEmail as! String)
        })
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print (signOutError)
        }
    }
}
