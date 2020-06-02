//
//  OnboardingViewController.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/31/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import SwiftyOnboard
import Lottie

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboarding: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swiftyOnboard = SwiftyOnboard(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 80))
        onboarding.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
        swiftyOnboard.shouldSwipe = false
        swiftyOnboard.fadePages = true
        swiftyOnboard.style = .dark
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        swiftyOnboard.tintColor = UIColor.init(hex: "#A12715")
        
    }
}


extension OnboardingViewController: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
  

    func tapContinue(_ swiftyOnboard: SwiftyOnboard, index: Int) {
        
    }
    
    func tapSkip() {
        let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 2
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
    
        page.title.font = UIFont.init(name: "Volte-Regular", size: 12)
        page.subTitle.font = UIFont.init(name: "Volte-Regular", size: 11)
        
        page.title.text = index == 0 ? "Keeper defines simplicity" : "Using our latest encryption method"
        page.subTitle.text = index == 0 ? "Store your Credit/Debit/Master Cards safely with Keeper." : "We ensure you that the details of your cards are encrypted and hack proof."
        let animationView = AnimationView.init(name: index == 0 ? "card2" : "secure")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundColor = UIColor.init(hex: "131318")
        animationView.animationSpeed = 1
        animationView.play()
        page.imageView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.leadingAnchor.constraint(equalTo: page.imageView.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: page.imageView.trailingAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: page.imageView.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: page.imageView.bottomAnchor).isActive = true
        return page
    }
}
