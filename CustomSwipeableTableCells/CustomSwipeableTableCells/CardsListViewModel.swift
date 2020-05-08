//
//  CardsListViewModel.swift
//  CustomSwipeableTableCells
//
//  Created by Bhupendra Sharma on 07/05/20.
//  Copyright © 2020 Bhupendra. All rights reserved.
//

import UIKit

enum ActionItem {
    case payNow
    case viewDetails
    case transactions
}

class CardsListViewModel: NSObject {
    var reloadTable: (() -> Void)?
    var cards: [CardViewModel]?
    
    override init() {
        super.init()
        createData()
    }
    
    /* Create mock data for Cards and reload tableView */
    private func createData() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            for i in 1...10 {
                let card = CardModel.init(cardNumber: "438\(i) XXXX XXXX 056\(i)", name: "Bhupendra\(i) Sharma")
                let actionItemsCount = (i % 3) + 1
                var arr = [ActionItem]()
                while arr.count < actionItemsCount {
                    switch arr.count {
                    case 0:
                        arr.append(.payNow)
                    case 1:
                        arr.append(.viewDetails)
                    case 2:
                        arr.append(.transactions)
                    default:
                        break
                    }
                }
                
                let cardViewModel = CardViewModel.init(card: card, actionItems: arr)
                if self.cards == nil {
                    self.cards = [CardViewModel]()
                }
                self.cards?.append(cardViewModel)
            }
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    private func reloadData() {
        if reloadTable != nil {
            reloadTable!()
        }
    }
}
