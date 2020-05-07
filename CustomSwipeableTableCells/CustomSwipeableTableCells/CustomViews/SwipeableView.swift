//
//  SwipeableView.swift
//  CustomSwipeableTableCells
//
//  Created by Bhupendra Sharma on 07/05/20.
//  Copyright © 2020 Bhupendra. All rights reserved.
//

import UIKit

enum SwipeState {
    case normal
    case left
    case right
}

protocol SwipeableViewDelegate: class {
    func cardDidSwipe()
    func cardWillSwipe(state: SwipeState)
}

class SwipeableView: UIView {
    
    var xFromCenter: CGFloat!
    var originalPoint: CGPoint!
    var swipeState: SwipeState = .normal
    
    var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
            
    let duration = 0.2
    let swipingScaleX: CGFloat = UIScreen.main.bounds.size.width / 2
    
    weak var delegate: SwipeableViewDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addPanGesture()
    }
    
    private func addPanGesture() {
        leftSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(self.handleSwipe(_:)))
        leftSwipeGestureRecognizer.direction = .left
        addGestureRecognizer(leftSwipeGestureRecognizer)

        rightSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(self.handleSwipe(_:)))
        addGestureRecognizer(rightSwipeGestureRecognizer)
    }
        
    @objc func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            if originalPoint == nil {
                originalPoint = center
            }
            if gestureRecognizer == leftSwipeGestureRecognizer {
                if swipeState == .normal {
                    swipeState = .left
                    delegate?.cardWillSwipe(state: swipeState)
                    animateView(for: originalPoint.x - swipingScaleX)
                    delegate?.cardDidSwipe()
                }
                else if swipeState == .right {
                    resetCardView()
                }
            }
            if gestureRecognizer == rightSwipeGestureRecognizer {
                if swipeState == .normal {
                    swipeState = .right
                    delegate?.cardWillSwipe(state: swipeState)
                    animateView(for: originalPoint.x + swipingScaleX)
                    delegate?.cardDidSwipe()
                }
                else if swipeState == .left {
                    resetCardView()
                }
            }
        }
    }
    
    /* animateView- animates the card for the left, right or center according to new x point */
    private func animateView(for pointX: CGFloat) {
        UIView.animate(withDuration: duration) {
            self.center = CGPoint(x: pointX, y: self.originalPoint.y)
        }
    }
    
    /* Brings card view in its original position and sets swipeState to normal */
    func resetCardView() {
        swipeState = .normal
        if originalPoint == nil {
            return
        }
        animateView(for: originalPoint.x)
    }
    
    func swipeLeftAndReset() {
        originalPoint = center
        let finishPoint = CGPoint.init(x: originalPoint.x - swipingScaleX, y: originalPoint.y)
        UIView.animate(withDuration: duration, animations: {
            self.center = finishPoint
        }) { (completed: Bool) in
            self.resetCardView()
        }
    }
    
}
