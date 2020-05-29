 //
//  DashboardViewController.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/29/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit
import Lottie
 
class DashboardViewController: UIViewController {

    @IBOutlet weak var cardAnimation: AnimationView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var addCardBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        animationView.contentMode = .scaleAspectFit
        
        // 2. Set animation loop mode
        let img = UIImageView()
        img.image = UIImage.init(named: "title")
        img.contentMode = .scaleAspectFit
        self.navigationItem.titleView = img
        
        addCardBtn.rounded()
        content.layer.cornerRadius = 8
        
//        animationView.loopMode = .autoReverse
//        animationView.backgroundColor = UIColor.init(hex: "131318")
//        animationView.animationSpeed = 0.5
//        animationView.play()
        
        cardAnimation.loopMode = .loop
        cardAnimation.backgroundColor = UIColor.init(hex: "1C1C1C")
        cardAnimation.animationSpeed = 1
        cardAnimation.play()
        
    }
    
    @IBAction func addCardAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "NewCard", bundle: nil).instantiateViewController(withIdentifier: "NewCardViewController") as! NewCardViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
