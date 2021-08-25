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
            ShowAlertError(withMessage: "Please enter email!")
            return
        }
        guard let password = self.txt_password.text else
        {
            ShowAlertError(withMessage: "Please enter password!")
            return
        }
        if !emailid.isValidEmail
        {
            ShowAlertError(withMessage: "Please enter valid email!")
            return
        }
        if !password.isValidPassword
        {
            ShowAlertError(withMessage: "Passwords must be at least 8 characters")
            return
        }
        let credential = Credentials(emailid: emailid, password: password)
        
        KeychainManager.sharedInstance.keychain_setObject(credential.emailid as AnyObject, forKey: KEYSPROJECT.email)
        KeychainManager.sharedInstance.keychain_setObject(credential.password as AnyObject, forKey: KEYSPROJECT.password)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
}
