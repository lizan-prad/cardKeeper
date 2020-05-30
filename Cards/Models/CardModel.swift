//
//  CardModel.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/30/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//

import Foundation
import ObjectMapper

class CardModel: Mappable {
    
    var number: String?
    var expiry: String?
    var name: String?
    var cvc: String?
    var cardType: String?
    var skin: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        number <- map["CardNo"]
        expiry <- map["expData"]
        name <- map["Name"]
        cvc <- map["CSC"]
        cardType <- map["cardType"]
        skin <- map["skin"]
    }
}
