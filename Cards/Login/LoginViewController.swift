//
//  LoginViewController.swift
//  CardBox
//
//  Created by Lizan Pradhanang on 5/27/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth



class LoginViewController: UIViewController, LoginButtonDelegate {
    
    

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBtn.rounded()
        loginBtn.rounded()
        registerBtn.layer.borderColor = UIColor.init(hex: "B89B27").cgColor
        registerBtn.layer.borderWidth = 2

        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
    }
    
    @IBAction func loginFb(_ sender: Any) {

        let manager = LoginManager.init()
        manager.logIn(permissions: ["public_profile", "email"], from: self) { (results, error) in
            if results?.token != nil {
                let cred = FacebookAuthProvider.credential(withAccessToken: results?.token?.tokenString ?? "")
                Auth.auth().signIn(with: cred) { (authResult, error) in
                    
                    let vc = UIStoryboard.init(name: "AddPin", bundle: nil).instantiateViewController(withIdentifier: "AddPinViewController") as! AddPinViewController
                    
//                    let vc = UIStoryboard.init(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//                    let nav = UINavigationController.init(rootViewController: vc)
//                    nav.modalPresentationStyle = .fullScreen
//                    nav.navigationBar.isTranslucent = false
//                    nav.navigationBar.barTintColor = UIColor.init(hex: "131318")
                    self.present( vc, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}

extension UIView {
    
    func rounded() {
        self.layer.cornerRadius = self.frame.height/2
    }
}
