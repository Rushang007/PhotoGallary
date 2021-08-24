//
//  LoginVC.swift
//  PhotoGallary
//
//  Created by Rushang Patel (iOS Developer) on 24/08/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txt_emailid: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    

    
    @IBAction func PressOnLogin(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let emailid = self.txt_emailid.text else
        {
            return
        }
        guard let password = self.txt_password.text else
        {
            return
        }
        let credential = Credentials(emailid: emailid, password: password)
      
       try? KeychainInterface.save(password: KeychainInterface.stringToNSDATA(string: credential.password) as Data, service: KEYSPROJECT.savedata, account: credential.emailid)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
}
