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

class SwipeableView: UIView {
    
    var xFromCenter: CGFloat!
    var originalPoint: CGPoint!
    var swipeState: SwipeState = .normal
    
    var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
            
    let duration = 0.2
    let swipingScaleX: CGFloat = UIScreen.main.bounds.size.width / 2//130.0
    
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
                    swipeLeft()
                }
                else if swipeState == .right {
                    resetCardView()
                }
            }
            if gestureRecognizer == rightSwipeGestureRecognizer {
                if swipeState == .normal {
                    swipeState = .right
                    swipeRight()
                }
                else if swipeState == .left {
                    resetCardView()
                }
            }
        }
    }
    
    func resetCardView() {
        swipeState = .normal
        if originalPoint == nil {
            return
        }
        UIView.animate(withDuration: duration) {
            self.center = self.originalPoint
        }
    }
    
    private func swipeLeft() {
        let finishPoint = CGPoint.init(x: originalPoint.x - swipingScaleX, y: originalPoint.y)
        UIView.animate(withDuration: duration) {
            self.center = finishPoint
        }
    }
    
    private func swipeRight() {
        let finishPoint = CGPoint.init(x: originalPoint.x + swipingScaleX, y: originalPoint.y)
        UIView.animate(withDuration: duration) {
            self.center = finishPoint
        }
    }
}
