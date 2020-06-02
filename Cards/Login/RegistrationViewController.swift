//
//  RegistrationViewController.swift
//  Cards
//
//  Created by Lizan Pradhanang on 6/2/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    var type: String?
    var didSuceed: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.borderColor = UIColor.init(hex: "E6C231", alpha: 0.6).cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 22
        btn.rounded()
        btn.layer.borderColor = UIColor.init(hex: "E6C231", alpha: 1).cgColor
        btn.layer.borderWidth = 1
        
        if type == "L" {
            self.btn.setTitle("LOGIN", for: .normal)
        } else {
            self.btn.setTitle("REGISTER", for: .normal)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.email.addTarget(self, action: #selector(textChange(_:)), for: .editingChanged)
        self.password.addTarget(self, action: #selector(textChange(_:)), for: .editingChanged)
        self.btn.isEnabled = false
        self.btn.alpha = 0.4
    }
    
    @objc func textChange(_ sender: UITextField) {
        self.btn.isEnabled = self.isValidEmail(email.text ?? "") && !((password.text?.count ?? 0) < 6)
        self.btn.alpha = self.isValidEmail(email.text ?? "") && !((password.text?.count ?? 0) < 6) ? 1 : 0.4
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.bottom.constant = keyboardHeight + 10.0
        }
        //handle appearing of keyboard here
    }
    
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        
        self.bottom.constant = 25.0
        
        //handle dismiss of keyboard here
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func btnAction(_ sender: Any) {
    
        if type == "L" {
            self.startAnimating(type: .orbit)
            Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { [weak self] authResult, error in
                
              guard let strongSelf = self else { return }
                if error == nil {
                    strongSelf.dismiss(animated: true) {
                        strongSelf.didSuceed?()
                    }
                
                } else {
                    strongSelf.stopAnimating()
                }
            }
        } else {
            self.startAnimating(type: .orbit)
            Auth.auth().createUser(withEmail: email.text ?? "", password: password.text ?? "") { authResult, error in
                if error == nil {
                    self.dismiss(animated: true) {
                        self.didSuceed?()
                    }
                
                }else {
                    self.stopAnimating()
                }
              // ...
            }
        }
    }
    

}
