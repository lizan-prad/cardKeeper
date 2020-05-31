//
//  ViewCardViewController.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/31/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit

class ViewCardViewController: UIViewController {

    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var frontView: UIView!
    
    let cardBackView = TinyCreditCardBackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontView.layer.cornerRadius = 8

        self.cardContainerView.addSubview(cardBackView)
        cardBackView.translatesAutoresizingMaskIntoConstraints = false
        cardBackView.leadingAnchor.constraint(equalTo: frontView.leadingAnchor).isActive = true
        cardBackView.trailingAnchor.constraint(equalTo: frontView.trailingAnchor).isActive = true
        cardBackView.topAnchor.constraint(equalTo: frontView.topAnchor).isActive = true
        cardBackView.bottomAnchor.constraint(equalTo: frontView.bottomAnchor).isActive = true
        cardBackView.isHidden = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(flip)))
        // Do any additional setup after loading the view.
    }

    @objc func flip() {
        self.frontView.layer.transform = CATransform3DIdentity
        self.cardBackView.layer.transform = CATransform3DIdentity
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        UIView.transition(with: self.cardContainerView, duration: 0.5, options: transitionOptions, animations: {
            self.frontView.isHidden = !self.frontView.isHidden
            self.cardBackView.isHidden = !self.cardBackView.isHidden
        })
    }

}
