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
import CryptoSwift

class NewCardViewController: UIViewController, CardInfoDelegate {
  
    

    
    @IBOutlet weak var cardView: TinyCreditCardView!
    
    // Stripe textField
//    let paymentTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.delegate = self
      
    }
    func didReceiveCardInfo(number: String, expiryDate: String, scv: String, cardType: String, name: String, skin: String) {
        let data = ["CardNo": number, "expData": expiryDate, "CSC": scv, "cardType": cardType, "Name": name, "skin": skin]
        do {
            let headerJWTData: Data = try JSONSerialization.data(withJSONObject:data,options: JSONSerialization.WritingOptions.prettyPrinted)
            let headerJWTBase64 = headerJWTData.base64EncodedString()
            ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").updateChildValues(["\(Date().timeIntervalSince1970)".replacingOccurrences(of: ".", with: "") : encrypt(data: headerJWTBase64) ?? ""])
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("could not make data")
        }
    }
 
}

extension String {
    func to16Bit() -> String? {
        if self.count < 16 {
            let remain = 16 - self.count
            var str = ""
            for i:Int in 1 ... remain {
                str.append("0")
            }
            return self + str
        } else if self.count > 16 {
            return self.enumerated().compactMap { (i,s) in
                if (i + 1) <= 16 {
                    return "\(s)"
                } else {
                    return nil
                }
            }.joined()
        }
        return self
    }
}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return UInt8(self[start..<end], radix: 16)
        }
    }
}

extension UIViewController {
    
    func encrypt(data: String) -> String? {
        do {
            let aes = try AES(key: Auth.auth().currentUser?.uid.to16Bit() ?? "", iv: Auth.auth().currentUser?.displayName?.replacingOccurrences(of: " ", with: "").to16Bit() ?? "") // aes128
            let ciphertext = try aes.encrypt(Array(data.utf8))
            return ciphertext.toHexString()
        } catch {
            print(error)
            return nil
        }
//        if let pub = UserDefaults.standard.value(forKey: "PB") as? String {
//            do {
//                let pub = try PublicKey.init(base64Encoded: pub)
//                let clear = try ClearMessage(string: data, using: .utf8)
//                let encrypted = try clear.encrypted(with: pub, padding: .PKCS1)
//
//                let data = encrypted.data
//                let base64String = data.base64EncodedString()
//                return base64String
//            }catch {
//                return nil
//            }
//        } else {
//            return nil
//        }
    }
    
    
    
    func decrypt(base64: String) -> String? {
        do {
            let aes = try AES(key: Auth.auth().currentUser?.uid.to16Bit() ?? "", iv: Auth.auth().currentUser?.displayName?.replacingOccurrences(of: " ", with: "").to16Bit() ?? "") // aes128
            let ciphertext = try aes.decrypt(base64.hexaBytes)
            let data = Data.init(hex: ciphertext.toHexString())
            let str = String.init(data: data, encoding: .utf8)
            return str
        } catch {
            print(error)
            return nil
        }
//        if let privateKey = UserDefaults.standard.value(forKey: "PR") as? String {
//            do {
//                let privateKey = try PrivateKey.init(base64Encoded: privateKey)
//                let encrypted = try EncryptedMessage(base64Encoded: base64)
//                let clear = try encrypted.decrypted(with: privateKey, padding: .PKCS1)
//
//                let data = clear.data
//                let base64String = data.base64EncodedString()
//                let string = try clear.string(encoding: .utf8)
//                return string
//            }catch {
//                print(error)
//                return nil
//            }
//        } else {
//            return nil
//        }
    }
}
