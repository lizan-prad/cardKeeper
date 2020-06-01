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
import NVActivityIndicatorView


class LoginViewController: UIViewController, LoginButtonDelegate {
    
    

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBtn.rounded()
        loginBtn.rounded()
        registerBtn.layer.borderColor = UIColor.init(hex: "E6C231", alpha: 1).cgColor
        registerBtn.layer.borderWidth = 2

        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
    }
    
    @IBAction func loginFb(_ sender: Any) {
        
        let manager = LoginManager.init()
        
        manager.logIn(permissions: ["public_profile", "email"], from: self) { (results, error) in
            if results?.token != nil {
                let cred = FacebookAuthProvider.credential(withAccessToken: results?.token?.tokenString ?? "")
                self.startAnimating(type: .orbit)
                Auth.auth().signIn(with: cred) { (authResult, error) in
                    ref.child("Profile").child(Auth.auth().currentUser?.uid ?? "").observeSingleEvent(of: .value) { (snapshot) in
                        self.stopAnimating()
                        if (snapshot.value as? String) == nil {
                            let vc = UIStoryboard.init(name: "AddPin", bundle: nil).instantiateViewController(withIdentifier: "AddPinViewController") as! AddPinViewController
                            vc.didSuceed = { (p1,p2) in
                                let utf8str = p1.data(using: .utf8)
                                
                                let base64Encoded = utf8str?.base64EncodedString()
                                
                                ref.child("Profile").child(Auth.auth().currentUser?.uid ?? "").setValue(self.encrypt(data: base64Encoded ?? "") ?? "")
                                self.openDash()
                            }
                            self.present( vc, animated: true, completion: nil)
                        } else {
                            self.openDash()
                        }
                    }
                }
            }
        }
    }
    
    func openDash() {
        let vc = UIStoryboard.init(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        let nav = UINavigationController.init(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barTintColor = UIColor.init(hex: "131318")
        self.present( nav, animated: true, completion: nil)
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

import Foundation
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    
    func startAnimating(type: NVActivityIndicatorType) {
        startAnimating(CGSize.init(width: 80, height: 80), message: nil, messageFont: nil, type: type, color: UIColor.init(hex: "E6C231", alpha: 1), padding: 5, displayTimeThreshold: 10, minimumDisplayTime: 1, backgroundColor: UIColor.init(hex: "131318"), textColor: nil, fadeInAnimation: nil)
    }
    
    func stopAnimating() {
        self.stopAnimating(nil)
    }
}

