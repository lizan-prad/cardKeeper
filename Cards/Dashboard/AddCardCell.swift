//
//  AddCardCell.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/30/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Lottie

class AddCardCell: UITableViewCell {

    @IBOutlet weak var addCardBtn: UIButton!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var animationView: AnimationView!
    
    var didTapAdd: (() -> ())?
    
    func setup() {
        animationView.contentMode = .scaleAspectFit

        addCardBtn.rounded()
        content.layer.cornerRadius = 8
        
        animationView.loopMode = .loop
        animationView.backgroundColor = UIColor.init(hex: "1C1C1C")
        animationView.animationSpeed = 1
        animationView.play()
    }

    @IBAction func addCard(_ sender: Any) {
        self.didTapAdd?()
    }
}
