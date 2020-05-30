//
//  CardTableViewCell.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/30/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var cardNum: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var expDate: UILabel!
    @IBOutlet weak var skin: UIImageView!
    @IBOutlet weak var cardImg: UIImageView!
    
    var model: CardModel? {
        didSet {
            container.layer.cornerRadius = 8
            cardNum.text = model?.number?.mask(prefix: 7)
            name.text = model?.name
            expDate.text = model?.expiry
            skin.image = UIImage.init(named: model?.skin ?? "")
            cardImg.image = model?.cardType?.getCardLogo()
        }
    }

}

extension String {
    
    func mask(prefix: Int) -> String {
        return (self.enumerated().map { (index,elem) in
            if (index + 1) > prefix {
                return elem == " " ? " " : "*"
            } else {
                return "\(elem)"
            }
        }).joined()
    }
    
    func getCardLogo() -> UIImage? {
        switch self {
        case "Discover":
            return UIImage.init(named: "discover")
        case "Master Card":
            return UIImage.init(named: "mastercard")
        case "American Express":
            return UIImage.init(named: "amex")
        case "Visa":
            return UIImage.init(named: "visa")
        default:
            return nil
        }
    }
}
