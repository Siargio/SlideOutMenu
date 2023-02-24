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
        15
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
     //  tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        cell.textLabel?.text = "adfadafaf \(indexPath.row)"
        return cell
    }


}
