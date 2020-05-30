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
import FirebaseDatabase
import FirebaseAuth
import SwiftyRSA
class NewCardViewController: UIViewController, CardInfoDelegate {
  
    

    
    @IBOutlet weak var cardView: TinyCreditCardView!
    
    // Stripe textField
//    let paymentTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.delegate = self
      
    }
    func didReceiveCardInfo(number: String, expiryDate: String, scv: String, cardType: String) {
        let data = ["CardNo": number, "expData": expiryDate, "CSC": scv, "cardType": cardType]
        do {
            let headerJWTData: Data = try JSONSerialization.data(withJSONObject:data,options: JSONSerialization.WritingOptions.prettyPrinted)
            let headerJWTBase64 = headerJWTData.base64EncodedString()
            ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").setValue(encrypt(data: headerJWTBase64) ?? "")
        } catch {
            print("could not make data")
        }
    }
 
}

extension UIViewController {
    
    func encrypt(data: String) -> String? {
        if let pub = UserDefaults.standard.value(forKey: "PB") as? String {
            do {
                let pub = try PublicKey.init(base64Encoded: pub)
                let clear = try ClearMessage(string: data, using: .utf8)
                let encrypted = try clear.encrypted(with: pub, padding: .PKCS1)
                
                let data = encrypted.data
                let base64String = data.base64EncodedString()
                return base64String
            }catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func decrypt(base64: String) -> String? {
        if let privateKey = UserDefaults.standard.value(forKey: "PR") as? String {
            do {
                let privateKey = try PrivateKey.init(base64Encoded: privateKey)
                let encrypted = try EncryptedMessage(base64Encoded: base64)
                let clear = try encrypted.decrypted(with: privateKey, padding: .PKCS1)
                
                let data = clear.data
                let base64String = data.base64EncodedString()
                let string = try clear.string(encoding: .utf8)
                return string
            }catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
}
