//
//  Constraints.swift
//  SwipeAnimation
//
//  Created by Bhupendra Sharma on 05/05/20.
//  Copyright © 2020 Bhupendra. All rights reserved.
//

import UIKit

class Constraints: NSObject {

    class func widthConstraint(control: UIView, controlWidth: CGFloat) {
        let widthConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: controlWidth)
        control.addConstraint(widthConstraint)
    }
    
    class func heightConstraint(control: UIView, controlHeight: CGFloat) {
        let heightConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: controlHeight)
        control.addConstraint(heightConstraint)
    }
    
    class func bottomConstraint(control: UIView, parent: UIView, constant: CGFloat) {
        let bottomConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parent, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: constant)
        parent.addConstraint(bottomConstraint)
    }
    
    class func topConstraint(control: UIView, parent: UIView, constant: CGFloat) {
        let topConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parent, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: constant)
        parent.addConstraint(topConstraint)
    }
    
    class func trailingConstraint(control: UIView, parent: UIView, constant: CGFloat) {
        let trailingConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parent, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: constant)
        parent.addConstraint(trailingConstraint)
    }
    
    class func leadingConstraint(control: UIView, parent: UIView, constant: CGFloat) {
        let leadingConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parent, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: constant)
        parent.addConstraint(leadingConstraint)
    }
    
    class func horizontalConstraint(control: UIView, parent: UIView, constant: CGFloat) {
        let bottomConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parent, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: constant)
        parent.addConstraint(bottomConstraint)
    }
    
    class func verticalConstraint(control: UIView, parent: UIView, constant: CGFloat) {
        let bottomConstraint = NSLayoutConstraint(item: control, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parent, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: constant)
        parent.addConstraint(bottomConstraint)
    }
    
}
