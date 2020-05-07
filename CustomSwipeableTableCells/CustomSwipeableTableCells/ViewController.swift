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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
    }
    
    private func configureTableView() {
        tblView.backgroundColor = color172027
        tblView.register(UINib.init(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: cardCellIdentifier)
        tblView.rowHeight = 200.0
        tblView.separatorStyle = .none
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
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
