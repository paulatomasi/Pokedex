//
//  MovesListViewController.swift
//  Pokedex
//
//  Created by Paula Tomasi Andrade on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MovesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let requestMaker = RequestMaker()
    var moveList = [Move]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTable()
        
        self.fetchData()
    }
    
    private func configTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self 
    }
}

extension MovesListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = self.storyboard
        if let moveDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MoveDetailViewController") {
            self.navigationController?.present(moveDetailViewController, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension MovesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moveList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "move", for: indexPath)

        if let moveCell = cell as? MoveTableViewCell {
            moveCell.config(with: self.moveList[indexPath.row])
        }

        return cell
    }
}

extension MovesListViewController {
    func fetchData() {
        requestMaker.make(withEndpoint: .moves) {
            (moveList: [Move]) in
            self.moveList = moveList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
