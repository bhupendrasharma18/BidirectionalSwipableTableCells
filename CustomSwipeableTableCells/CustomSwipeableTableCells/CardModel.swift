//
//  CardModel.swift
//  CustomSwipeableTableCells
//
//  Created by Bhupendra Sharma on 07/05/20.
//  Copyright © 2020 Bhupendra. All rights reserved.
//

import Foundation

struct CardModel {
    var cardNumber: String!
    var nameOnCard: String!
    
    init(cardNumber: String!, name: String!) {
        self.cardNumber = cardNumber
        self.nameOnCard = name
    }
}
