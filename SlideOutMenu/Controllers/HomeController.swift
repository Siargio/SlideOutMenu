//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Sergio on 21.02.23.
//

import UIKit

final class HomeController: UITableViewController {

    //MARK: - Property

    let menuController = MenuController()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .red
        setupNavigationItems()

    }

    //MARK: - Setups

    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }

    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.closeMenu()
    }

    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.titleView?.backgroundColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
}

//MARK: - Extensions

extension HomeController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        cell.textLabel?.text = "Row: \(indexPath.row)"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        return cell
    }
}
