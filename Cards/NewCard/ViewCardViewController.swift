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
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var skin: UIImageView!
    
    let cardBackView = TinyCreditCardBackView()
    
    var model: CardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardBackView.focus = false
        setup()
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
    
    func setup() {
        self.number.text = model?.number
        self.name.text = model?.name
        self.date.text = model?.expiry
        self.logo.image = model?.cardType?.getCardLogo()
        self.cardBackView.cardBrandImage = model?.cardType?.getCardLogo()
        self.cardBackView.cscNumberLabel.text = model?.cvc
        self.cardBackView.cardHolderLabel.text = model?.name?.lowercased().capitalized
        self.skin.image = UIImage.init(named: model?.skin ?? "")
        self.cardBackView.skin.image = UIImage.init(named: model?.skin ?? "")
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
