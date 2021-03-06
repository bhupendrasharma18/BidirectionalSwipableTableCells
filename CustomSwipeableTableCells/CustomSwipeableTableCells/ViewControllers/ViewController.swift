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
    var viewModel: CardsListViewModel?
    var isSwipeHintCompleted: Bool = false
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color172027
        configureTableView()
        viewModel = CardsListViewModel()
        viewModel?.reloadTable = { [weak self] in
            self?.tblView.reloadData()
        }
    }
    
    private func configureTableView() {
        tblView.backgroundColor = color172027
        tblView.register(UINib.init(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: cardCellIdentifier)
        tblView.rowHeight = 200.0
        tblView.separatorStyle = .none
    }
    
    // MARK:- User Interactions
    /* cardDidSwipe: updates the indexPath to keep track of recent swiped cell */
    private func cardDidSwipe(in cell: CardCell) {
        if let indexPath = tblView.indexPath(for: cell) {
            if let lastIndexPath = lastSwipedIndexPath, lastIndexPath != indexPath {
                resetRecentCardCell()
            }
            lastSwipedIndexPath = indexPath
        }
    }
    
    private func actionItemClicked(title: String?, message: String?) {
        let alertController = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK:-
    /* resetRecentCardCell - method will reset swipe of the cell for lastSwipedIndexPath */
    private func resetRecentCardCell() {
        if let lastIndexPath = lastSwipedIndexPath {
            if let lastCell: CardCell = tblView.cellForRow(at: lastIndexPath) as? CardCell {
                lastCell.viewCard.resetCardView()
            }
        }
    }
    
    /* animateSwipeView - will render swipe and back animation for cells one to give hint of swipable cells */
    @objc private func animateSwipeView(indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        if let cell: CardCell = tblView.cellForRow(at: indexPath) as? CardCell {
            cell.viewCard.swipeLeftAndReset()
        }
        isSwipeHintCompleted = true
        tblView.isUserInteractionEnabled = true
//        if UserDefaults.standard.object(forKey: "SwipeAnimation") == nil {
//            UserDefaults.standard.set("SwipeAnimation", forKey: "SwipeAnimation")
//        }
    }

}

// MARK:- UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardCell = tableView.dequeueReusableCell(withIdentifier: cardCellIdentifier) as! CardCell
        cell.selectionStyle = .none
        if indexPath.row < viewModel?.cards?.count ?? 0 {
            cell.cardViewModel = viewModel?.cards?[indexPath.row]
        }
        cell.cardDidSwipeInCell = { [weak self] in
            self?.cardDidSwipe(in: cell)
        }
        cell.actionItemClicked = { [weak self] (title: String?, message: String?) in
            self?.actionItemClicked(title: title, message: message)
        }
        return cell
    }

}

// MARK:- UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if UserDefaults.standard.object(forKey: "SwipeAnimation") == nil {
//            timeDelay += 0.1
//            self.perform(#selector(animateSwipeView), with: indexPath, afterDelay: timeDelay)
//        }
        if !isSwipeHintCompleted {
            timeDelay += 0.1
            tblView.isUserInteractionEnabled = false //Used to avoid interaction during autoswiping on app launch
            self.perform(#selector(animateSwipeView), with: indexPath, afterDelay: timeDelay)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK:- UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    /* This will reset last swiped cardCell when tableView is scrolled */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resetRecentCardCell()
    }
}
