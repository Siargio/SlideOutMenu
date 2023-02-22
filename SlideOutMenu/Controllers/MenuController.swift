//
//  MenuController.swift
//  SlideOutMenu
//
//  Created by Sergio on 21.02.23.
//

import UIKit

final class MenuController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.backgroundColor = .blue
    }
}

extension MenuController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        cell.textLabel?.text = "Menu Item Row: \(indexPath.row)"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        return cell
    }
}
