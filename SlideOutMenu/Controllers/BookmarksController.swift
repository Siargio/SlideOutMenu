//
//  BookmarksController.swift
//  SlideOutMenu
//
//  Created by Sergio on 24.02.23.
//

import UIKit

class BookmarksController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .blue

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel?.text = "adfadafaf \(indexPath.row)"
        return cell
    }
}
