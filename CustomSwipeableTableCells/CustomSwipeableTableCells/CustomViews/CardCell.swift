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
    
    var viewActionItems: UIView!
    var centerConstraintViewAction: NSLayoutConstraint!
    let heightViewActionItems: CGFloat = 180
    let widthViewActionItems: CGFloat = UIScreen.main.bounds.size.width / 2 - 50
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellAppearances()
        viewCard.delegate = self
        createActionItemsView()
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
    
    private func createActionItemsView() {
        viewActionItems = UIView.init()
        viewContainer.addSubview(viewActionItems)
//        viewActionItems.backgroundColor = .red
        viewActionItems.translatesAutoresizingMaskIntoConstraints = false
        Constraints.verticalConstraint(control: viewActionItems, parent: viewContainer, constant: 0)
        Constraints.widthConstraint(control: viewActionItems, controlWidth: widthViewActionItems)
        Constraints.heightConstraint(control: viewActionItems, controlHeight: heightViewActionItems)
        centerConstraintViewAction = NSLayoutConstraint(item: viewActionItems!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewContainer, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 100)
        viewContainer.addConstraint(centerConstraintViewAction)
        viewContainer.bringSubviewToFront(viewCard)
    }

}

extension CardCell: SwipeableViewDelegate {
    func cardDidSwipe() {
        if cardDidSwipeInCell != nil {
            cardDidSwipeInCell!()
        }
    }
    
    func cardWillSwipe(state: SwipeState) {
        self.centerConstraintViewAction.constant = (state == .left) ? 100 : -100
        UIView.animate(withDuration: 0.05) {
            self.viewContainer.layoutIfNeeded()
        }
    }
}
