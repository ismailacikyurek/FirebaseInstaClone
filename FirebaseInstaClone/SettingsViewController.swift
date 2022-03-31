//
//  SettingsViewController.swift
//  FirebaseInstaClone
//
//  Created by İSMAİL AÇIKYÜREK on 29.03.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func logOutbtn(_ sender: Any) { //çıkış ypapma
        
         do {
            try Auth.auth().signOut() //firebaseden çıkma
             self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch {
            print("error")
        }
    }
    
    
    
    
    
}
