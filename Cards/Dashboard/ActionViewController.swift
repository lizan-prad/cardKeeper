//
//  ActionViewController.swift
//  Cards
//
//  Created by Lizan Pradhanang on 6/2/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth

class ActionViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var conatiner: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conatiner.layer.cornerRadius = 24
        animationView.loopMode = .playOnce
        animationView.backgroundColor = UIColor.init(hex: "131318")
        animationView.animationSpeed = 1
        animationView.play()
        conatiner.layer.borderColor = UIColor.init(hex: "E6C231", alpha: 0.6).cgColor
        conatiner.layer.borderWidth = 1
      
        // Do any additional setup after loading the view.
    }

    @IBAction func logOutAction(_ sender: Any) {
        do {
            self.startAnimating(type: .orbit)
            try Auth.auth().signOut()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                self.stopAnimating()
                let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.view.window?.rootViewController =  vc
            }
            
        } catch {
            print(error)
        }
    }
    
}
