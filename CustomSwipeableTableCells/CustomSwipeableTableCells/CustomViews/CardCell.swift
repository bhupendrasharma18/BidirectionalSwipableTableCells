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
    @IBOutlet weak var lblName: UILabel!
    var cardDidSwipeInCell: (() -> Void)?
    var actionItemClicked: ((_ title: String?, _ message: String?) -> Void)?
    
    var viewActionItems: UIView!
    var centerConstraintViewAction: NSLayoutConstraint!
    let widthViewActionItems: CGFloat = UIScreen.main.bounds.size.width / 2 - 50
    
    let VIEW_ACTION_HEIGHT: CGFloat = 180
    let BUTTON_HEIGHT: CGFloat = 44
    let MIDDLE_SPACING: CGFloat = 5
    
    var cardViewModel: CardViewModel? {
        didSet {
            guard let card = cardViewModel  else { return }
            lblCardNumber.text = "\(card.cardNumber ?? "XXXX XXXX XXXX XXXX")"
            lblName.text = "\(card.nameOnCard ?? "")"
            createActionButtons()
        }
    }
    
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
        Constraints.heightConstraint(control: viewActionItems, controlHeight: VIEW_ACTION_HEIGHT)
        centerConstraintViewAction = NSLayoutConstraint(item: viewActionItems!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewContainer, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 100)
        viewContainer.addConstraint(centerConstraintViewAction)
        viewContainer.bringSubviewToFront(viewCard)
    }
    
    private func createActionButtons() {
        for subView in viewActionItems.subviews {
            subView.removeFromSuperview()
        }

        if let actionItems = cardViewModel?.actionItems, actionItems.count > 0 {
            let topSpacing: CGFloat = (VIEW_ACTION_HEIGHT - (CGFloat(actionItems.count) * BUTTON_HEIGHT) - (CGFloat(actionItems.count - 1) *  MIDDLE_SPACING)) / 2
            var tempBtn: UIButton?
            for index in 0..<actionItems.count {
                let actionItem = actionItems[index]
                let btn = UIButton()
                viewActionItems.addSubview(btn)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                btn.setTitleColor(.gray, for: .highlighted)
                btn.translatesAutoresizingMaskIntoConstraints = false
                btn.addTarget(self, action: #selector(actionButtonClicked(_:)), for: .touchUpInside)
                btn.tag = index
                var btnTitle = ""
                switch actionItem {
                case .payNow:
                    btnTitle = "Pay Now"
                case .viewDetails:
                    btnTitle = "View Details"
                case .transactions:
                    btnTitle = "Transactions"
                }
                btn.setTitle(btnTitle, for: .normal)
                
                Constraints.widthConstraint(control: btn, controlWidth: 100)
                Constraints.heightConstraint(control: btn, controlHeight: BUTTON_HEIGHT)
                Constraints.horizontalConstraint(control: btn, parent: viewActionItems, constant: 0)
                if let tmpBtn = tempBtn {
                    viewActionItems.addConstraint(NSLayoutConstraint(item: btn, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: tmpBtn, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: MIDDLE_SPACING))
                }
                else {
                    Constraints.topConstraint(control: btn, parent: viewActionItems, constant: topSpacing)
                }
                
                tempBtn = btn
            }
        }
        
    }
    
    @objc func actionButtonClicked(_ sender: UIButton!) {
        let index = sender.tag
        if let items = cardViewModel?.actionItems, index < items.count {
            var title = ""
            var message = ""
            switch items[index] {
            case .payNow:
                title = "Pay Now"
                message = "Proceed to pay utility bills"
            case .viewDetails:
                title = "View Details"
                message = "Proceed to view card details"
            case .transactions:
                title = "Transactions"
                message = "Proceed to see all transactions from this card"
            }
            if actionItemClicked != nil {
                actionItemClicked!(title, message)
            }
        }
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
