//
//  CardCell.swift
//  CustomSwipeableTableCells
//
//  Created by Bhupendra Sharma on 07/05/20.
//  Copyright © 2020 Bhupendra. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewCard: SwipeableView!
    @IBOutlet weak var lblCardNumber: UILabel!
    var cardDidSwipeInCell: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellAppearances()
        viewCard.delegate = self
    }
    
    private func cellAppearances() {
        self.backgroundColor = color172027
        viewContainer.backgroundColor = color293445
        viewCard.backgroundColor = color110145132
        
        viewContainer.clipsToBounds = true

        viewContainer.layer.cornerRadius = 8.0
        viewContainer.layer.shadowRadius = 10.0
        viewContainer.layer.shadowOpacity = 0.9
        viewContainer.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        
        viewCard.layer.cornerRadius = 8.0
        viewCard.layer.shadowRadius = 3.0
        viewCard.layer.shadowOpacity = 0.5
        viewCard.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CardCell: SwipeableViewDelegate {
    func cardDidSwipe() {
        if cardDidSwipeInCell != nil {
            cardDidSwipeInCell!()
        }
    }
}
