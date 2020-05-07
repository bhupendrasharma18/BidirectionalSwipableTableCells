//
//  ViewController.swift
//  CustomSwipeableTableCells
//
//  Created by Bhupendra Sharma on 07/05/20.
//  Copyright © 2020 Bhupendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    let cardCellIdentifier = "CardCellIdentifier"
    var timeDelay = 1.0
    var lastSwipedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = color172027
        configureTableView()
    }
    
    private func configureTableView() {
        tblView.backgroundColor = color172027
        tblView.register(UINib.init(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: cardCellIdentifier)
        tblView.rowHeight = 200.0
        tblView.separatorStyle = .none
    }
    
    private func cardDidSwipe(in cell: CardCell) {
        if let indexPath = tblView.indexPath(for: cell) {
            if let lastIndexPath = lastSwipedIndexPath, lastIndexPath != indexPath {
                resetRecentCardCell()
            }
            lastSwipedIndexPath = indexPath
        }
    }
    
    private func resetRecentCardCell() {
        if let lastIndexpath = lastSwipedIndexPath {
            if let lastCell: CardCell = tblView.cellForRow(at: lastIndexpath) as? CardCell {
                lastCell.viewCard.resetCardView()
            }
        }
    }
    
    @objc private func animateSwipeView(indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        if let cell: CardCell = tblView.cellForRow(at: indexPath) as? CardCell {
            cell.viewCard.swipeLeftAndReset()
        }
        if UserDefaults.standard.object(forKey: "SwipeAnimation") == nil {
            UserDefaults.standard.set("SwipeAnimation", forKey: "SwipeAnimation")
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardCell = tableView.dequeueReusableCell(withIdentifier: cardCellIdentifier) as! CardCell
        cell.selectionStyle = .none
        cell.cardDidSwipeInCell = { [weak self] in
            self?.cardDidSwipe(in: cell)
        }
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if UserDefaults.standard.object(forKey: "SwipeAnimation") == nil {
            timeDelay += 0.1
            self.perform(#selector(animateSwipeView), with: indexPath, afterDelay: timeDelay)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
