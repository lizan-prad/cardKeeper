//
//  NewCardViewController.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/29/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Stripe
import CreditCardForm

class NewCardViewController: UIViewController, CardInfoDelegate {
  
    

    
    @IBOutlet weak var cardView: TinyCreditCardView!
    
    // Stripe textField
//    let paymentTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.delegate = self
      
    }
    func didReceiveCardInfo(number: String, expiryDate: String, scv: String, cardType: String) {
         
        
    }
 
}
