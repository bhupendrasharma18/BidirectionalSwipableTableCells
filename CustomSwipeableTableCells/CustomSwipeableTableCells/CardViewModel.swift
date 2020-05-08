//
//  CardViewModel.swift
//  CustomSwipeableTableCells
//
//  Created by Bhupendra Sharma on 07/05/20.
//  Copyright © 2020 Bhupendra. All rights reserved.
//

import Foundation

struct CardViewModel {
    var cardNumber: String!
    var nameOnCard: String!
    var actionItems: [ActionItem]?
    
    init(card: CardModel?, actionItems: [ActionItem]?) {
        self.cardNumber = card?.cardNumber
        self.nameOnCard = card?.nameOnCard
        self.actionItems = actionItems
    }
}
