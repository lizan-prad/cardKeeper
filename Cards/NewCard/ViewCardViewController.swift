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
    @IBOutlet weak var tabView: UIView!
    
    @IBOutlet weak var cont: UIView!
    
    @IBOutlet weak var cardHolderNumber: UILabel!
    @IBOutlet weak var cardHolderName: UILabel!
    @IBOutlet weak var descExpiry: UILabel!
    @IBOutlet weak var descCvc: UILabel!
    @IBOutlet weak var card: UIImageView!
    
    
    
    
    let cardBackView = TinyCreditCardBackView()
    
    var model: CardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardBackView.focus = false
        setup()
        frontView.layer.cornerRadius = 8
        cont.layer.borderColor = UIColor.init(hex: "E6C231", alpha: 0.6).cgColor
        cont.layer.borderWidth = 1
        cont.layer.cornerRadius = 22
        tabView.rounded()
        
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
        self.cardHolderNumber.text = model?.number
        self.cardHolderNumber.isUserInteractionEnabled = true
        self.cardHolderNumber.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(copyNumber)))
        
        self.cardHolderName.text = model?.name
        self.cardHolderName.isUserInteractionEnabled = true
        self.cardHolderName.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(copyName)))
        
        self.descExpiry.text = model?.expiry
        self.descExpiry.isUserInteractionEnabled = true
        self.descExpiry.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(copyExpiry)))
        
        self.descCvc.text = model?.cvc
        self.descCvc.isUserInteractionEnabled = true
        self.descCvc.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(copyCVC)))
        
        self.card.image = model?.cardType?.getCardLogo()
        
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

    @objc func copyNumber() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = model?.number ?? ""
        timer()
    }
    
    func timer() {
        self.startAnimating(CGSize.init(width: 40, height: 40), message: "Copied", messageFont: UIFont.init(name: "Volte-Regular", size: 12), type: .blank, color: UIColor.init(hex: "E6C231"), padding: nil, displayTimeThreshold: 1, minimumDisplayTime: 1, backgroundColor: nil, textColor: UIColor.init(hex: "E6C231"), fadeInAnimation: nil)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
            self.stopAnimating()
        }
    }
    
    @objc func copyName() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = model?.name ?? ""
        timer()
    }
    
    @objc func copyExpiry() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = model?.expiry ?? ""
        timer()
    }
    
    @objc func copyCVC() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = model?.cvc ?? ""
        timer()
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
