//
//  AddPinViewController.swift
//  Cards
//
//  Created by Lizan Pradhanang on 6/1/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import KAPinField
import Lottie

class AddPinViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var pinField: KAPinField!
    @IBOutlet weak var pinDescLabel: UILabel!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    var didSuceed: ((String,String) -> ())?
    
    var pin1 = ""
    var pin2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBtn.rounded()
        resetBtn.layer.borderColor = UIColor.init(hex: "E6C231").cgColor
        resetBtn.layer.borderWidth = 1
        resetBtn.isHidden = true
        
        pinField.properties.delegate = self
        pinField.keyboardType = .numberPad
        pinField.becomeFirstResponder()
        pinSetup()
        
        animationView.loopMode = .loop
        animationView.backgroundColor = UIColor.init(hex: "131318")
        animationView.animationSpeed = 1
        animationView.play()
    }
    @IBAction func resetAction(_ sender: Any) {
        if resetBtn.titleLabel?.text == "CONFIRM" {
            self.dismiss(animated: true) {
                self.didSuceed?(self.pin1,self.pin2)
            }
            return
        }
        self.pin1 = ""
        self.pin2 = ""
        self.resetBtn.isHidden = pin1 == ""
        self.pinDescLabel.text = "Enter Your New PIN"
    }
    
    func pinSetup() {
        // pinField.properties.token = "-" // Default to "•"
        // pinField.properties.numberOfCharacters = 4 // Default to 4
        //pinField.properties.validCharacters = "0123456789+#?" // Default to only numbers, "0123456789"
        
        pinField.properties.animateFocus = true // Animate the currently focused token
        pinField.properties.isSecure = false // Secure pinField will hide actual input
        pinField.properties.secureToken = "•" // Token used to hide actual character input when using isSecure = true
        
        
        pinField.appearance.font = .menloBold(40) // Default to appearance.MonospacedFont.menlo(40)
        pinField.appearance.kerning = 20 // Space between characters, default to 16
        pinField.appearance.textColor = UIColor.gray // Default to nib color or black if initialized programmatically.
        pinField.appearance.tokenColor = UIColor.gray // token color, default to text color
        pinField.appearance.tokenFocusColor = UIColor.init(hex: "E6C231")  // token focus color, default to token color
        //        pinField.appearance.backOffset = 8 // Backviews spacing between each other
        //        pinField.appearance.backColor = UIColor.clear
        //        pinField.appearance.backBorderWidth = 1
        //        pinField.appearance.backBorderColor = UIColor.white.withAlphaComponent(0.2)
        //        pinField.appearance.backCornerRadius = 4
        //        pinField.appearance.backFocusColor = UIColor.clear
        //        pinField.appearance.backBorderFocusColor = UIColor.white.withAlphaComponent(0.8)
        //        pinField.appearance.backActiveColor = UIColor.clear
        //        pinField.appearance.backBorderActiveColor = UIColor.white
    }
    
    
}

extension AddPinViewController : KAPinFieldDelegate {
    func pinField(_ field: KAPinField, didFinishWith code: String) {
        self.resetBtn.isHidden = pin1 == ""
        
        if pin1 == "" {
            self.pin1 = code
            self.pinDescLabel.text = "Confirm Your PIN"
            field.text = nil
            return
        }
        pin2 = code
        if pin1 != pin2 {
            self.pinField.animateFailure()
            self.pinField.text = nil
            self.pinDescLabel.text = nil
            self.resetBtn.setTitle("RESET", for: .normal)
            self.pin2 = ""
            return
        }
        self.pinDescLabel.text = nil
        self.resetBtn.setTitle("CONFIRM", for: .normal)
        
    }
}
